// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Token {
  final String access;
  final String refresh;

  Token({
    required this.access,
    required this.refresh,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access': access,
      'refresh': refresh,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      access: map['access'] as String,
      refresh: map['refresh'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);
}
