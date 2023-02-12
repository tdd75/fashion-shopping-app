import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecoverPassword {
  final String email;
  final String code;
  final String newPassword;

  RecoverPassword({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'code': code,
      'new_password': newPassword,
    };
  }

  factory RecoverPassword.fromMap(Map<String, dynamic> map) {
    return RecoverPassword(
      email: map['email'] as String,
      code: map['code'] as String,
      newPassword: map['new_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecoverPassword.fromJson(String source) =>
      RecoverPassword.fromMap(json.decode(source) as Map<String, dynamic>);
}
