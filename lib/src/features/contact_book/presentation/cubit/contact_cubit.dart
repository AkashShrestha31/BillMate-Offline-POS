import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/create_contact_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/delete_contact_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/get_contact_by_id_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/get_contacts_use_case.dart';
import 'package:hotel/src/features/contact_book/domain/usecases/update_contact_use_case.dart';
part 'contact_state.dart';
part 'contact_cubit.freezed.dart';

@injectable
class ContactCubit extends Cubit<ContactState> {
  ContactCubit(
    this._getContactsUseCase,
    this._getContactByIdUseCase,
    this._createContactUseCase,
    this._updateContactUseCase,
    this._deleteContactUseCase,
  ) : super(const ContactState.initial());

  final GetContactsUseCase _getContactsUseCase;
  final GetContactByIdUseCase _getContactByIdUseCase;
  final CreateContactUseCase _createContactUseCase;
  final UpdateContactUseCase _updateContactUseCase;
  final DeleteContactUseCase _deleteContactUseCase;

  void loadContacts({ContactQueryParams? params}) async {
    emit(const ContactState.loading());
    final result = await _getContactsUseCase(params: params);
    result.fold(
      (l) => l.when(
        serverError: (message) => emit(ContactState.error(message: message)),
        noInternet: () => emit(const ContactState.noInternet()),
      ),
      (r) => emit(ContactState.listLoaded(r)),
    );
  }

  void loadContactById(int contactId) async {
    emit(const ContactState.loading());
    final result = await _getContactByIdUseCase(contactId);
    result.fold(
      (l) => l.when(
        serverError: (message) => emit(ContactState.error(message: message)),
        noInternet: () => emit(const ContactState.noInternet()),
      ),
      (r) => emit(ContactState.contactLoaded(r)),
    );
  }

  void createContact(CreateContactRequest request) async {
    emit(const ContactState.loading());
    final result = await _createContactUseCase(request);
    result.fold(
      (l) => l.when(
        serverError: (message) => emit(ContactState.error(message: message)),
        noInternet: () => emit(const ContactState.noInternet()),
      ),
      (r) => emit(ContactState.created(r)),
    );
  }

  void updateContact(UpdateContactRequest request) async {
    emit(const ContactState.loading());
    final result = await _updateContactUseCase(request);
    result.fold(
      (l) => l.when(
        serverError: (message) => emit(ContactState.error(message: message)),
        noInternet: () => emit(const ContactState.noInternet()),
      ),
      (_) => emit(const ContactState.updated()),
    );
  }

  void deleteContact(int contactId) async {
    emit(const ContactState.loading());
    final result = await _deleteContactUseCase(contactId);
    result.fold(
      (l) => l.when(
        serverError: (message) => emit(ContactState.error(message: message)),
        noInternet: () => emit(const ContactState.noInternet()),
      ),
      (_) => emit(const ContactState.deleted()),
    );
  }
}
