// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorResponse {
  final String error;

  ErrorResponse({
    required this.error,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detail': error,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      error: map['detail'] ?? map.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
