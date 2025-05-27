class DoctorsListB {
  int? status;
  String? message;
  List<DoctorsListResponse>? response;

  DoctorsListB({this.status,  this.message,  this.response});

  DoctorsListB.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = <DoctorsListResponse>[];
      json['response'].forEach((v) {
        response!.add(new DoctorsListResponse.fromJson(v));
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

class DoctorsListResponse {
  String? doctorId;
  String? doctorName;
  String? qualification;
  String? speciality;
  String? experience;
  String? regularFee;
  String? discountFee;
  String? rating;
  String? workLocation;
  Photo? photo;

  DoctorsListResponse(
      {this.doctorId,
        this.doctorName,
        this.qualification,
        this.speciality,
        this.experience,
        this.regularFee,
        this.discountFee,
        this.rating,
        this.workLocation,
        this.photo});

  DoctorsListResponse.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    qualification = json['qualification'];
    speciality = json['speciality'];
    experience = json['experience'];
    regularFee = json['regularFee'];
    discountFee = json['discountFee'];
    rating = json['rating'];
    workLocation = json['workLocation'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['experience'] = this.experience;
    data['regularFee'] = this.regularFee;
    data['discountFee'] = this.discountFee;
    data['rating'] = this.rating;
    data['workLocation'] = this.workLocation;
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    return data;
  }
}

class Photo {
  String? data;
  String? contentType;
  Null? fileName;

  Photo({this.data, this.contentType, this.fileName});

  Photo.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    contentType = json['contentType'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['contentType'] = this.contentType;
    data['fileName'] = this.fileName;
    return data;
  }
}