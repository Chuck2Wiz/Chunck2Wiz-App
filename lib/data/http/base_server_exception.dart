class BaseServerException {
  final int status;
  final dynamic message;

  const BaseServerException(this.status, this.message);

  factory BaseServerException.fromJson(Map<String, dynamic> json) => BaseServerException(
      json["status"],
      json["message"]
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message
  };

  @override
  String toString() {
    return message;
  }
}