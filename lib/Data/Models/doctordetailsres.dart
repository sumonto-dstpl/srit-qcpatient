class DoctorDetails {
  int? status;
  String? message;
  DoctorDetailsResponse? response;

  DoctorDetails({this.status, this.message, this.response});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new DoctorDetailsResponse.fromJson(json['response'])
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

class DoctorDetailsResponse {
  String? doctorId;
  String? doctorName;
  String? qualification;
  String? speciality;
  String? workingTime;
  String? experience;
  String? about;
  String? regularFee;
  String? discountFee;
  String? rating;
  String? workLocation;
  List<String>? availableSlots;
  Photo? photo;

  DoctorDetailsResponse(
      {this.doctorId,
        this.doctorName,
        this.qualification,
        this.speciality,
        this.workingTime,
        this.experience,
        this.about,
        this.regularFee,
        this.discountFee,
        this.rating,
        this.workLocation,
        this.availableSlots,
        this.photo});

  DoctorDetailsResponse.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    qualification = json['qualification'];
    speciality = json['speciality'];
    workingTime = json['workingTime'];
    experience = json['experience'];
    about = json['about'];
    regularFee = json['regularFee'];
    discountFee = json['discountFee'];
    rating = json['rating'];
    workLocation = json['workLocation'];
    availableSlots = json['availableSlots'].cast<String>();
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['workingTime'] = this.workingTime;
    data['experience'] = this.experience;
    data['about'] = this.about;
    data['regularFee'] = this.regularFee;
    data['discountFee'] = this.discountFee;
    data['rating'] = this.rating;
    data['workLocation'] = this.workLocation;
    data['availableSlots'] = this.availableSlots;
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