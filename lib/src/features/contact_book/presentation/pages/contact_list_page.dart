import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/presentation/cubit/contact_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class ContactListPage extends StatefulWidget implements AutoRouteWrapper {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactCubit>()..loadContacts(),
      child: this,
    );
  }
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _favoritesOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reloadContacts() {
    final q = _searchController.text.trim();
    if (q.isEmpty && !_favoritesOnly) {
      context.read<ContactCubit>().loadContacts();
      return;
    }
    context.read<ContactCubit>().loadContacts(
          params: ContactQueryParams(
            search: q.isEmpty ? null : q,
            isFavorite: _favoritesOnly ? true : null,
          ),
        );
  }

  Future<void> _openNewContact() async {
    await context.router.push(ContactFormRoute(contact: null));
    if (mounted) {
      _reloadContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(context.l10n.contacts),
        centerTitle: false,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: _favoritesOnly ? context.l10n.contactShowAll : context.l10n.contactFavoritesOnly,
            icon: Icon(
              _favoritesOnly ? Icons.star_rounded : Icons.star_border_rounded,
              color: _favoritesOnly ? scheme.tertiary : scheme.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() => _favoritesOnly = !_favoritesOnly);
              _reloadContacts();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, _) {
                return TextField(
                  controller: _searchController,
                  onChanged: (_) => _reloadContacts(),
                  decoration: InputDecoration(
                    hintText: context.l10n.contactSearchHint,
                    hintStyle: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                    prefixIcon: AppSearchIcon.inputDecoration(
                      size: 22,
                      color: scheme.onSurfaceVariant,
                    ),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: scheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _reloadContacts();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: scheme.surfaceContainerHighest,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: primary.withOpacity(0.12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: primary.withOpacity(0.12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: primary, width: 1.5),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ContactCubit, ContactState>(
              builder: (context, state) {
                return state.when(
                  initial: () => _buildLoadingBody(context),
                  loading: () => _buildLoadingBody(context),
                  noInternet: () => _buildMessageBody(
                    context,
                    icon: Icons.wifi_off_rounded,
                    title: context.l10n.contactNoConnection,
                    subtitle: context.l10n.contactCheckNetwork,
                    action: TextButton.icon(
                      onPressed: _reloadContacts,
                      icon: Icon(Icons.refresh_rounded, size: 20, color: scheme.primary),
                      label: Text(context.l10n.retry, style: AppFonts.interStyle(color: scheme.primary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  error: (message) => _buildMessageBody(
                    context,
                    icon: Icons.error_outline_rounded,
                    title: context.l10n.contactSomethingWrong,
                    subtitle: message,
                    action: TextButton.icon(
                      onPressed: _reloadContacts,
                      icon: Icon(Icons.refresh_rounded, size: 20, color: scheme.primary),
                      label: Text(context.l10n.retry, style: AppFonts.interStyle(color: scheme.primary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  listLoaded: (response) {
                    final list = response.contacts;
                    if (list.isEmpty) {
                      return _centeredBody(
                        ListEmptyState(
                          illustrationPath: AppEmptyStateAssets.contacts,
                          title: context.l10n.contactNoContacts,
                          subtitle: _favoritesOnly
                              ? context.l10n.contactNoFavorites
                              : context.l10n.contactTrySearchOrAdd,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: list.length + 1,
                      itemBuilder: (context, index) {
                        if (index == list.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 8),
                            child: Center(
                              child: Text(
                                context.l10n.contactEndOfList,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                              ),
                            ),
                          );
                        }
                        final c = list[index];
                        return _ContactTile(
                          contact: c,
                          onTap: () async {
                            await context.router.push(
                              ContactFormRoute(contact: c),
                            );
                            if (context.mounted) {
                              _reloadContacts();
                            }
                          },
                        );
                      },
                    );
                  },
                  contactLoaded: (_) => const SizedBox.shrink(),
                  created: (_) => const SizedBox.shrink(),
                  updated: () => const SizedBox.shrink(),
                  deleted: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openNewContact,
        tooltip: context.l10n.contactNewTooltip,
        elevation: 4,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Icon(Icons.person_add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    return _centeredBody(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: s.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.contactLoading,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: s.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  /// Fills the area below the search bar and centers content (empty, loading, errors).
  Widget _centeredBody(Widget child) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: child),
    );
  }

  Widget _buildMessageBody(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? action,
  }) {
    final s = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final primary = s.primary;

    return _centeredBody(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Color.alphaBlend(primary.withValues(alpha: 0.06), s.surface),
                shape: BoxShape.circle,
                border: Border.all(color: primary.withOpacity(0.12)),
              ),
              child: Icon(icon, size: 36, color: s.onSurfaceVariant.withOpacity(0.85)),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: tt.bodyMedium?.copyWith(color: s.onSurfaceVariant, height: 1.4),
            ),
            if (action != null) ...[
              const SizedBox(height: 20),
              action,
            ],
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.contact,
    required this.onTap,
  });

  final ContactModel contact;
  final VoidCallback onTap;

  Future<void> _launchCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final name = contact.name ?? context.l10n.contactUnknown;
    final hasPhone = contact.phone != null && contact.phone!.trim().isNotEmpty;
    final subtitle = [
      if (hasPhone) contact.phone,
      if (contact.email != null && contact.email!.isNotEmpty) contact.email,
      if (contact.company != null && contact.company!.isNotEmpty) contact.company,
    ].where((e) => e != null).join(' · ');

    final primary = scheme.primary;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: primary.withOpacity(0.10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: scheme.primaryContainer,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: textTheme.titleMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (contact.isFavorite)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(Icons.star_rounded, size: 18, color: scheme.tertiary),
                            ),
                        ],
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (hasPhone)
                  IconButton(
                    tooltip: context.l10n.contactCallTooltip,
                    icon: Icon(Icons.call_rounded, color: scheme.primary, size: 22),
                    onPressed: () => _launchCall(contact.phone!.trim()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
