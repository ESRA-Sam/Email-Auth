import 'dart:convert';
class UserModel
{
  String FirstName;
  String MiddleName;
  String LastName;
  String Email;
  String Uid;

  UserModel(
      this.FirstName, this.MiddleName, this.LastName, this.Email, this.Uid);


  Map<String, dynamic> toJson(user) {
    return {
      'FirstName': FirstName,
      'MiddleName': MiddleName,
      'LastName': LastName,
      'Email': Email,
      'uid': Uid
    };
  }


}
