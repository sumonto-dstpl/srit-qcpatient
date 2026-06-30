import 'package:flutter/material.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/Header/header.dart';

class PreferredHospitalLocationScreen extends StatefulWidget {
  const PreferredHospitalLocationScreen({Key? key}) : super(key: key);

  @override
  State<PreferredHospitalLocationScreen> createState() =>
      _PreferredHospitalLocationScreenState();
}

class _PreferredHospitalLocationScreenState
    extends State<PreferredHospitalLocationScreen> {
  // Controllers
  TextEditingController SearchEditTextController = TextEditingController();

  // State variables
  String usernameValue = "Preferred Hospital Location";
  String useraddressValue = "";
  int selectedIndex = -1;
  int selectedFilterIndex = 0;

  // Data
  final List<String> filters = [
    "All", "Doha", "Al Wakrah", "Al Khor", "Umm Salal", "Al Rayyan", "Madinat"
  ];

  List<dynamic> list = [];
  List<dynamic> filterlist = [];
  List<dynamic> displaylist = [];

  String selectedFilter = "All" ;

  String changeLocation = '';
  @override
  void initState() {
    super.initState();
    _loadData( selectedFilter);

    SearchEditTextController.addListener(() {
      _search(SearchEditTextController.text.toString());
    });
  }

  void _search(String query) {

    setState(() {
      if (query.isEmpty ) {

        displaylist = filterlist;


      } else {
        final pattern = RegExp(RegExp.escape(query), caseSensitive: false);

        displaylist = filterlist.where((item) {
          final name = item["name"] ?? '';
          final area = item["area"] ?? '';
          final street = item["street"] ?? '';
          final locality = item["locality"] ?? '';
          return pattern.hasMatch(name) || pattern.hasMatch(area) || pattern.hasMatch(street) || pattern.hasMatch(locality) ;
        }).toList();

      }

    });
  }

  Future<void> _loadData(String status) async {
    print("selectedFilter : $selectedFilter");
    final List phys = DummyData.hospitalLocations;


    if (status.toLowerCase() == "all") {
      list = phys;

    } else {
      list = phys.where((item) =>
      item["city"].toString().toLowerCase() ==
          selectedFilter.toLowerCase()).toList();

    }

    setState(() {
      filterlist = list;
      displaylist = filterlist;

    });

    print("displaylist : $displaylist");
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final Color primaryBlue = const Color(0xFF126086);


    // Define your custom colors here for easy usage
    final Color distanceColor = const Color(0xFFE89B26); // Orange
    final Color locationTextColor = const Color(0xFF1B99D6); // Blue

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(

            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[


                // Header(usernameValue : "Prefered Hospital Location",hideInkWell: false,hideNotificationProfile: false,),
                Header(userName: 'Prefered Hospital Location',showCartNotProfile: false,),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenHeight * 0.03),
                        topRight: Radius.circular(screenHeight * 0.03),
                      ),
                    ),
                    child: Column(
                      children: [
                        // --- Search Component ---
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.025,
                                bottom: MediaQuery.of(context).size.height * 0.01
                            ),
                            child: TextFormField(
                              controller: SearchEditTextController,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.height * 0.015,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.025,
                                  top: MediaQuery.of(context).size.height * 0.015,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF7F5F6),
                                hintText: "Search for area,street name,locality...",
                                hintStyle: TextStyle(
                                  color: Color(0xFF1F1F1F),
                                  fontSize: MediaQuery.of(context).size.height * 0.014,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                  size: MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // --- Horizontal Filters ---
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            bottom: screenHeight * 0.015,
                          ),
                          child: Row(
                            children: List.generate(filters.length, (index) {
                              bool isFilterSelected = index == selectedFilterIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilterIndex = index;
                                    selectedFilter = filters[index];
                                    _loadData(selectedFilter);
                                    SearchEditTextController.clear();
                                    selectedIndex = -1;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: screenWidth * 0.02),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.008,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isFilterSelected
                                        ? primaryBlue
                                        : const Color(0x1A126086),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    filters[index],
                                    style: TextStyle(
                                      color: isFilterSelected
                                          ? Colors.white
                                          : Color(0xFF126086),
                                      fontSize: screenHeight * 0.010,
                                      fontWeight: isFilterSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        // --- Clinic List ---
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: displaylist.length,
                            itemBuilder: (context, index) {
                              final item = displaylist[index];
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    changeLocation = "${item['name']}";

                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 0.3,vertical: 0.3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      colors: isSelected ? [Colors.white,Colors.white]: [Color(0xFF1B99D6), Color(0xFF00C7B7).withOpacity(0.7)],

                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? primaryBlue : Colors.white,

                                      borderRadius: BorderRadius.circular(12),

                                    ),
                                    child: Row(
                                      children: [
                                        // Logo
                                        Container(
                                          height: screenHeight * 0.05,
                                          width: screenHeight * 0.05,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey.shade300)
                                          ),
                                          child: Center(
                                            child: Text("QC", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.04),
                                        // Details
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: isSelected ? Colors.white : Color(0xFF000000),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: screenHeight * 0.012,
                                                    ),
                                                    children: [
                                                      TextSpan(text: item["name"]),
                                                      TextSpan(text: " "),
                                                      TextSpan(text: item["area"]),
                                                      TextSpan(text: " "),
                                                      TextSpan(text: item["street"]),
                                                      TextSpan(text: " "),
                                                      TextSpan(text: item["city"]),




                                                    ]
                                                )),
                                            SizedBox(height: 4),

                                            // --- LOCATION ROW CHANGED HERE ---
                                            Row(
                                              children: [
                                                // 1. Custom Image Icon
                                                Image.asset(
                                                  'assets/location_ls.png',
                                                  height: screenHeight * 0.009,
                                                  width: screenHeight * 0.009,
                                                  // If the icon is black/colored and you want it white when selected:
                                                  color: isSelected ? Color(0xFFFFFFFF) : Color(0xFF00C5BB),
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(width: 4),

                                                // 2. RichText for colored parts
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "${item["distance"]} ", // e.g., "1.0 km "
                                                        style: TextStyle(
                                                          // Use white if selected, otherwise use custom Orange
                                                          color:  distanceColor,
                                                          fontSize: screenHeight * 0.009,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "Far from your location",
                                                        style: TextStyle(
                                                          // Use white70 if selected, otherwise use custom Blue
                                                          color: isSelected ? Colors.white : locationTextColor,
                                                          fontSize: screenHeight * 0.009,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // --- Bottom Footer ---
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
                          ),
                          child: Column(
                            children: [
                              Text("Changing the location", style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenHeight * 0.014)),
                              SizedBox(height: 8),
                              Text("You Can Also Change The Hospital Location From Homepage", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontSize: screenHeight * 0.012)),
                              SizedBox(height: screenHeight * 0.02),
                              SizedBox(
                                width: double.infinity,
                                height: screenHeight * 0.06,
                                child: ElevatedButton(
                                  onPressed: selectedIndex == -1 ? null : () {
                                    setState(() {
                                      print("changeLocation : $changeLocation");
                                      DummyData.hospitalLocationNotifier.value = changeLocation;
                                      selectedIndex = -1;
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    disabledBackgroundColor: Colors.grey[400],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.018, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


