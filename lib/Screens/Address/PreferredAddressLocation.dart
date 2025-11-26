import 'package:flutter/material.dart';

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
  String useraddressValue = "QCT Clinic A, Qatar 500006";
  int selectedIndex = -1;
  int selectedFilterIndex = 0;

  // Data
  final List<String> filters = [
    "All", "Doha", "Al Wakrah", "Al Khor", "Umm Salal", "Al Rayyan", "Madinat"
  ];

  final List<Map<String, dynamic>> clinics = [
    {"name": "QCT Clinic A, Doha", "distance": "1.0 km"},
    {"name": "QCT Clinic B, Doha", "distance": "2.0 km"},
    {"name": "QCT Clinic C, Doha", "distance": "3.0 km"},
    {"name": "QCT Clinic D, Doha", "distance": "5.0 km"},
    {"name": "QCT Clinic E, Doha", "distance": "8.0 km"},
    {"name": "QCT Clinic F, Doha", "distance": "3.6 km"},
    {"name": "QCT Clinic G, Doha", "distance": "7.7 km"},
  ];

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
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                // ---------------------------------------------------------
                // 1. Header Section
                // ---------------------------------------------------------
                Container(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.07,
                    left: screenWidth * 0.045,
                    right: screenWidth * 0.045,
                    bottom: screenWidth * 0.06,
                  ),
                  margin: EdgeInsets.only(
                    bottom: screenHeight * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Back Button
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          width: MediaQuery.of(context).size.height * 0.035,
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),
                          decoration: BoxDecoration(
                            color: Color(0xFF126086).withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(width: 0.0, color: Color(0xFF126086)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(130.0),
                            child: Image.asset(
                              'assets/medicationBack.png',
                              fit: BoxFit.fill,
                              errorBuilder: (c, o, s) => Icon(Icons.arrow_back_ios_new, size: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Title and Dropdown Text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005),
                            child: Text(
                              usernameValue,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    useraddressValue,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: MediaQuery.of(context).size.height * 0.012,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---------------------------------------------------------
                // 2. White Expanded Body
                // ---------------------------------------------------------
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
                                          : Colors.grey[700],
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
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                            itemCount: clinics.length,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                                  padding: EdgeInsets.all(screenHeight * 0.015),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryBlue : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected ? primaryBlue : Colors.grey.shade200,
                                    ),
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
                                          Text(
                                            clinics[index]["name"],
                                            style: TextStyle(
                                              color: isSelected ? Colors.white : Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenHeight * 0.012,
                                            ),
                                          ),
                                          SizedBox(height: 4),

                                          // --- LOCATION ROW CHANGED HERE ---
                                          Row(
                                            children: [
                                              // 1. Custom Image Icon
                                              Image.asset(
                                                'assets/location_ls.png',
                                                height: screenHeight * 0.016,
                                                width: screenHeight * 0.016,
                                                // If the icon is black/colored and you want it white when selected:
                                                color: isSelected ? Colors.white70 : null,
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(width: 4),

                                              // 2. RichText for colored parts
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "${clinics[index]["distance"]} ", // e.g., "1.0 km "
                                                      style: TextStyle(
                                                        // Use white if selected, otherwise use custom Orange
                                                        color: isSelected ? Colors.white : distanceColor,
                                                        fontSize: screenHeight * 0.012,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "Far from your location",
                                                      style: TextStyle(
                                                        // Use white70 if selected, otherwise use custom Blue
                                                        color: isSelected ? Colors.white70 : locationTextColor,
                                                        fontSize: screenHeight * 0.012,
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
                                  onPressed: selectedIndex == -1 ? null : () {},
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