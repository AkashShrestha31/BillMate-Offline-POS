import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/contact_book/data/datasources/contact_remote_data_source.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ContactRemoteDataSource)
class ContactLocalDataSource implements ContactRemoteDataSource {
  ContactLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<ContactListResponse> getContacts({ContactQueryParams? params}) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];
      if (params?.search != null && params!.search!.isNotEmpty) {
        conditions.add('name LIKE ?');
        args.add('%${params.search}%');
      }
      if (params?.category != null) {
        conditions.add('category = ?');
        args.add(params!.category);
      }
      if (params?.isFavorite == true) {
        conditions.add('is_favorite = 1');
      }
      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final rows = await _db.query('ContactBook',
          where: where, whereArgs: args.isNotEmpty ? args : null, orderBy: 'name ASC');
      return ContactListResponse(
        success: true,
        count: rows.length,
        contacts: rows.map(_rowToContact).toList(),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ContactSingleResponse> getContactById(int contactId) async {
    try {
      final rows = await _db.query('ContactBook', where: 'id = ?', whereArgs: [contactId]);
      if (rows.isEmpty) throw AppException(message: 'Contact not found');
      return ContactSingleResponse(success: true, contact: _rowToContact(rows.first));
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CreateContactResponse> createContact(CreateContactRequest request) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      final id = await db.insert('ContactBook', {
        'name': request.name,
        'phone': request.phone,
        'email': request.email,
        'address': request.address,
        'category': request.category,
        'company': request.company,
        'created_at': now,
        'modified_at': now,
      });
      final contact = ContactModel(
        id: id, name: request.name, phone: request.phone,
        email: request.email, address: request.address,
        category: request.category, company: request.company,
      );
      return CreateContactResponse(success: true, message: 'Contact created', contact: contact);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<UpdateContactResponse> updateContact(UpdateContactRequest request) async {
    try {
      final db = await _db.database;
      await db.update('ContactBook', {
        if (request.name != null) 'name': request.name,
        if (request.phone != null) 'phone': request.phone,
        if (request.email != null) 'email': request.email,
        if (request.address != null) 'address': request.address,
        'modified_at': DateTime.now().toIso8601String(),
      }, where: 'id = ?', whereArgs: [request.contactId]);
      return UpdateContactResponse(success: true, contactId: request.contactId);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DeleteContactResponse> deleteContact(int contactId) async {
    try {
      final db = await _db.database;
      await db.delete('ContactBook', where: 'id = ?', whereArgs: [contactId]);
      return const DeleteContactResponse(success: true, message: 'Deleted');
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  ContactModel _rowToContact(Map<String, dynamic> r) => ContactModel(
    id: r['id'] as int?,
    name: r['name'] as String?,
    phone: r['phone'] as String?,
    email: r['email'] as String?,
    address: r['address'] as String?,
    category: r['category'] as String?,
    company: r['company'] as String?,
    isFavorite: r['is_favorite'] == 1,
  );
}
