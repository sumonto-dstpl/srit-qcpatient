import 'dart:convert';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newfolder/Data/Models/appointmentselectime.dart';
import 'package:newfolder/Data/Models/doctordetailsres.dart';
import 'package:newfolder/Data/Models/doctorslistres.dart';
import 'package:newfolder/Data/Models/findspecialitiesres.dart';
import 'package:newfolder/Data/Models/loginresponse.dart';
import 'package:newfolder/Data/Models/registerresponse.dart';
import 'package:newfolder/Data/Models/searchdatares.dart';
import 'package:newfolder/Data/Models/verifyotpresponse.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';

class APIService {
  //Pre - prod
  String BaseUrl = "https://qcmobapi.sritindia.com/";

  String accesstokenValue = "";
  String useridValue = "";

  Future submitlogin(String? usernameVal, String? passwordval) async {
    var requestUrl = BaseUrl + 'auth/signin';

    // raw json
    var newbody =
        jsonEncode({"userId": usernameVal, "encryptedPassword": passwordval});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
        },
        body: newbody);

    if (response.statusCode == 200) {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      var newres = LoginResponseModel.fromJson(json.decode(response.body));
      return newres;
    } else {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      var newres = LoginResponseModel.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // Sign Up Registration
  Future submitregistration(
      String? firstNameVal,
      String? lastNameVal,
      String? mobileVal,
      String? emailVal,
      String? genderVal,
      String? termsVal,
      String? encryptedPasswordVal) async {
    var requestUrl = BaseUrl + 'auth/signup';

    // raw json
    var newbody = jsonEncode({
      "firstName": firstNameVal,
      "lastName": lastNameVal,
      "mobile": mobileVal,
      "email": emailVal,
      "gender": genderVal,
      "terms": termsVal,
      "encryptedPassword": encryptedPasswordVal
    });

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      print(newres.code);
      print(newres.message);
      print(newres.response);
      print(newres.details);

      return newres;
    } else {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      print(newres.code);
      print(newres.message);
      print(newres.response);
      print(newres.details);
      return newres;
    }
  }

  // Send OTP
  Future submitsendotp(
    String? contactVal,
  ) async {
    var requestUrl = BaseUrl + 'auth/sendotpfp';

    // raw json
    var newbody = jsonEncode({"contact": contactVal});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // verify OTP

  Future submitverifyotp(String? contactVal, String? otpVal) async {
    var requestUrl = BaseUrl + 'auth/verifyotpfp';

    // raw json
    var newbody = jsonEncode({"contact": contactVal, "otp": otpVal});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = VerifyOTPResponseModel.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = LoginResponseModel.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // Update Password
  Future submitupdatepass(
      String? contactVal, String? encryptedPasswordVal) async {
    final accesstokenresetpassValue =
        await UserSecureStorage.getTokenResetPassvalue() ?? '';
    var requestUrl = BaseUrl + 'auth/updatepasswordfp';

    // raw json
    var newbody = jsonEncode(
        {"contact": contactVal, "encryptedPassword": encryptedPasswordVal});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstokenresetpassValue',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = RegisterResponse.fromJson(json.decode(response.body));
      return newres;
    }
  }

  Future<int> refreshtoken() async {
    final refreshtokenValue = await UserSecureStorage.getRefreshTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'auth/refreshtoken';

    var newbody = {
      "grant_type": "refresh_token",
      "refresh_token": refreshtokenValue,
      "client_id": "eDistrictKeyCloak",
      "client_secret": "KQM5IOxevdtD0GYyAhNqKjjzo1bIGEJ5"
    };

    final response = await http.post(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json; charset=utf-8',
        'refreshToken': refreshtokenValue,
      },
      // body: newbody
    );

    if (response.statusCode == 200) {
      LoginResponseModel newres = LoginResponseModel.fromJson(json.decode(response.body));
      await UserSecureStorage.setNRStatuscodeval(response.statusCode.toString());
      await UserSecureStorage.setTokenvalue(newres.accessToken!);
      await UserSecureStorage.setRefreshTokenvalue(newres.refreshToken!);
      return response.statusCode;
    } else {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      return response.statusCode;
    }
  }

  // Find Specialities
  Future findspecialitieslist() async {
    final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'appointment/specialities';

    final response = await http.post(Uri.parse(requestUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstokenValue',
    });

    if (response.statusCode == 200) {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      var newres = FindSpecialitiesRes.fromJson(json.decode(response.body));
      return newres;
    } else if (response.statusCode == 401) {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      return "session out";
    } else {
      await UserSecureStorage.setNRStatuscodeval(
          response.statusCode.toString());
      var newres = FindSpecialitiesRes.fromJson(json.decode(response.body));
      return newres;
    }
  }


  // Doctors List
  Future findDoctorslist(String? characteristicsVal) async {
    final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'appointment/doctorslist';

    // raw json
    var newbody = jsonEncode({"characteristics": characteristicsVal});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstokenValue',
        },
        body: newbody);

    if (response.statusCode == 200) {

      var newres = DoctorsListB.fromJson(json.decode(response.body));

      return newres;
    } else {

      var newres = DoctorsListB.fromJson(json.decode(response.body));

      return newres;
    }
  }
  Future findGuestDoctorslist(String? characteristicsVal) async {
    // final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'guest/appointment/doctorslist';

    // raw json
    var newbody = jsonEncode({"characteristics": characteristicsVal});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          // 'Authorization': 'Bearer $accesstokenValue',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = DoctorsListB.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = DoctorsListB.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // Doctors Details
  Future findDoctorsdetails(String? doctoridval) async {
    final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'appointment/doctordetails';

    // raw json
    var newbody = jsonEncode({"id": doctoridval});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstokenValue',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = DoctorDetails.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = DoctorDetails.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // Doctors Appontment time Details
  Future findDocAppTimedetails(
      String? doctoridval, String? selectedDateval) async {
    final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'appointment/doctoravailablity';

    // raw json
    var newbody =
        jsonEncode({"id": doctoridval, "selectedDate": selectedDateval});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstokenValue',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = AppointmentSelectTime.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = AppointmentSelectTime.fromJson(json.decode(response.body));
      return newres;
    }
  }

  // Search Details
  Future findSearchdetails(String? searchval) async {
    final accesstokenValue = await UserSecureStorage.getTokenvalue() ?? '';
    var requestUrl = BaseUrl + 'appointment/quicksearch';

    // raw json
    var newbody = jsonEncode({"name": searchval});

    print("Request Body: $newbody");

    final response = await http.post(Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstokenValue',
        },
        body: newbody);

    if (response.statusCode == 200) {
      var newres = SearchData.fromJson(json.decode(response.body));
      return newres;
    } else {
      var newres = SearchData.fromJson(json.decode(response.body));
      return newres;
    }
  }

  bool stringToBool(String value) {
    if (value.toLowerCase() == 'true' || value == '1') {
      return true;
    } else if (value.toLowerCase() == 'false' || value == '0') {
      return false;
    } else {
      throw ArgumentError('Invalid boolean string: $value');
    }
  }

  Future uploadPrescription(String? fileName,String? prescription) async {
    var requestUrl = BaseUrl + 'medication/uploadprescription';



    final body = {
      "attachList": [
        {
          "data": prescription,
          "contentType": "application/x-pdf", // change if needed
          "fileName": fileName,
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"), // fake endpoint
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accesstokenValue',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Upload successful");

      } else {
        print("Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Upload error: $e");
    }


    return "";
  }




}
