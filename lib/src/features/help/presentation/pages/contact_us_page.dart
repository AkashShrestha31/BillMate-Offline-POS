import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/platform_app_localizations.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/more_settings_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Developer contact details shown from More → Contact us.
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  static const developerName = 'Akash Shrestha';
  static const developerEmail = 'ak.shrestha2052@gmail.com';
  static const maxAttachmentBytes = 25 * 1024 * 1024;
  static const maxPhotos = 5;
  static const maxVideos = 1;

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _attachments = <_ContactAttachment>[];
  final ImagePicker _picker = ImagePicker();
  bool _sending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.contactUsMessageRequired;
    }
    return null;
  }

  int get _photoCount => _attachments.where((a) => !a.isVideo).length;

  bool get _hasVideo => _attachments.any((a) => a.isVideo);

  Future<void> _pickPhotos() async {
    final remaining = ContactUsPage.maxPhotos - _photoCount;
    if (remaining <= 0) {
      if (!mounted) return;
      context.showKiiSnackBarError(
        context.l10n.contactUsAddPhotoLimit(ContactUsPage.maxPhotos),
      );
      return;
    }

    try {
      final files = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
        limit: remaining,
      );
      if (!mounted || files.isEmpty) return;
      for (final file in files) {
        if (_photoCount >= ContactUsPage.maxPhotos) break;
        await _addAttachment(file.path, isVideo: false);
      }
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(context.l10n.couldNotPickImage(e.toString()));
    }
  }

  Future<void> _pickVideo() async {
    if (_hasVideo) {
      if (!mounted) return;
      context.showKiiSnackBarError(context.l10n.contactUsVideoLimit);
      return;
    }

    try {
      final file = await _picker.pickVideo(source: ImageSource.gallery);
      if (file == null || !mounted) return;
      await _addAttachment(file.path, isVideo: true);
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(context.l10n.couldNotPickVideo(e.toString()));
    }
  }

  Future<void> _addAttachment(String path, {required bool isVideo}) async {
    if (isVideo && _hasVideo) {
      if (!mounted) return;
      context.showKiiSnackBarError(context.l10n.contactUsVideoLimit);
      return;
    }
    if (!isVideo && _photoCount >= ContactUsPage.maxPhotos) {
      if (!mounted) return;
      context.showKiiSnackBarError(
        context.l10n.contactUsAddPhotoLimit(ContactUsPage.maxPhotos),
      );
      return;
    }
    final file = File(path);
    if (!await file.exists()) return;

    final size = await file.length();
    if (size > ContactUsPage.maxAttachmentBytes) {
      if (!mounted) return;
      context.showKiiSnackBarError(
        context.l10n.contactUsAttachmentTooLarge(25),
      );
      return;
    }

    setState(() {
      _attachments.add(
        _ContactAttachment(
          path: path,
          name: _fileName(path),
          isVideo: isVideo,
        ),
      );
    });
  }

  void _removeAttachment(int index) {
    setState(() => _attachments.removeAt(index));
  }

  String _fileName(String path) {
    final normalized = path.replaceAll(r'\', '/');
    final index = normalized.lastIndexOf('/');
    return index >= 0 ? normalized.substring(index + 1) : normalized;
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(
      const ClipboardData(text: ContactUsPage.developerEmail),
    );
    if (!mounted) return;
    context.showKiiSnackBarSuccess(context.l10n.emailCopiedToClipboard);
  }

  Future<String> _composeEmailBody(String appName) async {
    final message = _messageController.text.trim();
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version.trim();
    final build = packageInfo.buildNumber.trim();
    final versionLabel = build.isEmpty ? version : '$version+$build';

    return '$message\n\n---\n$appName $versionLabel';
  }

  Future<void> _fallbackMailto(String body, String subject) async {
    final uri = Uri(
      scheme: 'mailto',
      path: ContactUsPage.developerEmail,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (launched || !mounted) return;
    await Clipboard.setData(const ClipboardData(text: ContactUsPage.developerEmail));
    if (!mounted) return;
    context.showKiiSnackBarError(context.l10n.contactUsNoEmailApp);
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _sending = true);
    final l10n = context.l10n;
    final subject = '${l10n.platformAppDisplayName} support';
    try {
      final body = await _composeEmailBody(l10n.platformAppDisplayName);
      final attachmentPaths =
          _attachments.map((a) => a.path).toList(growable: false);

      await FlutterEmailSender.send(
        Email(
          body: body,
          subject: subject,
          recipients: [ContactUsPage.developerEmail],
          attachmentPaths: attachmentPaths.isEmpty ? null : attachmentPaths,
        ),
      );
    } on PlatformException catch (e) {
      if (!mounted) return;
      final body = await _composeEmailBody(l10n.platformAppDisplayName);
      if (!mounted) return;
      if (_attachments.isEmpty) {
        await _fallbackMailto(body, subject);
      } else {
        context.showKiiSnackBarError(
          l10n.contactUsEmailFailed(e.message ?? e.code),
        );
      }
    } catch (e) {
      if (!mounted) return;
      context.showKiiSnackBarError(l10n.contactUsEmailFailed(e.toString()));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final hPad = MoreSettingsLayout.horizontalPadding(
      context,
      context.theme.appTheme.spacing16,
    );
    final gap = MoreSettingsLayout.sz(context, 24, 24.h);
    final buttonHeight = MoreSettingsLayout.sz(context, 48, 45.h);

    return Scaffold(
      backgroundColor: MoreSettingsLayout.background(scheme),
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(l10n.contactUs),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 28),
          children: [
            Text(
              l10n.contactUsSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: gap),
            MoreSectionLabel(l10n.developerLabel),
            MoreSettingsCard(
              children: [
                ListTile(
                  contentPadding: MoreSettingsLayout.tilePadding(context),
                  leading: const MoreIconBox(icon: Icons.person_outline_rounded),
                  title: Text(
                    l10n.developerLabel,
                    style: MoreSettingsLayout.tileTitle(theme),
                  ),
                  subtitle: Text(
                    ContactUsPage.developerName,
                    style: MoreSettingsLayout.tileSubtitle(theme),
                  ),
                ),
                ListTile(
                  contentPadding: MoreSettingsLayout.tilePadding(context),
                  leading: const MoreIconBox(icon: Icons.mail_outline_rounded),
                  title: Text(
                    l10n.email,
                    style: MoreSettingsLayout.tileTitle(theme),
                  ),
                  subtitle: Text(
                    ContactUsPage.developerEmail,
                    style: MoreSettingsLayout.tileSubtitle(theme)?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    Icons.copy_rounded,
                    size: MoreSettingsLayout.chevronSize(context),
                    color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  onTap: _copyEmail,
                ),
              ],
            ),
            SizedBox(height: gap),
            MoreSectionLabel(l10n.contactUsMessageLabel),
            Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(
                  MoreSettingsLayout.cardRadius(context),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                MoreSettingsLayout.sz(context, 16, 16.w),
                MoreSettingsLayout.sz(context, 16, 16.h),
                MoreSettingsLayout.sz(context, 16, 16.w),
                MoreSettingsLayout.sz(context, 16, 16.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: _messageController,
                    labelText: l10n.contactUsMessageLabel,
                    hint: l10n.contactUsMessageHint,
                    minLines: 5,
                    maxLines: 10,
                    height: null,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    validating: _validateMessage,
                  ),
                  SizedBox(height: MoreSettingsLayout.sz(context, 20, 16.h)),
                  Text(
                    l10n.contactUsAttachments,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MoreSettingsLayout.sz(context, 10, 10.h)),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget.outlined(
                          height: buttonHeight,
                          borderRadius: MoreSettingsLayout.sz(context, 10, 10.r),
                          onPressed: (_sending ||
                                  _photoCount >= ContactUsPage.maxPhotos)
                              ? null
                              : _pickPhotos,
                          title: l10n.contactUsAddPhoto,
                          icon: Icon(
                            Icons.photo_outlined,
                            size: 18,
                            color: scheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: MoreSettingsLayout.sz(context, 10, 10.w)),
                      Expanded(
                        child: CustomButtonWidget.outlined(
                          height: buttonHeight,
                          borderRadius: MoreSettingsLayout.sz(context, 10, 10.r),
                          onPressed: (_sending || _hasVideo) ? null : _pickVideo,
                          title: l10n.contactUsAddVideo,
                          icon: Icon(
                            Icons.videocam_outlined,
                            size: 18,
                            color: scheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_attachments.isNotEmpty) ...[
                    SizedBox(height: MoreSettingsLayout.sz(context, 12, 12.h)),
                    ...List.generate(_attachments.length, (index) {
                      final attachment = _attachments[index];
                      return _AttachmentTile(
                        attachment: attachment,
                        onRemove:
                            _sending ? null : () => _removeAttachment(index),
                      );
                    }),
                  ],
                  SizedBox(height: MoreSettingsLayout.sz(context, 20, 20.h)),
                  CustomButtonWidget(
                    title: l10n.contactUsSendEmail,
                    loading: _sending,
                    onPressed: _sending ? null : _sendEmail,
                    width: double.infinity,
                    height: buttonHeight,
                    borderRadius: MoreSettingsLayout.sz(context, 10, 10.r),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactAttachment {
  const _ContactAttachment({
    required this.path,
    required this.name,
    required this.isVideo,
  });

  final String path;
  final String name;
  final bool isVideo;
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({
    required this.attachment,
    required this.onRemove,
  });

  final _ContactAttachment attachment;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: MoreSettingsLayout.sz(context, 8, 8.h)),
      padding: EdgeInsets.symmetric(
        horizontal: MoreSettingsLayout.sz(context, 12, 12.w),
        vertical: MoreSettingsLayout.sz(context, 8, 8.h),
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(
          MoreSettingsLayout.sz(context, 10, 10.r),
        ),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            attachment.isVideo ? Icons.videocam_outlined : Icons.image_outlined,
            color: scheme.primary,
            size: MoreSettingsLayout.sp(context, 20, 20),
          ),
          SizedBox(width: MoreSettingsLayout.sz(context, 10, 10.w)),
          Expanded(
            child: Text(
              attachment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onRemove != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onRemove,
              icon: Icon(
                Icons.close_rounded,
                color: scheme.onSurfaceVariant,
                size: MoreSettingsLayout.sp(context, 20, 20),
              ),
            ),
        ],
      ),
    );
  }
}
