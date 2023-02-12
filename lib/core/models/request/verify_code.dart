import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyCode {
  final String email;
  final String code;

  VerifyCode({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'code': code,
    };
  }

  factory VerifyCode.fromMap(Map<String, dynamic> map) {
    return VerifyCode(
      email: map['email'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyCode.fromJson(String source) =>
      VerifyCode.fromMap(json.decode(source) as Map<String, dynamic>);
}
