class APIResponse<T> {
  final String code;
  final String? errorMessage;
  final T? data;

  APIResponse(this.code, this.errorMessage, this.data);

  factory APIResponse.fromJson(
      dynamic json, T Function(Map<String, dynamic> json) constructor) {
    T? data;
    if (json["data"] != null) {
      data = constructor(json["data"]);
    }
    return APIResponse(
      json["code"],
      json["errorMessage"],
      data,
    );
  }
}
