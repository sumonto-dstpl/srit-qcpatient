class RegisterResponse {
  String? timestamp;
  String? message;
  String? response;
  String? details;
  int? code;

  RegisterResponse(
      {this.timestamp, this.message, this.response, this.details, this.code});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    message = json['message'];
    response = json['response'];
    details = json['details'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    data['response'] = this.response;
    data['details'] = this.details;
    data['code'] = this.code;
    return data;
  }
}
