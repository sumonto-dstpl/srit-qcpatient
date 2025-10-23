import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String? text;
  int maxLength;
  String? doctorName;
  DescriptionTextWidget({@required this.text, this.maxLength = 40,this.doctorName});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf = "";
  late String secondHalf = "";

  bool flag = false;
  String about = "";

  void initState() {
    super.initState();
    getSharedPrefs();
    // if (widget.text != null) {
    //   List<String> words = widget.text!.split(" ");
    //
    //   // Setting approximately 4-5 lines in firstHalf
    //   if (words.length > 40) {
    //     firstHalf = words.sublist(0, 40).join(" ");
    //     secondHalf = words.sublist(40).join(" ");
    //   } else {
    //     firstHalf = widget.text!;
    //     secondHalf = "";
    //   }
    // } else {
    //   firstHalf = "";
    //   secondHalf = "";
    // }
  }

  Future getSharedPrefs() async {
    // CheckSession();
    // getDoctorDetails();
    getText();
  }

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  void getDoctorDetails() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        print("Data : ${widget.text}");
        dynamic user = await apiService.findDoctorsdetails(widget.text);

        if (user.message != null) {
          // final snackBar = SnackBar(content: Text(user.message),);
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (user.response != null) {
          var responsedetails = user.response;
          about = responsedetails!.about != null ? responsedetails!.about! : "";
          print("About in Read More: ${responsedetails!.about}");
          setState(() {
            if (about != null) {
              List<String> words = about.split(" ");

              // Setting approximately 4-5 lines in firstHalf
              if (words.length > 40) {
                firstHalf = words.sublist(0, 40).join(" ");
                secondHalf = words.sublist(40).join(" ");
              } else {
                firstHalf = about;
                secondHalf = "";
              }
            } else {
              firstHalf = "";
              secondHalf = "";
            }

            print("firstHalf : $firstHalf");
            print("secondHalf : $secondHalf");
          });
        }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void getText() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {




          about = "${widget.doctorName ?? 'Dr Nutan Bhatt Km'} is a highly experienced General Physician/Internal Medicine specialist in Bengaluru with over ten years of medical practice. He has a wealth of knowledge about treating a wide range of health conditions, including diabetes, diabetic ulcers, insulin treatment, hypertension, and chronic respiratory issues. Dr Faseeh Km also carefully diagnoses and treats common ailments such as fever, cold, infections, and minor injuries.";
          setState(() {
            if (about != null) {
              List<String> words = about.split(" ");

              // Setting approximately 4-5 lines in firstHalf
              if (words.length > 40) {
                firstHalf = words.sublist(0, 40).join(" ");
                secondHalf = words.sublist(40).join(" ");
              } else {
                firstHalf = about;
                secondHalf = "";
              }
            } else {
              firstHalf = "";
              secondHalf = "";
            }

            print("firstHalf : $firstHalf");
            print("secondHalf : $secondHalf");
          });

      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.014,
                fontFamily: 'OpenSans',
                color: Color(0xCC1F1F1F),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              children: [
                TextSpan(text: firstHalf),
                if (!flag && (((firstHalf + secondHalf).length) > 40))
                  TextSpan(
                    text: " Read more...",
                    style: TextStyle(
                      color: Color(0xff1bb273),
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      height: 1.5,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          flag = true;
                        });
                      },
                  ),
                if (flag)
                  TextSpan(
                    text: " " + secondHalf,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                if (flag)
                  TextSpan(
                    text: " Read less",
                    style: TextStyle(
                      color: Color(0xff1bb273),
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      height: 1.5,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          flag = false;
                        });
                      },
                  ),
              ]),
        ),
      ],
    );

    //   Container(
    //   child: secondHalf.isEmpty
    //       ? Text(
    //     firstHalf,
    //     textAlign: TextAlign.left,
    //     style: TextStyle(
    //       fontSize: MediaQuery.of(context).size.height * 0.016,
    //     ),
    //   )
    //       : Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(
    //         flag ? (firstHalf ) : (firstHalf +" "+ secondHalf ),
    //         textAlign: TextAlign.left,
    //         style: TextStyle(
    //           fontSize: MediaQuery.of(context).size.height * 0.016,
    //           fontFamily: 'OpenSans',
    //         ),
    //       ),
    //        InkWell(
    //           onTap: () {
    //             setState(() {
    //               flag = !flag;
    //             });
    //           },
    //           child: Text(
    //             flag ? "Read more..." : "Read less",
    //             style: TextStyle(
    //               color: Color(0xff1bb273),
    //               fontFamily: 'Quicksand',
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //
    //     ],
    //   ),
    // );
  }
}
