class SearchData {
  int? status;
  String? message;
  SearchDataResponse? response;

  SearchData({this.status, this.message, this.response});

  SearchData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new SearchDataResponse.fromJson(json['response'])
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

class SearchDataResponse {
  List<Doctor>? doctor;
  List<Speciality>? speciality;
  List<Service>? service;

  SearchDataResponse({this.doctor, this.speciality, this.service});

  SearchDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
    if (json['speciality'] != null) {
      speciality = <Speciality>[];
      json['speciality'].forEach((v) {
        speciality!.add(new Speciality.fromJson(v));
      });
    }
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
    }
    if (this.speciality != null) {
      data['speciality'] = this.speciality!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String? name;
  String? id;
  String? qualification;
  List<String>? speciality;
  String? locationName;
  String? workingTime;
  List<String>? timeSlot;
  String? about;

  Doctor(
      {this.name,
      this.id,
      this.qualification,
      this.speciality,
      this.locationName,
      this.workingTime,
      this.timeSlot,
      this.about});

  Doctor.fromJson(Map<String, dynamic> json) {
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

class Speciality {
  String? name;
  String? id;
  String? workingTime;
  List<String>? timeSlot;
  String? about;

  Speciality({this.name, this.id, this.workingTime, this.timeSlot, this.about});

  Speciality.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    workingTime = json['workingTime'];
    timeSlot = json['timeSlot'].cast<String>();
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['workingTime'] = this.workingTime;
    data['timeSlot'] = this.timeSlot;
    data['about'] = this.about;
    return data;
  }
}

class Service {
  String? id;
  String? name;
  Null? experience;
  Null? service;
  Null? gender;
  Null? language;
  Null? fee;
  Null? availablity;
  Null? city;

  Service(
      {this.id,
      this.name,
      this.experience,
      this.service,
      this.gender,
      this.language,
      this.fee,
      this.availablity,
      this.city});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    experience = json['experience'];
    service = json['service'];
    gender = json['gender'];
    language = json['language'];
    fee = json['fee'];
    availablity = json['availablity'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['experience'] = this.experience;
    data['service'] = this.service;
    data['gender'] = this.gender;
    data['language'] = this.language;
    data['fee'] = this.fee;
    data['availablity'] = this.availablity;
    data['city'] = this.city;
    return data;
  }
}
