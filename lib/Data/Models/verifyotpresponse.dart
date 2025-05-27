class VerifyOTPResponseModel {
  String? accessToken;
  String? refreshToken;
  int? refreshExpiresIn;
  int? notBeforePolicy;
  String? scope;
  String? idToken;
  String? tokenType;
  String? sessionState;
  String? error;
  String? message;
  String? response;
  int? expiresIn;

  VerifyOTPResponseModel(
      {this.accessToken,
      this.refreshToken,
      this.refreshExpiresIn,
      this.notBeforePolicy,
      this.scope,
      this.idToken,
      this.tokenType,
      this.sessionState,
      this.error,
      this.message,
      this.response,
      this.expiresIn});

  VerifyOTPResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    refreshExpiresIn = json['refresh_expires_in'];
    notBeforePolicy = json['not-before-policy'];
    scope = json['scope'];
    idToken = json['id_token'];
    tokenType = json['token_type'];
    sessionState = json['session_state'];
    error = json['error'];
    message = json['message'];
    response = json['response'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['refresh_expires_in'] = this.refreshExpiresIn;
    data['not-before-policy'] = this.notBeforePolicy;
    data['scope'] = this.scope;
    data['id_token'] = this.idToken;
    data['token_type'] = this.tokenType;
    data['session_state'] = this.sessionState;
    data['error'] = this.error;
    data['message'] = this.message;
    data['response'] = this.response;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
