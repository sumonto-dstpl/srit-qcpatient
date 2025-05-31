import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double dotWidth = screenWidth * 0.05; // 5% of screen width for dot width
    double dotHeight = 3.0; // Fixed height for dots
    double bottomPosition =
        screenHeight * 0.05; // 5% from the bottom of the screen
    // Calculate dynamic padding based on screen width/height
    double verticalPadding =
        screenHeight * 0.02; // 2% of screen height for vertical padding
    double horizontalPadding =
        screenWidth * 0.04; // 4% of screen width for horizontal padding

    // Adjust carousel and item height based on screen height
    double carouselItemHeight = screenHeight * 0.15; // 20% of screen height

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          width: screenWidth,
          margin: EdgeInsets.only(
            right: screenHeight * 0.02,
            top: screenHeight * 0.0,
            bottom: screenHeight * 0.0,
            left: screenHeight * 0.02,
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              // height: carouselItemHeight,
              //1128 /387
              aspectRatio: 1128 / 387,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              viewportFraction: 1.0,
              // Reverse the order by changing how items are added
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: [
              Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: screenHeight * 0.01,
                      top: screenHeight * 0.0,
                      bottom: screenHeight * 0.0,
                      left: screenHeight * 0.01,
                    ), // Responsive margin outside of the container
                    child: AspectRatio(
                      aspectRatio: 1128 /
                          387, // Use the actual aspect ratio of your image
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.0,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ), // Responsive margin
                        // height: carouselItemHeight,
                        decoration: BoxDecoration(
                          // color: Color(
                          //     0xFFC80000), // Fallback color if image fails to load
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/B2_ls.png'), // Path to your banner image
                            // fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.0),
                              offset: Offset(0, 4),
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 4, // 6 out of 10 for the text section
                              child: Container(),
                            ),
                            Flexible(
                              flex: 6, // 6 out of 10 for the text section
                              child: Padding(
                                padding: EdgeInsets.all(verticalPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Patient Mobile App",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: screenHeight * 0.014,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.00,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Caring for you, every step of the way",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: screenHeight * 0.01,
                      top: screenHeight * 0.0,
                      bottom: screenHeight * 0.0,
                      left: screenHeight * 0.01,
                    ), // Responsive margin
                    // height: carouselItemHeight,
                    child: AspectRatio(
                      aspectRatio: 1128 /
                          387, // Use the actual aspect ratio of your image
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.0,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ), // Responsive margin
                        // height: carouselItemHeight,

                        decoration: BoxDecoration(
                          // color: Color(
                          //     0xFFC80000), // Fallback color if image fails to load
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/B3_ls.png'), // Path to your banner image
                            // fit: BoxFit.fill,
                            // Adjust to cover the entire container
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.0),
                              offset: Offset(0, 4),
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 6, // 6 out of 10 for the text section
                              child: Padding(
                                padding: EdgeInsets.all(verticalPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Patient Mobile App",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: screenHeight * 0.014,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.00,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Caring for you, every step of the way",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4, // 6 out of 10 for the text section
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: screenHeight * 0.01,
                      top: screenHeight * 0.0,
                      bottom: screenHeight * 0.0,
                      left: screenHeight * 0.01,
                    ), // Responsive margin outside of the container
                    child: AspectRatio(
                      aspectRatio: 1128 /
                          387, // Use the actual aspect ratio of your image
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.0,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ), // Responsive margin
                        // height: carouselItemHeight,
                        decoration: BoxDecoration(
                          // color: Color(
                          //     0xFFC80000), // Fallback color if image fails to load
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/B2_ls.png'), // Path to your banner image
                            // fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.0),
                              offset: Offset(0, 4),
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 4, // 6 out of 10 for the text section
                              child: Container(),
                            ),
                            Flexible(
                              flex: 6, // 6 out of 10 for the text section
                              child: Padding(
                                padding: EdgeInsets.all(verticalPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Patient Mobile App",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: screenHeight * 0.014,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.00,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Caring for you, every step of the way",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: screenHeight * 0.01,
                      top: screenHeight * 0.0,
                      bottom: screenHeight * 0.0,
                      left: screenHeight * 0.01,
                    ), // Responsive margin
                    // height: carouselItemHeight,
                    child: AspectRatio(
                      aspectRatio: 1128 /
                          387, // Use the actual aspect ratio of your image
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.0,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ), // Responsive margin
                        // height: carouselItemHeight,

                        decoration: BoxDecoration(
                          // color: Color(
                          //     0xFFC80000), // Fallback color if image fails to load
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/B3_ls.png'), // Path to your banner image
                            // fit: BoxFit.fill,
                            // Adjust to cover the entire container
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.0),
                              offset: Offset(0, 4),
                              blurRadius: 9,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 6, // 6 out of 10 for the text section
                              child: Padding(
                                padding: EdgeInsets.all(verticalPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Patient Mobile App",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: screenHeight * 0.014,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.00,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.02,
                                        right: screenHeight * 0.00,
                                      ),
                                      child: Text(
                                        "Caring for you, every step of the way",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.018,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4, // 6 out of 10 for the text section
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // Carousel Indicator
        Positioned(
          bottom: screenHeight * 0.01, // 5% from the bottom of the screen
          right: screenWidth * 0.42, // 10% from the right side of the screen
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Custom indicators for each screen
              for (int i = 0; i < 4; i++)
                Container(
                  width: _current == i
                      ? dotWidth
                      : screenWidth *
                          0.01, // Dynamic width based on screen size
                  height: dotHeight, // Fixed height for the dot
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    // color: _current == i
                    //     ? Color(0xFFFFFFFF)
                    //     : Theme.of(context).hintColor.withOpacity(0.3),

                    gradient: LinearGradient(
                      colors: _current == i
                          ? [
                              Color(0xFFFFFFFF),
                              Color(0xFFFFFFFF),
                            ]
                          : [
                              Color(0xFFFFFFFF), // White
                              Color(0xFF999999), // Gray
                            ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
