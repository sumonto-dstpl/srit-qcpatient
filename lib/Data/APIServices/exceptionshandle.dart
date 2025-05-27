class ExceptionHandle {
  String? timestamp;
  String? message;
  String? details;
  int? code;

  ExceptionHandle({this.timestamp, this.message, this.details, this.code});

  ExceptionHandle.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    message = json['message'];
    details = json['details'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    data['details'] = this.details;
    data['code'] = this.code;
    return data;
  }
}
