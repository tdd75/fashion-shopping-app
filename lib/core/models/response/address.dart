import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address {
  final int id;
  final String fullName;
  final String phone;
  final String city;
  final String district;
  final String ward;
  final String detail;
  final bool isDefault;

  Address({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.city,
    required this.district,
    required this.ward,
    required this.detail,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'city': city,
      'district': district,
      'ward': ward,
      'detail': detail,
      'is_default': isDefault,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      ward: map['ward'] as String,
      detail: map['detail'] as String,
      isDefault: map['is_default'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
