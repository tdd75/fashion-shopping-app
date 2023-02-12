class QueryString {
  static Map<String, String> convert(Map<String, dynamic> query,
      {bool omitNull = true}) {
    final result = Map<String, dynamic>.from(query);

    if (omitNull) result.removeWhere((key, value) => value == null);

    return result.map((key, value) => MapEntry(key, value.toString()));
  }
}
