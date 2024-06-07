class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? body; // Changed to nullable

  NetworkResponse(this.isSuccess, this.statusCode, this.body);
}
