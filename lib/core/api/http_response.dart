class HttpResponse<T> {
  final T? data;
  final String? error;

  HttpResponse({
    this.data,
    this.error,
  });
}
