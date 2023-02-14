import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserUpdate {
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserUpdate({
    this.phone,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  factory UserUpdate.fromMap(Map<String, dynamic> map) {
    return UserUpdate(
      phone: map['phone'] != null ? map['phone'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson({bool partial = false}) {
    if (partial) {
      final map = toMap();
      map.removeWhere((key, value) => value == null);
      return json.encode(map);
    } else {
      return json.encode(toMap());
    }
  }

  factory UserUpdate.fromJson(String source) =>
      UserUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
