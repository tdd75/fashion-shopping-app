import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminInfo {
  final int id;
  final String fullName;
  final String? avatar;

  AdminInfo({
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

  factory AdminInfo.fromMap(Map<String, dynamic> map) {
    return AdminInfo(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminInfo.fromJson(String source) =>
      AdminInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
