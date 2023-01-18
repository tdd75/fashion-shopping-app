// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  String identify;
  String password;

  LoginRequest({
    required this.identify,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identify': identify,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      identify: map['identify'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
