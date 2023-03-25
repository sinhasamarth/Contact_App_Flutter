import 'package:contact/utils/constants.dart' show DatabaseConstants;

class ContactModel {
  // id (AUTO GEN )
  int? id;

  // Name
  String firstName;
  String middleName;
  String lastName;

  // Other Details
  String email;
  String companyName;
  String birthDay;
  String phoneNo;
  String image;

  ContactModel(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.birthDay,
      required this.email,
      required this.companyName,
      required this.phoneNo,
      required this.image});

  ContactModel.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        firstName = result[DatabaseConstants.firstName],
        lastName = result[DatabaseConstants.lastName],
        middleName = result[DatabaseConstants.middleName],
        email = result[DatabaseConstants.email],
        companyName = result[DatabaseConstants.company],
        birthDay = result[DatabaseConstants.birthday],
        phoneNo = result[DatabaseConstants.phoneNo],
        image = result[DatabaseConstants.image];

  Map<String, Object?> toMap() {
    return {
      DatabaseConstants.firstName: firstName,
      DatabaseConstants.middleName: middleName,
      DatabaseConstants.lastName: lastName,
      DatabaseConstants.phoneNo: phoneNo,
      DatabaseConstants.email: email,
      DatabaseConstants.company: companyName,
      DatabaseConstants.birthday: birthDay,
      DatabaseConstants.image : image
    };
  }

  String getFullName() => "$firstName $middleName $lastName".trim();

  @override
  String toString() {
    return "\n Id : $id , "
        "FIRST_NAME: $firstName ,"
        "MIDDLE_NAME: $middleName ,"
        "LAST_NAME: $lastName ,"
        "PHONE_NO: $phoneNo ,"
        "EMAIL: $email ,"
        "COMPANY: $companyName , "
        "BIRTHDAY: $birthDay ,"
        "Image: $image";
  }
}
