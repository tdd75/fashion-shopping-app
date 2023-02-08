import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageCreate {
  final String content;
  final int receiver;

  MessageCreate({
    required this.content,
    required this.receiver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'receiver': receiver,
    };
  }

  factory MessageCreate.fromMap(Map<String, dynamic> map) {
    return MessageCreate(
      content: map['content'] as String,
      receiver: map['receiver'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageCreate.fromJson(String source) =>
      MessageCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
