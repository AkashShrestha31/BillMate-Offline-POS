part of 'contact_cubit.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState.initial() = _Initial;
  const factory ContactState.loading() = _Loading;
  const factory ContactState.noInternet() = _NoInternet;
  const factory ContactState.error({required String message}) = _Error;
  const factory ContactState.listLoaded(ContactListResponse response) =
      _ListLoaded;
  const factory ContactState.contactLoaded(ContactModel contact) = _ContactLoaded;
  const factory ContactState.created(ContactModel contact) = _Created;
  const factory ContactState.updated() = _Updated;
  const factory ContactState.deleted() = _Deleted;
}
