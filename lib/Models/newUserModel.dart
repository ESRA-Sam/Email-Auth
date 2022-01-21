import 'dart:convert';

class newUserModel {
  String uid;
  String fullName;
  String email;
  String phoneNumber;
  newUserModel({
    this.uid,
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  newUserModel copyWith({
    String uid,
    String fullName,
    String email,
    String phoneNumber,
  }) {
    return newUserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap(user) {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory newUserModel.fromMap(Map<String, dynamic> map) {
    return newUserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson(user) => json.encode(toMap(user));

  factory newUserModel.fromJson(String source) =>
      newUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'newUserModel(uid: $uid, fullName: $fullName, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is newUserModel &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode;
  }
}
