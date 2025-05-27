class AppointmentSelectTime {
  int? status;
  String? message;
  AppointmentSelectTimeResponse? response;

  AppointmentSelectTime({this.status, this.message, this.response});

  AppointmentSelectTime.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new AppointmentSelectTimeResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class AppointmentSelectTimeResponse {
  String? name;
  String? id;
  String? qualification;
  List<String>? speciality;
  String? locationName;
  String? workingTime;
  List<String>? timeSlot;
  String? about;

  AppointmentSelectTimeResponse(
      {this.name,
      this.id,
      this.qualification,
      this.speciality,
      this.locationName,
      this.workingTime,
      this.timeSlot,
      this.about});

  AppointmentSelectTimeResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    qualification = json['qualification'];
    speciality = json['speciality'].cast<String>();
    locationName = json['locationName'];
    workingTime = json['workingTime'];
    timeSlot = json['timeSlot'].cast<String>();
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['locationName'] = this.locationName;
    data['workingTime'] = this.workingTime;
    data['timeSlot'] = this.timeSlot;
    data['about'] = this.about;
    return data;
  }
}
