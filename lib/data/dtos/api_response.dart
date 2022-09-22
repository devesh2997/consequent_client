const _codeSuccess = "success";

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

  bool isSuccess() {
    return code.compareTo(_codeSuccess) == 0;
  }

  bool isFailed() {
    return !isSuccess();
  }

  String error() {
    return errorMessage ?? "Some error occurred";
  }
}
