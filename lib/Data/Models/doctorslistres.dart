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
  String? name;
  String? qualification;
  String? speciality;
  String? category;
  String? experience;
  String? regularFee;
  String? discountFee;
  String? rating;
  String? workLocation;
  Photo? photo;
  String? availiability;
  String? gender;
  String? language;
  String? city;
  String? experienceYears;
  String? feeRange;
  String? availability;

  DoctorsListResponse(
      {this.doctorId,
        this.name,
        this.qualification,
        this.speciality,
        this.category,
        this.experience,
        this.regularFee,
        this.discountFee,
        this.rating,
        this.workLocation,
        this.photo,
        this.availiability,
        this.gender,
        this.language,
        this.city,
        this.experienceYears,
        this.feeRange,
        this.availability

      });

  DoctorsListResponse.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    name = json['name'];
    qualification = json['qualification'];
    speciality = json['speciality'];
    category = json['category'];
    experience = json['experience'];
    regularFee = json['regularFee'];
    discountFee = json['discountFee'];
    rating = json['rating'];
    availiability = json['availiability'];

    gender = json['gender'];
    language = json['language'];
    city = json['city'];
    experienceYears = json['experienceYears'];
    feeRange = json['feeRange'];
    availability = json['availability'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorId'] = this.doctorId;
    data['name'] = this.name;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['category'] = this.category;
    data['experience'] = this.experience;
    data['regularFee'] = this.regularFee;
    data['discountFee'] = this.discountFee;
    data['rating'] = this.rating;
    data['workLocation'] = this.workLocation;
    data['availiability'] = this.availiability;
    data['gender'] = this.gender;
    data['language'] = this.language;
    data['city'] = this.city;
    data['experienceYears'] = this.experienceYears;
    data['feeRange'] = this.feeRange;
    data['availability'] = this.availability;
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{name: $name, speciality: $speciality, experience: $experience}, category: $category';
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