import 'package:contact/model/contact_model.dart';
import 'package:contact/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  // Singleton Class
  static final ContactDatabase _instance =
      ContactDatabase._privateConstructor();

  factory ContactDatabase() {
    return _instance;
  }

  ContactDatabase._privateConstructor();


  Future<Database> openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), DatabaseConstants.databaseName),
      onCreate: (db, version) {
        return db.execute(DatabaseConstants.initQuery);
      },
      version: 1,
    );
  }

  Future<int> insertContacts(ContactModel contactModel) async {
    int result = 0;
    final database = await openDB();
    result = await database.insert(
        DatabaseConstants.tableName, contactModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result;
  }

  Future<int> delContact(int id) async {
    final database = await openDB();

    return await database
        .delete(DatabaseConstants.tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ContactModel>> fetchAllContacts() async {
    final database = await openDB();

    var res = await database.query(DatabaseConstants.tableName);
    if (res.isNotEmpty) {
      var contacts = res.map((e) => ContactModel.fromMap(e)).toList();
      return contacts;
    }
    return [];
  }

  Future<int> updateContact(int id, ContactModel item) async {
    // returns the number of rows updated
    final database = await openDB();

    int result = await database.update(
        DatabaseConstants.tableName, item.toMap(),
        where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<int> deleteContact(int id) async {
    final database = await openDB();

    int result = await database
        .delete(DatabaseConstants.tableName, where: "id = ?", whereArgs: [id]);

    return result;
  }
}
