// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String content;
  final bool isSelf;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.content,
    required this.isSelf,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'is_self': isSelf,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] as String,
      isSelf: map['is_self'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
