// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Login {
  String identify;
  String password;

  Login({
    required this.identify,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identify': identify,
      'password': password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      identify: map['identify'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) =>
      Login.fromMap(json.decode(source) as Map<String, dynamic>);
}
