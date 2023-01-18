// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QueryRequest {
  int? limit;
  int? offset;
  String? search;

  QueryRequest({
    this.limit = 10,
    this.offset,
    this.search,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'limit': limit,
      'offset': offset,
      'search': search,
    };
  }

  factory QueryRequest.fromMap(Map<String, dynamic> map) {
    return QueryRequest(
      limit: map['limit'] != null ? map['limit'] as int : null,
      offset: map['offset'] != null ? map['offset'] as int : null,
      search: map['search'] != null ? map['search'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryRequest.fromJson(String source) => QueryRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
