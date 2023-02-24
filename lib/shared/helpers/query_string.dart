class QueryString {
  static Map<String, String> convert(Map<String, dynamic> query) {
    final result = Map<String, dynamic>.from(query);
    result.removeWhere((key, value) => value == null);
    return result.map((key, value) => MapEntry(key, value.toString()));
  }
}
