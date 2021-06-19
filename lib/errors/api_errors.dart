class ApiErrors implements Exception {
  final String message;

  const ApiErrors(this.message);

  @override
  String toString() {
    return message;
  }
}
