// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ListResponse<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  ListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': List<Map<String, dynamic>>.from(
          results.map<T>((x) => (x as dynamic).toMap())),
    };
  }

  factory ListResponse.fromMap(
      Map<String, dynamic> map, T Function(Map<String, dynamic>) fromMapModel) {
    return ListResponse<T>(
      count: map['count'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
      results: List<T>.from(map['results'].map((x) => fromMapModel(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListResponse.fromJson(
          String source, T Function(Map<String, dynamic>) fromMapModel) =>
      ListResponse.fromMap(
          json.decode(source) as Map<String, dynamic>, (x) => fromMapModel(x));
}
