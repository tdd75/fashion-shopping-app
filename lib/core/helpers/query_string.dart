class QueryString {
  static Map<String, String> convert(Map<String, dynamic> query) {
    return query.map((key, value) => MapEntry(key, value.toString()));
  }
}
