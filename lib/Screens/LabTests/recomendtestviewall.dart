import 'dart:ui';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/Dialog/delete_dialog.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/delete.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
import 'package:newfolder/Core/no-data_found.dart';
import 'package:newfolder/Screens/AddToCart/addtocarPackageDetails.dart';
import 'package:newfolder/Screens/LabTests/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../utils/cart_provider.dart';


class RecommendedViewAll extends StatefulWidget {
  String usernameValue ;
  int selectedIndex = 0;
  final String mode ;
  final String categoryName ;
  RecommendedViewAll({
    super.key,
    required this.usernameValue,
    required this.mode , // health_condition , test, health_package
    required this.categoryName,
  });
  @override
  State<RecommendedViewAll> createState() => RecommendedViewAllstate();
}

class RecommendedViewAllstate extends State<RecommendedViewAll> {

  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  TextEditingController SearchfilterEditTextController = TextEditingController();


  // List of filter categories
  final List<String> categories = [
    'Must have tests',
    'Category',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;






  List<dynamic> addedList=[];

  List<Map<String, dynamic>> pageDataList = [];
  List<Map<String, dynamic>> filterPageDataList = [];
  bool showNoDataFound = false;

  @override
  void initState(){
    // getSharedPrefs();
    super.initState();
    _fetchDataForThisCategory();
    _loadData();
    Provider.of<CartProvider>(context, listen: false).loadCart();
    // setState(() {});
  }

  void _fetchDataForThisCategory() {
    // Yahan hum pure 250 items me se sirf wo 10 nikal rahe hain jo user dekhna chahta hai
    setState(() {
      pageDataList = DummyData.cartList.where((item) {
        return item['type'] == widget.mode && item['categoryName'] == widget.categoryName;
      }).toList();

      filterPageDataList = pageDataList ;
      if(pageDataList.isNotEmpty){
        filterPageDataList = pageDataList ;
        showNoDataFound = false;
      }
      else {
        filterPageDataList = [] ;
        showNoDataFound = true;
      }
    });
  }
  void _loadData() async {
    print("loadData......................................");
    var guestUser = await UserSecureStorage.getIfGuestLogged();
    print("guestUser: $guestUser");
    final isGuestUser=guestUser == "YES";
    setState(() {});
    if(!isGuestUser) {
      String? username = await UserSecureStorage.getUsernameid();
      print("username: $username");
      // Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
      // print("user : $user");
      List<dynamic> _loadedCart2  = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');

      if(_loadedCart2.isNotEmpty){
        print("_loadedCart2.length:${_loadedCart2.length}");
        setState(() {

          addedList = _loadedCart2 ?? [];
        });
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Stack(children: [
          Column(
            children: <Widget>[
              Header(  userName: '${widget.usernameValue}',),

              Expanded(

        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 0.03),
                topRight: Radius.circular(screenHeight * 0.03),
                bottomLeft: Radius.circular(screenHeight * 0.0),
                bottomRight: Radius.circular(screenHeight * 0.00),
                // bottomCenter: 0,
              ),
            ),
            child : Column(
              children: [
      Container(
          padding: EdgeInsets.only(
              left: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0,
              right: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0,
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.03),
              topRight: Radius.circular(screenHeight * 0.03),
            ),
          ),
          child:
          Column(
            children: [
              // Search Input Field
              Container(

                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.0,
                  right: screenWidth * 0.0,
                  bottom: screenWidth * 0.01,
                ),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.01,
                    top: MediaQuery.of(context).size.height * 0.0,
                    bottom: MediaQuery.of(context).size.height * 0.0,
                    left: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                        width: screenHeight *
                            0.005), // Add spacing between widgets
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                bottom: screenHeight * 0.01),

                            child: TextFormField(
                              controller: SearchfilterEditTextController,
                              onChanged: (value) {
                                // Jaise hi user type karega, yeh filter function call hoga
                                _applyActiveFilters(searchQuery: value);
                              },
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => input!.length < 3
                                  ? "Search should be more than 3 characters"
                                  : null,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  top :   screenHeight * 0.012,
                                  left :   screenHeight * 0.02,
                                  right :   screenHeight * 0.012,
                                  bottom :   screenHeight * 0.012,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF7F5F6),
                                hintText: "Search by tests & packages",
                                hintStyle: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: screenHeight * 0.014,
                                    fontWeight: FontWeight.w400
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF7F5F6)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                ),
                                suffixIcon: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                                    children: [
                                      // Search Icon
                                      Icon(
                                        Icons.search,
                                        color: Colors.black45,
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.025,
                                      ),
                                      // Divider
                                      Container(
                                        width: 1, // Width of the divider
                                        height: 20, // Height of the divider
                                        color: Colors.grey, // Color of the divider
                                        margin: EdgeInsets.symmetric(horizontal: 8), // Spacing around the divider
                                      ),
                                      // Icon from Assets
                                      InkWell(
                                        onTap: () {

                                          showBottomSheet();


                                        },
                                        child: Image.asset(
                                          'assets/scansearch.png', // Replace with your actual asset path
                                          height: 15, // Height of the asset icon
                                          width: 15,  // Width of the asset icon
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ]
          ),
      ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.00),

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,

                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(screenHeight * 0.03),
                    //   topRight: Radius.circular(screenHeight * 0.03),
                    // ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                MediaQuery.of(context).size.height * 0.010,
                                top: MediaQuery.of(context).size.height * 0.0),
                            // height: MediaQuery.of(context).size.height * 0.190,
                            child:
                            showNoDataFound
                                ?   NoDataFound() // Aapka custom widget
                                :
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap:
                              true, // Prevents ListView from taking up extra space
                              scrollDirection: Axis
                                  .vertical, // Makes the ListView horizontal
                              itemCount: filterPageDataList.length, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                final item = filterPageDataList[index];

                                return GestureDetector(
                                  onTap: () {

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (BuildContext context) {
                                            return AddtocardPackageDetails(buttonName: "Add to Cart",id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                          },
                                        ),
                                      );


                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(

                                      color: Colors.white,
                                      child:
                                      Container(
                                        // color: Colors.white,

                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Background color of the container
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(
                                                  0.1), // Shadow color
                                              blurRadius:
                                              5, // Spread of the shadow
                                              offset: Offset(0,
                                                  0), // Offset in x and y direction
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.black12, // Border color
                                            width: 1.0, // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Rounded corners
                                        ),

                                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Container(

                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.01,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),

                                                    /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,
                                                      margin: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                      ),

                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(130.0),
                                                        child: Image.asset(
                                                          'assets/Harmonebackground.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[


                                                          Container(

                                                            child:
                                                            Text(
                                                               "${item['plan']}",
                                                              style: TextStyle(
                                                                  color: Colors.black87,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,
                                                          Container(

                                                            child:
                                                            Text(
                                                              // "100 Tests Included : Complete Blood Count",
                                                              "${item['test']}",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,
                                                          Container(

                                                            padding: EdgeInsets.zero,
                                                            child:
                                                            Text(
                                                              "Reports With in 24 Hours",
                                                              style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),


                                              // Bottom Row
                                              Container(
                                                padding: EdgeInsets.zero,
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(06),
                                                        ),
                                                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[

                                                                      // More Details
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          // color:Colors.white,
                                                                          borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                        // color:Colors.green[100],
                                                                        padding: EdgeInsets.zero,
                                                                        child:

                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: <Widget>[



                                                                              Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 2),
                                                                                height: MediaQuery.of(context).size.height * 0.004,
                                                                                width: MediaQuery.of(context).size.height * 0.004,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),

                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: MediaQuery.of(context).size.height * 0.005,
                                                                                          ),
                                                                                      child:
                                                                                      Text(
                                                                                        'QR 2999',
                                                                                        style: TextStyle(
                                                                                          // color: Colors.blue[600],
                                                                                            color: Colors.black,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            decoration: TextDecoration.lineThrough,
                                                                                            decorationThickness: 2,
                                                                                            fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.014),
                                                                                      )


                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        ),
                                                                                    child:
                                                                                    Text(
                                                                                      // "QR 1999",
                                                                                      "${item['qr']}",
                                                                                      style: TextStyle(
                                                                                        // color: Colors.blue[600],
                                                                                          color: Color(0xFF12B76A),
                                                                                          fontWeight: FontWeight.w500,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          fontSize: MediaQuery.of(context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.014),
                                                                                    ),

                                                                                  ),

                                                                                  Container(
                                                                                    margin: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        ),
                                                                                    height: screenHeight * 0.015,
                                                                                    width: screenHeight * 0.015,
                                                                                    decoration: BoxDecoration(
                                                                                      // color: Colors.blue[100]!.withOpacity(0.9),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Center( // Ensures the image is centered
                                                                                      child: Image.asset(
                                                                                        'assets/Offersicon.png', // Replace with your actual asset path
                                                                                        // color: Color(0xFF126086), // Optional: Apply color tint
                                                                                        height: screenHeight * 0.01,
                                                                                        width: screenHeight * 0.01,
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )


                                                                            ]
                                                                        ),

                                                                      ),


                                                                      Consumer<CartProvider>(
                                                                        builder: (context, cart, child) {
                                                                          bool isInCart = cart.isAdded(item['id']);

                                                                          return Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              !isInCart
                                                                                  ? GestureDetector(
                                                                                onTap: () async {
                                                                                  await cart.addItem({
                                                                                    "id": item['id'],
                                                                                    "plan": item['plan'],
                                                                                    "test": item['test'],
                                                                                    "qr": item['qr'],
                                                                                  });

                                                                                  showTopNotification(
                                                                                    context,
                                                                                    title: "Add Cart",
                                                                                    message: "Cart is added successfully",
                                                                                    type: NotificationType.success,
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                    horizontal: MediaQuery.of(context).size.height * 0.02,
                                                                                    vertical: MediaQuery.of(context).size.height * 0.006,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF126086),
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                  child: Text(
                                                                                    "Add",
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize:
                                                                                      MediaQuery.of(context).size.height * 0.015,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                                  : GestureDetector(
                                                                                onTap: () async {

                                                                                  final result = await DeleteDialog.show(
                                                                                    context: context,
                                                                                    barrierLabel: "CartDelete",
                                                                                    message: "Are you sure to Remove the Selected Cart ?",

                                                                                  );
                                                                                  if(result!) {
                                                                                    showTopNotification(
                                                                                      context,
                                                                                      title: "Cart Delete",
                                                                                      message: "Cart is deleted Successfully",
                                                                                      type: NotificationType.error,
                                                                                    );
                                                                                     cart.removeItem(item['id']);
                                                                                  }



                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                    horizontal: MediaQuery.of(context).size.height * 0.02,
                                                                                    vertical: MediaQuery.of(context).size.height * 0.006,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                  child: AppDeleteIcon(isCenter: true,),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      )


                                                                    ]
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ]),
                                              ),







                                            ]),
                                      ),




                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Additional widgets can be added here
                        ],
                      ),




                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ],

                  ),
                ),
              ),
              ],
            ),
        ),
      )
            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }


  Map<String, List<String>> activeFilters = {
    "mustHavetests":  [],
    "category":  [],

  };

  void showBottomSheet() async {

    final result = await showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent, // Make modal background transparent
      barrierColor: Colors.transparent,    // Disable default barrier color
      context: context,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, -2), // Shadow appears above the sheet
                    ),
                  ],
                  color: Colors.white, // White background for the bottom sheet
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: AddFilterForFullBodyCheckup(
                  initialFilters: activeFilters,
                ),
              ),
            ),
          ],
        );
      },
    );

    print("result : $result");

    if(result != null) {
      activeFilters = result as Map<String, List<String>>;
      _applyActiveFilters();
    }
    else {
      setState(() {
        filterPageDataList = pageDataList ;
        activeFilters = {
          "mustHavetests": [],
          "category": [],
        };
        showNoDataFound = false;
      });

    }
  }


  void _applyActiveFilters({String searchQuery = ""}) {
    List<Map<String, dynamic>> tmp = pageDataList.where((item) {

      if (searchQuery.isNotEmpty) {
        final plan = (item['plan'] ?? '').toString().toLowerCase();
        final test = (item['test'] ?? '').toString().toLowerCase();
        final searchLower = searchQuery.toLowerCase();

        // Agar plan ya test ke naam me search text nahi milta, toh false return karo
        if (!plan.contains(searchLower) && !test.contains(searchLower)) {
          return false;
        }
      }

      // 2. Category / Speciality Filter
      final selCategoryList = List<String>.from(activeFilters['category'] ?? []);
      if (selCategoryList.isNotEmpty) {
        final itemCategory = item['category'] ?? '';
        if (!selCategoryList.contains(itemCategory)) return false;
      }

      // 3. Language Filter
      final selLanguageList = List<String>.from(activeFilters['mustHavetests'] ?? []);
      if (selLanguageList.isNotEmpty) {
        final itemLanguage = item['mustHavetests'] ?? '';
        if (!selLanguageList.contains(itemLanguage)) return false;
      }





      return true;
    }).toList();
    setState(() {
      filterPageDataList = tmp;
      showNoDataFound = tmp.isEmpty;

    });


  }

  void addToCart(int id,String plan,String test,String qr) async{
     Map<String,dynamic> addToCart = {
       "id": id,
       "plan" : plan,
       "test" : test,
       "qr" : qr
     };

     print("addToCart : $addToCart");

     bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
     print("isGuestUser : $isGuestUser");
     String? username =  await UserSecureStorage.getUsernameid();

     Map<String, dynamic>? user = await UserSecureStorage.getUser(username ?? '');

     print("user : $user");

     if(isGuestUser){
       String userId = "GUEST";
       UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
     }
     else {
       String userId = username ?? '';
       UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
     }


     setState(() {
       addedList.insert(0, addToCart);
     });

   }



}
