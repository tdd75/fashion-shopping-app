class QueryString {
  static Map<String, String> convert(Map<String, dynamic> query) {
    final result = Map<String, dynamic>.from(query);
    return result.map((key, value) => MapEntry(key, value.toString()));
  }
}
