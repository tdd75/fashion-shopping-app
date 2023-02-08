// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QueryParam {
  int limit;
  int offset;
  String? search;

  QueryParam({
    this.limit = 10,
    this.offset = 0,
    this.search,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
  }

  factory QueryParam.fromMap(Map<String, dynamic> map) {
    return QueryParam(
      limit: map['limit'] as int,
      offset: map['offset'] as int,
      search: map['search'] != null ? map['search'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryParam.fromJson(String source) =>
      QueryParam.fromMap(json.decode(source) as Map<String, dynamic>);
}
