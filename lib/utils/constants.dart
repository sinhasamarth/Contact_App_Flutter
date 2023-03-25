class DatabaseConstants {
  static const String databaseName = "contact_database.db";
  static const String tableName = "contacts";
  static const String firstName = "firstName";
  static const String middleName = "middleName";
  static const String lastName = "lastName";
  static const String phoneNo = "phoneNo";
  static const String company = "company";
  static const String email = "email";
  static const String birthday = "birthday";
  static const String image = "image";

  // init Query
  static const String initQuery = "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$firstName TEXT NULL,"
      "$middleName TEXT NULL,"
      "$lastName TEXT NULL,"
      "$phoneNo TEXT NULL,"
      "$email TEXT NULL,"
      "$company TEXT NULL,"
      "$birthday TEXT NULL,"
      "$image TEXT"
      ")";

}
