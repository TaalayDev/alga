class ResponseModel<T> {
  final bool status;
  final String message;
  T? data;
  dynamic errorData;

  ResponseModel({
    this.status = false,
    this.message = '',
    this.data,
    this.errorData,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) => ResponseModel(
        status: map['success'] ?? false,
        message: map['message'] ?? '',
      );
}
