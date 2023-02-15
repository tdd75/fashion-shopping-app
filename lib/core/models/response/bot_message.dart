import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomContent {
  final String payload;
  final dynamic data;

  CustomContent({
    required this.payload,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payload': payload,
      'data': data,
    };
  }

  factory CustomContent.fromMap(Map<String, dynamic> map) {
    return CustomContent(
      payload: map['payload'] as String,
      data: map['data'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomContent.fromJson(String source) =>
      CustomContent.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BotMessage {
  final String? text;
  final CustomContent? custom;
  final bool? isUser;

  BotMessage({
    this.text,
    this.custom,
    this.isUser = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'custom': custom?.toMap(),
      'is_user': isUser,
    };
  }

  factory BotMessage.fromMap(Map<String, dynamic> map) {
    return BotMessage(
      text: map['text'] != null ? map['text'] as String : null,
      custom: map['custom'] != null
          ? CustomContent.fromMap(map['custom'] as Map<String, dynamic>)
          : null,
      isUser: map['is_user'] != null ? map['is_user'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BotMessage.fromJson(String source) =>
      BotMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
