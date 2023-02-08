// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/user_short.dart';

class Message {
  final String content;
  final UserShort receiver;
  final UserShort sender;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.content,
    required this.receiver,
    required this.sender,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'receiver': receiver.toMap(),
      'sender': sender.toMap(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] as String,
      receiver: UserShort.fromMap(map['receiver'] as Map<String, dynamic>),
      sender: UserShort.fromMap(map['sender'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
