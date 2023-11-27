// repository.dart
import 'package:phincash/src/loan_transaction/transactions/models/contact_uplod_model.dart';
import 'package:phincash/src/loan_transaction/transactions/helpers/database_helper.dart';


class Repository {
  final DatabaseHelper _db;

  Repository(this._db);

  Future<void> markContactsAsUploaded() async {
    await _db.markContactsAsUploaded();
  }

  Future<bool> areContactsUploaded() async {
    return await _db.areContactsUploaded();
  }
}
