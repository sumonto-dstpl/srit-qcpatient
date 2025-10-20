// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:newfolder/Screens/Login/loginhome.dart';
// import 'package:newfolder/Screens/Utils/styles.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;
//
//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }
//
//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       padding: EdgeInsets.only(
//           top: MediaQuery.of(context).size.height * 0.015,
//           bottom: MediaQuery.of(context).size.height * 0.015,
//           left: MediaQuery.of(context).size.height * 0.0,
//           right: MediaQuery.of(context).size.height * 0.0),
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: MediaQuery.of(context).size.height * 0.005,
//       width: isActive
//           ? MediaQuery.of(context).size.height * 0.035
//           : MediaQuery.of(context).size.height * 0.006,
//       decoration: BoxDecoration(
//         color: isActive ? Color(0xFF126086) : Colors.black12,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }
//
//   // Define two separate PageControllers
//   final PageController _imagePageController = PageController();
//   final PageController _textPageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           // Skip Button
//           Expanded(
//             flex: 2,
//             child: _currentPage != _numPages - 1
//                 ? Container(
//                     alignment: Alignment.centerRight,
//                     margin: EdgeInsets.only(
//                         right: MediaQuery.of(context).size.height * 0.02,
//                         top: MediaQuery.of(context).size.height * 0.03),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.035, // Height relative to screen size
//                       decoration: BoxDecoration(
//                         color: Colors.blue
//                             .withOpacity(0.1), // Light background color
//                         borderRadius: BorderRadius.circular(
//                           MediaQuery.of(context).size.height *
//                               0.012, // Reactive radius
//                         ),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width *
//                             0.03,
//                         vertical: MediaQuery.of(context).size.height * 0.002,// Reactive horizontal padding
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) => LoginHome(),
//                             ),
//                             (Route route) => false,
//                           );
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           minimumSize: Size.zero,
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         child: Text(
//                           "Skip",
//                           style: TextStyle(
//                             color: Color(0xFF126086),
//                             fontSize: MediaQuery.of(context).size.height *
//                                 0.016, // Reactive font size
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 :  SizedBox(),
//           ),
//
//           // Image and Text PageView (Both Controlled by Same PageController)
//           Expanded(
//             flex: 9,
//             child: PageView(
//               physics: ClampingScrollPhysics(),
//               controller: _pageController, // Use the same controller
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//               children: <Widget>[
//                 Column(
//                   children: [
//                     // Image Page
//                     Expanded(
//                       flex: 4,
//                       child: OnboardingImage(image: 'assets/onboarding0.png'),
//                     ),
//                     // Text Page
//                     Expanded(
//                       flex: 2,
//                       child: OnboardingText(
//                         title: 'Find the best Doctors in your vicinity',
//                         description:
//                             'With the help of our intelligent algorithms, now locate the best doctors around your vicinity with ease.',
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     // Image Page
//                     Expanded(
//                       flex: 4,
//                       child: OnboardingImage(image: 'assets/onboarding1.png'),
//                     ),
//                     // Text Page
//                     Expanded(
//                       flex: 2,
//                       child: OnboardingText(
//                         title: 'Schedule appointments with expert doctors',
//                         description:
//                             'Find experienced specialist doctors with expert ratings and reviews. Book your appointments hassle-free.',
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     // Image Page
//                     Expanded(
//                       flex: 4,
//                       child: OnboardingImage(image: 'assets/onboarding2.png'),
//                     ),
//                     // Text Page
//                     Expanded(
//                       flex: 2,
//                       child: OnboardingText(
//                         title: 'Find the best caretaker for your family',
//                         description:
//                             'Discover experienced nurses and caretakers with excellent ratings and reviews to ensure your loved ones are in good hands.',
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // Bottom Buttons
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 _currentPage != _numPages - 1
//                     ? GestureDetector(
//                         onTap: () async {
//                           _pageController.nextPage(
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.ease,
//                           );
//                         },
//                         child: Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.only(
//                               top: MediaQuery.of(context).size.height * 0.01,
//                               bottom:
//                                   MediaQuery.of(context).size.height * 0.00),
//                           margin: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.height * 0.04,
//                               right: MediaQuery.of(context).size.height * 0.04),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(
//                                       MediaQuery.of(context).size.height *
//                                           0.012,
//                                     ),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.centerRight,
//                                       end: Alignment.center,
//                                       stops: [0.5, 0.9],
//                                       colors: [
//                                         Color(0xFF126086),
//                                         Color(0xFF126086)
//                                       ],
//                                     ),
//                                   ),
//                                   alignment: Alignment.center,
//                                   padding: EdgeInsets.only(left: 0.0),
//                                   child: TextButton(
//                                     onPressed: () async {
//                                       _pageController.nextPage(
//                                         duration: Duration(milliseconds: 500),
//                                         curve: Curves.ease,
//                                       );
//                                     },
//                                     child: Text(
//                                       "Next",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.02),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : GestureDetector(
//                         onTap: () async {
//                           Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) => LoginHome(),
//                             ),
//                             (Route route) => false,
//                           );
//                         },
//                         child: Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.only(
//                               top: MediaQuery.of(context).size.height * 0.01,
//                               bottom:
//                                   MediaQuery.of(context).size.height * 0.00),
//                           margin: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.height * 0.04,
//                               right: MediaQuery.of(context).size.height * 0.04),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(
//                                       MediaQuery.of(context).size.height *
//                                           0.012,
//                                     ),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.centerRight,
//                                       end: Alignment.center,
//                                       stops: [0.5, 0.9],
//                                       colors: [
//                                         Color(0xFF126086),
//                                         Color(0xFF126086)
//                                       ],
//                                     ),
//                                   ),
//                                   alignment: Alignment.center,
//                                   padding: EdgeInsets.only(left: 0.0),
//                                   child: TextButton(
//                                     onPressed: () async {
//                                       Navigator.of(context).pushAndRemoveUntil(
//                                         MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               LoginHome(),
//                                         ),
//                                         (Route route) => false,
//                                       );
//                                     },
//                                     child: Text(
//                                       "Get started",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.02),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OnboardingImage extends StatelessWidget {
//   final String image;
//
//   const OnboardingImage({
//     Key? key,
//     required this.image,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.00),
//       child: Image.asset(
//         image,
//         height: MediaQuery.of(context).size.height *  0.25,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }
//
// class OnboardingText extends StatelessWidget {
//   final String title;
//   final String description;
//
//   const OnboardingText({
//     Key? key,
//     required this.title,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
//       decoration: BoxDecoration(
//         color: Colors.white, // Set the background color of the container
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0), // Top-left curve
//           topRight: Radius.circular(20.0), // Top-right curve
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3), // Shadow color with opacity
//             offset: Offset(0, -4), // Offset to place the shadow above
//             blurRadius: 10.0, // Blur radius for soft shadow
//             spreadRadius:
//                 2.0, // Spread radius to make shadow appear more prominent
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(left: 30,right: 30),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.height * 0.025,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.012),
//           Container(
//             padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.height * 0.06,
//                 right: MediaQuery.of(context).size.height * 0.06,
//                 bottom: MediaQuery.of(context).size.height * 0.00,
//                 top: MediaQuery.of(context).size.height * 0.00),
//             color: Colors.white,
//             child: Text(
//               description,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.height * 0.018,
//                 color: Color(0xFF6A6E83),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/onboarding0.png",
      "title": "Find the best Doctors in your vicinity",
      "description":
      "With the help of our intelligent algorithms, now locate the best doctors around your vicinity at total ease."
    },
    {
      "image": "assets/onboarding1.png",
      "title": "Schedule appointments with expert doctors",
      "description":
      "Find experienced specialist doctors with expert ratings and reviews and book your appointments hassle-free."
    },
    {
      "image": "assets/onboarding2.png",
      "title": "Find the best caretaker for your family",
      "description":
      "Find best and experienced nurses and caretakers with expert ratings and reviews."
    },
  ];

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }
  void _previousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.dark, // Light icons for dark backgrounds
      ),
      child: Scaffold(

        body: Container(
          color : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Skip Button
              Expanded(
                  flex: 2,
                  child:
                  _currentIndex < _onboardingData.length - 1 ?
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginHome(),
                        ),
                            (Route route) => false,
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,


                      child: Container(
                        // color: Colors.red,
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Container(
                          // height: MediaQuery.of(context).size.height * 0.035, // Height relative to screen size
                          decoration: BoxDecoration(
                            color: Colors.blue
                                .withOpacity(0.1), // Light background color
                            borderRadius: BorderRadius.circular(
                                5
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *
                                0.03,
                            vertical: MediaQuery.of(context).size.height * 0.002,// Reactive horizontal padding
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => LoginHome(),
                                ),
                                    (Route route) => false,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Color(0xFF126086),
                                fontSize: MediaQuery.of(context).size.height *
                                    0.016, // Reactive font size
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : SizedBox()

              ),

              // Image and Text PageView (Both Controlled by Same PageController)
              Expanded(
                flex: 9 ,
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) {
                      // Swipe Left (Next)
                      _nextPage();
                    } else if (details.primaryVelocity! > 0) {
                      // Swipe Right (Previous)
                      _previousPage();
                    }
                  },
                  child: Container(

                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [



                        Expanded(
                          flex: 4,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(opacity: animation, child: child),
                            child: Align(
                              key: ValueKey<int>(_currentIndex), // important for proper switching
                              alignment: (_currentIndex == 0 || _currentIndex == 3)
                                  ? Alignment.bottomCenter
                                  : Alignment.center,
                              child: OnboardingImage(
                                image: _onboardingData[_currentIndex]["image"]!,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(opacity: animation, child: child),
                            child: OnboardingText(
                              key: ValueKey<int>(_currentIndex), // ensure transition happens
                              title: _onboardingData[_currentIndex]["title"]!,
                              description: _onboardingData[_currentIndex]["description"]!,
                              length: _onboardingData.length,
                              currentIndex: _currentIndex,
                              context: context,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),



              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: _buildPageIndicator(),
                    // ),
                    _currentIndex < _onboardingData.length - 1 ?
                    GestureDetector(
                      onTap: () async {
                        _nextPage();
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom:
                            MediaQuery.of(context).size.height * 0.00),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.height * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.center,
                                    stops: [0.5, 0.9],
                                    colors: [
                                      Color(0xFF126086),
                                      Color(0xFF126086)
                                    ],
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    _nextPage();
                                  },
                                  child: Text(
                                    "Next",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.02),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginHome(),
                          ),
                              (Route route) => false,
                        );
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom:
                            MediaQuery.of(context).size.height * 0.00),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.height * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.center,
                                    stops: [0.5, 0.9],
                                    colors: [
                                      Color(0xFF126086),
                                      Color(0xFF126086)
                                    ],
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginHome(),
                                      ),
                                          (Route route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Get started",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.02),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Image widget with slight downward offset
class OnboardingImage extends StatelessWidget {
  final String image;
  // final double height ;

  const OnboardingImage({
    Key? key,
    required this.image,
    // required this.height,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.00),
      child: Image.asset(
        image,
        height: MediaQuery.of(context).size.height *  0.8,
        fit: BoxFit.contain,
      ),
    );
  }
}

class OnboardingText extends StatelessWidget {
  final String title;
  final String description;
  final int length;
  final int currentIndex;
  final BuildContext context;

  OnboardingText({
    Key? key,
    required this.title,
    required this.description,
    required this.length,
    required this.currentIndex,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              height: 10, // Small height to create only top shadow
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, -4),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
            height: MediaQuery.of(context).size.height * 0.25,

            decoration: BoxDecoration(
              color: Colors.white, // Set the background color of the container
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), // Top-left curve
                topRight: Radius.circular(20.0), // Top-right curve
              ),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(

                  height: 70,
                  child: Padding(
                    padding:  EdgeInsets.only(
                      left : MediaQuery.of(context).size.height * 0.07,
                      right: MediaQuery.of(context).size.height * 0.07,
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.027,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                Container(
                  height: 90,

                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.06,
                      right: MediaQuery.of(context).size.height * 0.06,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.00),
                  color: Colors.white,
                  // color :Colors.blue,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.018,
                      color: Color(0xFF6A6E83),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 10, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                length,
                    (index) => _indicator(index == currentIndex,context),
              ),
            ),
          ),

        ]
    );
  }

  Widget _indicator(bool isActive,BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.015,
          bottom: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.height * 0.0,
          right: MediaQuery.of(context).size.height * 0.0),
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: MediaQuery.of(context).size.height * 0.005,
      width: isActive
          ? MediaQuery.of(context).size.height * 0.04
          : MediaQuery.of(context).size.height * 0.006,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF126086) : Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}





