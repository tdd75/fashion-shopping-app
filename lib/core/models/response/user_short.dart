// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserShort {
  final int id;
  final String fullName;
  final String? avatar;

  UserShort({
    required this.id,
    required this.fullName,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'avatar': avatar,
    };
  }

  factory UserShort.fromMap(Map<String, dynamic> map) {
    return UserShort(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserShort.fromJson(String source) =>
      UserShort.fromMap(json.decode(source) as Map<String, dynamic>);
}
