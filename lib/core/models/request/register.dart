// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Register {
  String firstName;
  String lastName;
  String username;
  String email;
  String password;

  Register({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) =>
      Register.fromMap(json.decode(source) as Map<String, dynamic>);
}
