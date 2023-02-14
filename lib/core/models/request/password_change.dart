import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PasswordChange {
  final String oldPassword;
  final String newPassword;

  PasswordChange({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }

  factory PasswordChange.fromMap(Map<String, dynamic> map) {
    return PasswordChange(
      oldPassword: map['old_password'] as String,
      newPassword: map['new_password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordChange.fromJson(String source) =>
      PasswordChange.fromMap(json.decode(source) as Map<String, dynamic>);
}
