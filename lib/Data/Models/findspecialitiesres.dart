class FindSpecialitiesRes {
  int? status;
  String? message;
  List<SpecialityResponse>? response;

  FindSpecialitiesRes({this.status, this.message, this.response});

  FindSpecialitiesRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = <SpecialityResponse>[];
      json['response'].forEach((v) {
        response!.add(new SpecialityResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecialityResponse {
  String? name;
  String? id;
  String? workingTime;
  String? about;

  SpecialityResponse({this.name, this.id, this.workingTime, this.about});

  SpecialityResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    workingTime = json['workingTime'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['about'] = this.about;
    return data;
  }
}
