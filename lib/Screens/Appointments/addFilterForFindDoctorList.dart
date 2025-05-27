import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddFilterForFindDoctorList extends StatefulWidget {
  @override
  AddFilterForFindDoctorListState createState() => AddFilterForFindDoctorListState();
}

class AddFilterForFindDoctorListState extends State<AddFilterForFindDoctorList> {
  final FocusNode _focusNode = FocusNode();

  DraggableScrollableController  _scrollController = DraggableScrollableController();


  TextEditingController SearchEditTextController = TextEditingController();
  TextEditingController SearchfilterEditTextController = TextEditingController();
  @override
  void dispose() {

    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // List of filter categories
  final List<String> categories = [
    'Experience',
    'Fees',
    'Availability',
    'Areas of Expertise',
    'Gender',
    'Language',
    'City',
  ];

  int selectedCategoryIndex = 0;

  int selectedCount = 0;
  bool _is0_5_Selected = false;
  bool _is6_10_Selected = false;
  bool _is11_16_Selected = false;
  bool _is17_21_Selected = false;
  bool _isQR_100_Selected = false;
  bool _isQR_500_Selected = false;
  bool _isQR_1000Selected = false;
  bool _is_Now_Selected = false;
  bool _is_Today_Selected = false;
  bool _is_Tomorrow_Selected = false;
  bool _is_Next_Selected = false;
  bool _is_AI_Selected = false;
  bool _is_AIP_Selected = false;
  bool _is_AIS_Selected = false;
  bool _is_AS_Selected = false;
  bool _is_BD_Selected = false;
  bool _is_BMS_Selected = false;
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  bool _isEnglishSelected = false;
  bool _isTamilSelected = false;
  bool _isKannadaSelected = false;
  bool _isHindiSelected = false;
  bool _isTeluguSelected = false;
  bool _isUrduSelected = false;
  bool _isKannadaSelectedSecondLine = false;
  bool _isTeluguSelectedSecondLine = false;
  bool _isBangaloreSelected = false;
  bool _ishosurSelected = false;
  bool _isChennaiSelected = false;
  bool _isMumbaiSelected = false;
  bool _isAgraSelected = false;
  bool _isDelhiSelected = false;
  bool _isChennaiSelectedSecondLine = false;
  bool _isAgraSelectedSecondLine = false;


  void clearAll(){
    setState(() {
      selectedCount = 0;
       _is0_5_Selected = false;
       _is6_10_Selected = false;
       _is11_16_Selected = false;
       _is17_21_Selected = false;

        _isQR_100_Selected = false;
        _isQR_500_Selected = false;
        _isQR_1000Selected = false;

       _is_Now_Selected = false;
       _is_Today_Selected = false;
       _is_Tomorrow_Selected = false;
       _is_Next_Selected = false;

       _is_AI_Selected = false;
       _is_AIP_Selected = false;
       _is_AIS_Selected = false;
       _is_AS_Selected = false;
       _is_BD_Selected = false;
        _is_BMS_Selected = false;

        _isMaleSelected = false;
        _isFemaleSelected = false;

        _isEnglishSelected = false;
        _isTamilSelected = false;
        _isKannadaSelected = false;
        _isHindiSelected = false;
        _isTeluguSelected = false;
        _isUrduSelected = false;

        _isKannadaSelectedSecondLine = false;
        _isTeluguSelectedSecondLine = false;

        _isBangaloreSelected = false;
        _ishosurSelected = false;
        _isChennaiSelected = false;
        _isMumbaiSelected = false;
        _isAgraSelected = false;
        _isDelhiSelected = false;

        _isChennaiSelectedSecondLine = false;
        _isAgraSelectedSecondLine = false;


    });
  }

  void _toggleButton(bool currentState, Function(bool) setStateCallback) {
    setState(() {
      final newState = !currentState;
      setStateCallback(newState);
      selectedCount += newState ? 1 : -1;
    });
  }

  double _currentChildSize = 0.55;
  bool _isDismissed = false;
  double _lastExtent = 0.55;
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {


    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _currentChildSize, // Start at 50% of screen height
      minChildSize: 0.3, // Minimum height (30% of screen)
      maxChildSize: 0.9, // Max height (90% of screen)
      expand: false,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification){
            final currentExtent = notification.extent;

            // ✅ Hide keyboard when dragging down
            if (currentExtent < _lastExtent - 0.01) {
              print("Dragging down - Hiding keyboard");
              FocusScope.of(context).unfocus();
            }

            // ✅ Dismiss the sheet if dragged below threshold
            if (!_isDismissed &&
                currentExtent < _currentChildSize - 0.05) {
              _isDismissed = true;
              Navigator.of(context).pop(); // Dismiss sheet
            }

            _lastExtent = currentExtent;
            return true;

          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (details) {
              final newSize = (_sheetController.size ?? _currentChildSize) -
                  details.primaryDelta! / MediaQuery.of(context).size.height;

              _sheetController.jumpTo(
                newSize.clamp(0.3, 0.95),
              );
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.025,
                          right: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.015),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Container(
                              //   padding: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.height * 0.0,
                              //     bottom: MediaQuery.of(context).size.height * 0.04,
                              //     left: MediaQuery.of(context).size.height * 0.18,
                              //     right: MediaQuery.of(context).size.height * 0.18,
                              //   ),
                              //   child: Divider(
                              //     height: 0,
                              //     indent: 0,
                              //     thickness: MediaQuery.of(context).size.height * 0.008,
                              //     color:Color(0xFF95C8D6).withOpacity(0.3),
                              //   ),
                              // ),

                              // Add Filters (1)

                              // Divider
                              GestureDetector(


                                child: Center(
                                  child: Container(

                                    padding: EdgeInsets.only(
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.01,
                                      bottom: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.03,
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.18,
                                      right: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.18,
                                    ),


                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.23,
                                    // Same thickness as Divider
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.006,
                                    // Same thickness as Divider
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD9D9D9), // Divider color
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded edges
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height : MediaQuery.of(context).size.height * 0.02),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.0,
                                    right: MediaQuery.of(context).size.height * 0.02,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height *
                                                    0.00,
                                                right: MediaQuery.of(context).size.height *
                                                    0.00,
                                                top: MediaQuery.of(context).size.height *
                                                    0.00,
                                                bottom: MediaQuery.of(context).size.height *
                                                    0.00),
                                            child: Text(
                                              "Add Filters",
                                              style: TextStyle(
                                                color: Color(0xFF2F3335),
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    0.02,
                                              ),
                                            ),
                                          ),
                                          if(selectedCount > 0)
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height *
                                                      0.00,
                                                  right: MediaQuery.of(context).size.height *
                                                      0.00,
                                                  top: MediaQuery.of(context).size.height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context).size.height *
                                                      0.00),
                                              child: Text(
                                                ' (${selectedCount})',
                                                style: TextStyle(
                                                  color: Color(0xFF2F3335),
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      0.015,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          clearAll();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context).size.height *
                                                  0.00,
                                              right:
                                              MediaQuery.of(context).size.height *
                                                  0.00,
                                              top: MediaQuery.of(context).size.height *
                                                  0.00,
                                              bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.00),
                                          child: Text(
                                            "Clear all",
                                            style: TextStyle(
                                              color: Color(0xFF126086),
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  0.012,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),



                    Row(
                      children: [

                        // Left Side: Categories List
                        Expanded(
                          flex : 2,
                          child:
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF95C8D6).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.020,
                                // right: MediaQuery.of(context).size.height * 0.0,
                                top: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.02),
                            // width: MediaQuery.of(context).size.height * 0.2,
                            height: MediaQuery.of(context).size.height * 0.37,
                            child: ListView.builder(
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedCategoryIndex == index
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (selectedCategoryIndex ==
                                            index) // Show the side line only for the selected cell
                                          Positioned(
                                            top: 6, // Gap from the top
                                            left: 0,
                                            bottom: 6, // Gap from the bottom
                                            child: Container(
                                              width: 2.0, // Same as border width
                                              color:  Color(0xFF126086), // Border color
                                            ),
                                          ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left : MediaQuery.of(context).size.height * 0.015,
                                            bottom: MediaQuery.of(context).size.height * 0.01,
                                            top : MediaQuery.of(context).size.height * 0.01,
                                          ),
                                          child: Text(
                                            categories[index],
                                            style: TextStyle(
                                              color: selectedCategoryIndex == index
                                                  ? Color(0xFF126086) : Colors.black87,
                                              fontSize: MediaQuery.of(context).size.height * 0.014,
                                              fontWeight: selectedCategoryIndex == index
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Right Side: Filter Options
                        Expanded(
                          flex : 3,
                          child:
                          Container(
                            height: MediaQuery.of(context).size.height * 0.39,
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
                            child: _getFilterWidget(categories[selectedCategoryIndex], context),
                          ),
                        ),
                      ],
                    ),


                    // Apply Filters
                    GestureDetector(
                      onTap: () async {

                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                            // top:
                            // MediaQuery.of(context).size.height * 0.0,
                            // bottom:
                            // MediaQuery.of(context).size.height * 0.00,
                              left:
                              MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height *
                                  0.02
                          ),
                          margin: EdgeInsets.only(
                              right:
                              MediaQuery.of(context).size.height * 0.02,
                              // top:
                              // MediaQuery.of(context).size.height * 0.01,
                              // bottom:
                              // MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height *
                                  0.02),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height :  MediaQuery.of(context) .size .height * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.012),
                                      // gradient: LinearGradient(
                                      //     begin: Alignment.centerRight,
                                      //     end: Alignment.center,
                                      //     stops: [
                                      //       0.5,
                                      //       0.9
                                      //     ],
                                      //     colors: [
                                      //       Color(0xFFA8B1CE),
                                      //       Color(0xFFA8B1CE),
                                      //     ])
                                      color: selectedCount == 0 ?  Color(0x99909090) : Color(0xFF126086),

                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    child: TextButton(
                                      onPressed: () async {

                                      },
                                      child: Text("Apply Filters",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.02,
                                          fontWeight: FontWeight.w600,
                                        ),


                                      ),
                                    ),
                                  ),
                                ),
                              ])),
                    )



                  ],
                ),
              ),
            ),
          ),
        ) ; },
    );
  }


  Widget _getFilterWidget(String category, BuildContext context) {
    switch (category) {
      case 'Experience':
        return   _experienceFilterWidget(context);
      case 'Fees':
        return _feesFilterWidget(context);
      case 'Availability':
        return _availabilityFilterWidget(context);

      case 'Areas of Expertise':
        return   _areas_of_ExpertiseFilterWidget(context);
      case 'Gender':
        return _genderFilterWidget(context);
      case 'Language':
        return _languageFilterWidget(context);
      case 'City':
        return _cityFilterWidget(context);
      default:
        return Container();
    }
  }

  Widget _experienceFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        // GestureDetector(
        //   onTap: () {
        //     _focusNode.requestFocus(); // Show keyboard
        //   },
        //   child: Container(
        //
        //     height: MediaQuery.of(context).size.height * 0.038,
        //     alignment: Alignment.centerRight,
        //     padding: EdgeInsets.only(
        //       top: MediaQuery.of(context).size.height * 0.0,
        //       bottom: MediaQuery.of(context).size.height * 0.00,
        //       left: MediaQuery.of(context).size.height * 0.00,
        //       right: MediaQuery.of(context).size.height * 0.00,
        //     ),
        //     margin: EdgeInsets.only(
        //       right: MediaQuery.of(context).size.height * 0.01,
        //       top: MediaQuery.of(context).size.height * 0.0,
        //       bottom: MediaQuery.of(context).size.height * 0.01,
        //       left: MediaQuery.of(context).size.height * 0.01,
        //     ),
        //     child: TextFormField(
        //       focusNode: _focusNode, // Attach the focus node
        //       readOnly: false, // Important: set to false so it can accept input
        //
        //       controller: SearchfilterEditTextController,
        //       inputFormatters: [
        //         LengthLimitingTextInputFormatter(15),
        //         FilteringTextInputFormatter.allow(
        //             RegExp('[a-zA-Z0-9]')),
        //       ],
        //       // textCapitalization: TextCapitalization.characters,
        //       style: TextStyle(color: Colors.black45),
        //       keyboardType: TextInputType.emailAddress,
        //       validator: (input) => input!.length < 3
        //           ? "Search should be more than 3 characters"
        //           : null,
        //       decoration: InputDecoration(
        //         isDense: true,
        //         contentPadding:
        //         EdgeInsets.only(
        //           left : MediaQuery.of(context).size.height * 0.012,
        //
        //         ),
        //         filled: true,
        //         // fillColor: Colors.grey[200],
        //         fillColor: Color(0xFFF7F5F6).withOpacity(0.9),
        //         hintText:
        //         "Search",
        //         hintStyle: TextStyle(
        //             color: Color(0xFFA8A8A8),
        //             fontSize: MediaQuery.of(context).size.height * 0.012,
        //             fontWeight: FontWeight.w500
        //         ),
        //         focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(5.0),
        //           borderSide: BorderSide(color: Colors.grey),
        //         ),
        //         enabledBorder: OutlineInputBorder(
        //           borderRadius:
        //           BorderRadius. all(Radius.circular(8.0)),
        //           borderSide: BorderSide(color: Colors.white),
        //         ),
        //         suffixIcon: IconButton(
        //           icon: Icon(
        //             Icons.search,
        //             color: Colors.black45,
        //             size: MediaQuery
        //                 .of(context)
        //                 .size
        //                 .height * 0.02,
        //           ),
        //           onPressed: () {
        //
        //           },
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        // [ Stable & Unstable]
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is0_5_Selected == false){
                      _toggleButton(_is0_5_Selected, (val) => _is0_5_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is0_5_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "0 - 5 Years",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is0_5_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is0_5_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is0_5_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is0_5_Selected){
                                          _toggleButton(_is0_5_Selected, (val) => _is0_5_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Female
                GestureDetector(

                  onTap: () {
                    if(_is6_10_Selected == false){
                      _toggleButton(_is6_10_Selected, (val) => _is6_10_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is6_10_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "6 - 10 Years",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is6_10_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is6_10_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is6_10_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is6_10_Selected){
                                          _toggleButton(_is6_10_Selected, (val) => _is6_10_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),



              ]
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is11_16_Selected == false){
                      _toggleButton(_is11_16_Selected, (val) => _is11_16_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is11_16_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "11 - 16 Years",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is11_16_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is11_16_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is11_16_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is11_16_Selected){
                                          _toggleButton(_is11_16_Selected, (val) => _is11_16_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Female
                GestureDetector(

                  onTap: () {
                    if(_is17_21_Selected == false){
                      _toggleButton(_is17_21_Selected, (val) => _is17_21_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is17_21_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "17 - 21 Years",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is17_21_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is17_21_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is17_21_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is17_21_Selected){
                                          _toggleButton(_is17_21_Selected, (val) => _is17_21_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

                

              ]
          ),
        ),

      ],
    );
  }
  Widget _feesFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_isQR_100_Selected == false){
                      _toggleButton(_isQR_100_Selected, (val) => _isQR_100_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _isQR_100_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "QR 100-500",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isQR_100_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_isQR_100_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_isQR_100_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_isQR_100_Selected){
                                          _toggleButton(_isQR_100_Selected, (val) => _isQR_100_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Female
                GestureDetector(

                  onTap: () {
                    if(_isQR_500_Selected == false){
                      _toggleButton(_isQR_500_Selected, (val) => _isQR_500_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _isQR_500_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "QR 500-1000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isQR_500_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_isQR_500_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_isQR_500_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_isQR_500_Selected){
                                          _toggleButton(_isQR_500_Selected, (val) => _isQR_500_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

                

              ]
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_isQR_1000Selected == false){
                      _toggleButton(_isQR_1000Selected, (val) => _isQR_1000Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _isQR_1000Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "QR 1000-5000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isQR_1000Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_isQR_1000Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_isQR_1000Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_isQR_1000Selected){
                                          _toggleButton(_isQR_1000Selected, (val) => _isQR_1000Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                

              ]
          ),
        ),





      ],
    );
  }
  Widget _availabilityFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is_Now_Selected == false){
                      _toggleButton(_is_Now_Selected, (val) => _is_Now_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_Now_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Now",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Now_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Now_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Now_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Now_Selected){
                                          _toggleButton(_is_Now_Selected, (val) => _is_Now_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Female
                GestureDetector(

                  onTap: () {
                    if(_is_Today_Selected == false){
                      _toggleButton(_is_Today_Selected, (val) => _is_Today_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_Today_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Today",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Today_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Today_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Today_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Today_Selected){
                                          _toggleButton(_is_Today_Selected, (val) => _is_Today_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

                

              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is_Tomorrow_Selected == false){
                      _toggleButton(_is_Tomorrow_Selected, (val) => _is_Tomorrow_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_Tomorrow_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Tomorrow",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Tomorrow_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Tomorrow_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Tomorrow_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Tomorrow_Selected){
                                          _toggleButton(_is_Tomorrow_Selected, (val) => _is_Tomorrow_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),


              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                // Others
                GestureDetector(

                  onTap: () {
                    if(_is_Next_Selected == false){
                      _toggleButton(_is_Next_Selected, (val) => _is_Next_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: _is_Next_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_Next_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Next 3 Days",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Next_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Next_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Next_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Next_Selected){
                                          _toggleButton(_is_Next_Selected, (val) => _is_Next_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

              ]
          ),
        ),
         
        

      ],
    );
  }

  Widget _areas_of_ExpertiseFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        GestureDetector(
          onTap: () {
            _focusNode.requestFocus(); // Show keyboard
          },
          child: Container(

            height: MediaQuery.of(context).size.height * 0.038,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.00,
              left: MediaQuery.of(context).size.height * 0.00,
              right: MediaQuery.of(context).size.height * 0.00,
            ),
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.height * 0.01,
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.01,
            ),
            child: TextFormField(
              focusNode: _focusNode, // Attach the focus node
              readOnly: false, // Important: set to false so it can accept input

              controller: SearchfilterEditTextController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]')),
              ],
              // textCapitalization: TextCapitalization.characters,
              style: TextStyle(color: Colors.black45),
              keyboardType: TextInputType.emailAddress,
              validator: (input) => input!.length < 3
                  ? "Search should be more than 3 characters"
                  : null,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                EdgeInsets.only(
                  left : MediaQuery.of(context).size.height * 0.012,

                ),
                filled: true,
                // fillColor: Colors.grey[200],
                fillColor: Color(0xFFF7F5F6).withOpacity(0.9),
                hintText:
                "Search",
                hintStyle: TextStyle(
                    color: Color(0xFFA8A8A8),
                    fontSize: MediaQuery.of(context).size.height * 0.012,
                    fontWeight: FontWeight.w500
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius. all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black45,
                    size: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ),
          ),
        ),


        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is_AI_Selected == false){
                      _toggleButton(_is_AI_Selected, (val) => _is_AI_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_AI_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Adult Allergist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_AI_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_AI_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_AI_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_AI_Selected){
                                          _toggleButton(_is_AI_Selected, (val) => _is_AI_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),


              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Female
                GestureDetector(

                  onTap: () {
                    if(_is_AIP_Selected == false){
                      _toggleButton(_is_AIP_Selected, (val) => _is_AIP_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_AIP_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Allergy and Immunology Practisoner",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_AIP_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_AIP_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_AIP_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_AIP_Selected){
                                          _toggleButton(_is_AIP_Selected, (val) => _is_AIP_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),



              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                

                // Others
                GestureDetector(

                  onTap: () {
                    if(_is_AIS_Selected == false){
                      _toggleButton(_is_AIS_Selected, (val) => _is_AIS_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: _is_AIS_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_AIS_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Allergy and immunology Specialist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_AIS_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_AIS_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_AIS_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_AIS_Selected){
                                          _toggleButton(_is_AIS_Selected, (val) => _is_AIS_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_is_AS_Selected == false){
                      _toggleButton(_is_AS_Selected, (val) => _is_AS_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_AS_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Asthma Specialist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_AS_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_AS_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_AS_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_AS_Selected){
                                          _toggleButton(_is_AS_Selected, (val) => _is_AS_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),


              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 
                // Female
                GestureDetector(

                  onTap: () {
                    if(_is_BD_Selected == false){
                      _toggleButton(_is_BD_Selected, (val) => _is_BD_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_BD_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Bariatric Dietitian",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_BD_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_BD_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_BD_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_BD_Selected){
                                          _toggleButton(_is_BD_Selected, (val) => _is_BD_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

                 

              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 

                // Others
                GestureDetector(

                  onTap: () {
                    if(_is_BMS_Selected == false){
                      _toggleButton(_is_BMS_Selected, (val) => _is_BMS_Selected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: _is_BMS_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_BMS_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Bariatric Medicine Specialist",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_BMS_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_BMS_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_BMS_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_BMS_Selected){
                                          _toggleButton(_is_BMS_Selected, (val) => _is_BMS_Selected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),

              ]
          ),
        ),

      ],
    );
  }
  Widget _genderFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Male Button
                GestureDetector(

                  onTap: () {
                    if(_isMaleSelected == false){
                      _toggleButton(_isMaleSelected, (val) => _isMaleSelected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _isMaleSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Male",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isMaleSelected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_isMaleSelected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_isMaleSelected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_isMaleSelected){
                                          _toggleButton(_isMaleSelected, (val) => _isMaleSelected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Female
                GestureDetector(

                  onTap: () {
                    if(_isFemaleSelected == false){
                      _toggleButton(_isFemaleSelected, (val) => _isFemaleSelected = val);
                    }

                  },

                  child: Container(

                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .max, // Ensure the Row takes up the full available width
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.008,
                            right: MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _isFemaleSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Female",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isFemaleSelected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_isFemaleSelected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_isFemaleSelected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_isFemaleSelected){
                                          _toggleButton(_isFemaleSelected, (val) => _isFemaleSelected = val);
                                        }

                                      },
                                      child: Container(
                                        // color : Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: MediaQuery.of(context).size.height * 0.018,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),



              ]
          ),
        ),



      ],
    );
  }
  Widget _languageFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        GestureDetector(

                          onTap: () {
                            if(_isEnglishSelected == false){
                              _toggleButton(_isEnglishSelected, (val) => _isEnglishSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isEnglishSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "English",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isEnglishSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isEnglishSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isEnglishSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isEnglishSelected){
                                                  _toggleButton(_isEnglishSelected, (val) => _isEnglishSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        GestureDetector(

                          onTap: () {
                            if(_isTamilSelected == false){
                              _toggleButton(_isTamilSelected, (val) => _isTamilSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isTamilSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Tamil",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isTamilSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isTamilSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isTamilSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isTamilSelected){
                                                  _toggleButton(_isTamilSelected, (val) => _isTamilSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        if(
                              !(_isEnglishSelected && _isTamilSelected)


                        )
                        GestureDetector(

                          onTap: () {
                            if(_isKannadaSelected == false){
                              _toggleButton(_isKannadaSelected, (val) => _isKannadaSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: _isKannadaSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isKannadaSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Kannada",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isKannadaSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isKannadaSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isKannadaSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isKannadaSelected){
                                                  _toggleButton(_isKannadaSelected, (val) => _isKannadaSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                      ]
                  ),
                ),



              ]
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [



                        if(
                        (_isEnglishSelected && _isTamilSelected)


                        ) ...[
                          (){
                            _isKannadaSelectedSecondLine = true ;
                              return    GestureDetector(

                                onTap: () {
                                  if(_isKannadaSelected == false){
                                    _toggleButton(_isKannadaSelected, (val) => _isKannadaSelected = val);
                                  }

                                },

                                child: Container(

                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.00,
                                    bottom: MediaQuery.of(context).size.height * 0.01,
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.0,
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .max, // Ensure the Row takes up the full available width
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.008,
                                          right: _isKannadaSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                          top: MediaQuery.of(context).size.height * 0.007,
                                          bottom: MediaQuery.of(context).size.height * 0.007,
                                        ),

                                        margin: EdgeInsets.zero,

                                        decoration: BoxDecoration(
                                          color: _isKannadaSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center, // Center the content
                                              children: <Widget>[
                                                Text(
                                                  "Kannada",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: _isKannadaSelected ? Color(0xFF126086) : Colors.black87,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014,
                                                  ),
                                                ),

                                              ],
                                            ),
                                            if(_isKannadaSelected)
                                              SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                            if(_isKannadaSelected)
                                              Column(

                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      if(_isKannadaSelected){
                                                        _toggleButton(_isKannadaSelected, (val) => _isKannadaSelected = val);
                                                      }

                                                    },
                                                    child: Container(
                                                      // color : Colors.red,
                                                      child: Icon(
                                                        Icons.close,
                                                        size: MediaQuery.of(context).size.height * 0.018,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              );
                          }(),

                        ] else ...[
                          () {
                             _isKannadaSelectedSecondLine = false ;
                             return SizedBox.shrink();
                          }(),
                        ],





                        GestureDetector(

                          onTap: () {
                            if(_isHindiSelected == false){
                              _toggleButton(_isHindiSelected, (val) => _isHindiSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isHindiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Hindi",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isHindiSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isHindiSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isHindiSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isHindiSelected){
                                                  _toggleButton(_isHindiSelected, (val) => _isHindiSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        if(

                           !( _isKannadaSelectedSecondLine & _isKannadaSelected & _isHindiSelected)



                        )
                        GestureDetector(

                          onTap: () {
                            if(_isTeluguSelected == false){
                              _toggleButton(_isTeluguSelected, (val) => _isTeluguSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isTeluguSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Telugu",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isTeluguSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isTeluguSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isTeluguSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isTeluguSelected){
                                                  _toggleButton(_isTeluguSelected, (val) => _isTeluguSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),


                        if(

                             (_isKannadaSelectedSecondLine == false )

                           || (_isKannadaSelectedSecondLine & (_isKannadaSelected == false &&  _isHindiSelected == false &&  _isTeluguSelected == false && _isUrduSelected == false) )


                        )
                        GestureDetector(

                          onTap: () {
                            if(_isUrduSelected == false){
                              _toggleButton(_isUrduSelected, (val) => _isUrduSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: _isUrduSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isUrduSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Urdu",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isUrduSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isUrduSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isUrduSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isUrduSelected){
                                                  _toggleButton(_isUrduSelected, (val) => _isUrduSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                      ]
                  ),
                ),



              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [





                        if(

                        ( _isKannadaSelectedSecondLine & _isKannadaSelected & _isHindiSelected)

                        )  ...[
                          () {
                            _isTeluguSelectedSecondLine = true;
                             return  GestureDetector(

                               onTap: () {
                                 if(_isTeluguSelected == false){
                                   _toggleButton(_isTeluguSelected, (val) => _isTeluguSelected = val);
                                 }

                               },

                               child: Container(

                                 margin: EdgeInsets.only(
                                   top: MediaQuery.of(context).size.height * 0.00,
                                   bottom: MediaQuery.of(context).size.height * 0.01,
                                   left: MediaQuery.of(context).size.height * 0.01,
                                   right: MediaQuery.of(context).size.height * 0.0,
                                 ),
                                 padding: EdgeInsets.zero,
                                 child: Row(
                                   mainAxisSize: MainAxisSize
                                       .max, // Ensure the Row takes up the full available width
                                   children: <Widget>[
                                     Container(
                                       padding: EdgeInsets.only(
                                         left: MediaQuery.of(context).size.height * 0.008,
                                         right: MediaQuery.of(context).size.height * 0.008,
                                         top: MediaQuery.of(context).size.height * 0.007,
                                         bottom: MediaQuery.of(context).size.height * 0.007,
                                       ),

                                       margin: EdgeInsets.zero,

                                       decoration: BoxDecoration(
                                         color: _isTeluguSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                         borderRadius: BorderRadius.circular(5),
                                       ),
                                       child: Row(
                                         children: [
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment
                                                 .center, // Center the content
                                             children: <Widget>[
                                               Text(
                                                 "Telugu",
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                   color: _isTeluguSelected ? Color(0xFF126086) : Colors.black87,
                                                   fontWeight: FontWeight.w400,
                                                   fontSize: MediaQuery.of(context)
                                                       .size
                                                       .height *
                                                       0.014,
                                                 ),
                                               ),

                                             ],
                                           ),
                                           if(_isTeluguSelected)
                                             SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                           if(_isTeluguSelected)
                                             Column(

                                               children: <Widget>[
                                                 GestureDetector(
                                                   onTap: () {
                                                     if(_isTeluguSelected){
                                                       _toggleButton(_isTeluguSelected, (val) => _isTeluguSelected = val);
                                                     }

                                                   },
                                                   child: Container(
                                                     // color : Colors.red,
                                                     child: Icon(
                                                       Icons.close,
                                                       size: MediaQuery.of(context).size.height * 0.018,
                                                       color: Colors.black,
                                                     ),
                                                   ),
                                                 )

                                               ],
                                             ),
                                         ],
                                       ),
                                     ),


                                   ],
                                 ),
                               ),
                             );
                          }(),
                        ]  else ...[
                          () {
                            _isTeluguSelectedSecondLine = true;
                            return SizedBox.shrink();
                          }(),
                        ],


                       if(

                       (_isKannadaSelectedSecondLine && _isKannadaSelected)
                       || (_isKannadaSelectedSecondLine && _isHindiSelected)
                       )


                        GestureDetector(

                          onTap: () {
                            if(_isUrduSelected == false){
                              _toggleButton(_isUrduSelected, (val) => _isUrduSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: _isUrduSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isUrduSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Urdu",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isUrduSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isUrduSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isUrduSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isUrduSelected){
                                                  _toggleButton(_isUrduSelected, (val) => _isUrduSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                      ]
                  ),
                ),



              ]
          ),
        ),





      ],
    );
  }
  Widget _cityFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        GestureDetector(

                          onTap: () {
                            if(_isBangaloreSelected == false){
                              _toggleButton(_isBangaloreSelected, (val) => _isBangaloreSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isBangaloreSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Bangalore",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isBangaloreSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isBangaloreSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isBangaloreSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isBangaloreSelected){
                                                  _toggleButton(_isBangaloreSelected, (val) => _isBangaloreSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        GestureDetector(

                          onTap: () {
                            if(_ishosurSelected == false){
                              _toggleButton(_ishosurSelected, (val) => _ishosurSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _ishosurSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Hosur",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _ishosurSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_ishosurSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_ishosurSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_ishosurSelected){
                                                  _toggleButton(_ishosurSelected, (val) => _ishosurSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        if(
                        !(_isBangaloreSelected && _ishosurSelected)


                        )
                          GestureDetector(

                            onTap: () {
                              if(_isChennaiSelected == false){
                                _toggleButton(_isChennaiSelected, (val) => _isChennaiSelected = val);
                              }

                            },

                            child: Container(

                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.0,
                              ),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .max, // Ensure the Row takes up the full available width
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.008,
                                      right: _isChennaiSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                      top: MediaQuery.of(context).size.height * 0.007,
                                      bottom: MediaQuery.of(context).size.height * 0.007,
                                    ),

                                    margin: EdgeInsets.zero,

                                    decoration: BoxDecoration(
                                      color: _isChennaiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center the content
                                          children: <Widget>[
                                            Text(
                                              "Chennai",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _isChennaiSelected ? Color(0xFF126086) : Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.014,
                                              ),
                                            ),

                                          ],
                                        ),
                                        if(_isChennaiSelected)
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                        if(_isChennaiSelected)
                                          Column(

                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if(_isChennaiSelected){
                                                    _toggleButton(_isChennaiSelected, (val) => _isChennaiSelected = val);
                                                  }

                                                },
                                                child: Container(
                                                  // color : Colors.red,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: MediaQuery.of(context).size.height * 0.018,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),

                      ]
                  ),
                ),



              ]
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [



                        if(
                        (_isBangaloreSelected && _ishosurSelected)


                        ) ...[
                              (){
                            _isChennaiSelectedSecondLine = true ;
                            return    GestureDetector(

                              onTap: () {
                                if(_isChennaiSelected == false){
                                  _toggleButton(_isChennaiSelected, (val) => _isChennaiSelected = val);
                                }

                              },

                              child: Container(

                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                  left: MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height * 0.0,
                                ),
                                padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .max, // Ensure the Row takes up the full available width
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.008,
                                        right: _isChennaiSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                        top: MediaQuery.of(context).size.height * 0.007,
                                        bottom: MediaQuery.of(context).size.height * 0.007,
                                      ),

                                      margin: EdgeInsets.zero,

                                      decoration: BoxDecoration(
                                        color: _isChennaiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // Center the content
                                            children: <Widget>[
                                              Text(
                                                "Chennai",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: _isChennaiSelected ? Color(0xFF126086) : Colors.black87,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014,
                                                ),
                                              ),

                                            ],
                                          ),
                                          if(_isChennaiSelected)
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                          if(_isChennaiSelected)
                                            Column(

                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    if(_isChennaiSelected){
                                                      _toggleButton(_isChennaiSelected, (val) => _isChennaiSelected = val);
                                                    }

                                                  },
                                                  child: Container(
                                                    // color : Colors.red,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: MediaQuery.of(context).size.height * 0.018,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )

                                              ],
                                            ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            );
                          }(),

                        ] else ...[
                              () {
                            _isChennaiSelectedSecondLine = false ;
                            return SizedBox.shrink();
                          }(),
                        ],





                        GestureDetector(

                          onTap: () {
                            if(_isMumbaiSelected == false){
                              _toggleButton(_isMumbaiSelected, (val) => _isMumbaiSelected = val);
                            }

                          },

                          child: Container(

                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .max, // Ensure the Row takes up the full available width
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.008,
                                    right: MediaQuery.of(context).size.height * 0.008,
                                    top: MediaQuery.of(context).size.height * 0.007,
                                    bottom: MediaQuery.of(context).size.height * 0.007,
                                  ),

                                  margin: EdgeInsets.zero,

                                  decoration: BoxDecoration(
                                    color: _isMumbaiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the content
                                        children: <Widget>[
                                          Text(
                                            "Mumbai",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isMumbaiSelected ? Color(0xFF126086) : Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.014,
                                            ),
                                          ),

                                        ],
                                      ),
                                      if(_isMumbaiSelected)
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                      if(_isMumbaiSelected)
                                        Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if(_isMumbaiSelected){
                                                  _toggleButton(_isMumbaiSelected, (val) => _isMumbaiSelected = val);
                                                }

                                              },
                                              child: Container(
                                                // color : Colors.red,
                                                child: Icon(
                                                  Icons.close,
                                                  size: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        if(

                        !( _isChennaiSelectedSecondLine & _isChennaiSelected & _isMumbaiSelected)



                        )
                          GestureDetector(

                            onTap: () {
                              if(_isAgraSelected == false){
                                _toggleButton(_isAgraSelected, (val) => _isAgraSelected = val);
                              }

                            },

                            child: Container(

                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.0,
                              ),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .max, // Ensure the Row takes up the full available width
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.008,
                                      right: MediaQuery.of(context).size.height * 0.008,
                                      top: MediaQuery.of(context).size.height * 0.007,
                                      bottom: MediaQuery.of(context).size.height * 0.007,
                                    ),

                                    margin: EdgeInsets.zero,

                                    decoration: BoxDecoration(
                                      color: _isAgraSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center the content
                                          children: <Widget>[
                                            Text(
                                              "Agra",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _isAgraSelected ? Color(0xFF126086) : Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.014,
                                              ),
                                            ),

                                          ],
                                        ),
                                        if(_isAgraSelected)
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                        if(_isAgraSelected)
                                          Column(

                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if(_isAgraSelected){
                                                    _toggleButton(_isAgraSelected, (val) => _isAgraSelected = val);
                                                  }

                                                },
                                                child: Container(
                                                  // color : Colors.red,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: MediaQuery.of(context).size.height * 0.018,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),


                        if(

                        (_isChennaiSelectedSecondLine == false )

                            || (_isChennaiSelectedSecondLine & (_isChennaiSelected == false &&  _isMumbaiSelected == false &&  _isAgraSelected == false && _isUrduSelected == false) )


                        )
                          GestureDetector(

                            onTap: () {
                              if(_isDelhiSelected == false){
                                _toggleButton(_isDelhiSelected, (val) => _isDelhiSelected = val);
                              }

                            },

                            child: Container(

                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.0,
                              ),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .max, // Ensure the Row takes up the full available width
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.008,
                                      right: _isDelhiSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                      top: MediaQuery.of(context).size.height * 0.007,
                                      bottom: MediaQuery.of(context).size.height * 0.007,
                                    ),

                                    margin: EdgeInsets.zero,

                                    decoration: BoxDecoration(
                                      color: _isDelhiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center the content
                                          children: <Widget>[
                                            Text(
                                              "Delhi",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _isDelhiSelected ? Color(0xFF126086) : Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.014,
                                              ),
                                            ),

                                          ],
                                        ),
                                        if(_isDelhiSelected)
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                        if(_isDelhiSelected)
                                          Column(

                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if(_isDelhiSelected){
                                                    _toggleButton(_isDelhiSelected, (val) => _isDelhiSelected = val);
                                                  }

                                                },
                                                child: Container(
                                                  // color : Colors.red,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: MediaQuery.of(context).size.height * 0.018,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),

                      ]
                  ),
                ),



              ]
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.0,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [





                        if(

                        ( _isChennaiSelectedSecondLine & _isChennaiSelected & _isMumbaiSelected)

                        )  ...[
                              () {
                            _isAgraSelectedSecondLine = true;
                            return  GestureDetector(

                              onTap: () {
                                if(_isAgraSelected == false){
                                  _toggleButton(_isAgraSelected, (val) => _isAgraSelected = val);
                                }

                              },

                              child: Container(

                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                  left: MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height * 0.0,
                                ),
                                padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .max, // Ensure the Row takes up the full available width
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.008,
                                        right: MediaQuery.of(context).size.height * 0.008,
                                        top: MediaQuery.of(context).size.height * 0.007,
                                        bottom: MediaQuery.of(context).size.height * 0.007,
                                      ),

                                      margin: EdgeInsets.zero,

                                      decoration: BoxDecoration(
                                        color: _isAgraSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // Center the content
                                            children: <Widget>[
                                              Text(
                                                "Agra",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: _isAgraSelected ? Color(0xFF126086) : Colors.black87,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014,
                                                ),
                                              ),

                                            ],
                                          ),
                                          if(_isAgraSelected)
                                            SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                          if(_isAgraSelected)
                                            Column(

                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    if(_isAgraSelected){
                                                      _toggleButton(_isAgraSelected, (val) => _isAgraSelected = val);
                                                    }

                                                  },
                                                  child: Container(
                                                    // color : Colors.red,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: MediaQuery.of(context).size.height * 0.018,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )

                                              ],
                                            ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            );
                          }(),
                        ]  else ...[
                              () {
                            _isAgraSelectedSecondLine = true;
                            return SizedBox.shrink();
                          }(),
                        ],


                        if(

                        (_isChennaiSelectedSecondLine && _isChennaiSelected)
                            || (_isChennaiSelectedSecondLine && _isMumbaiSelected)
                        )


                          GestureDetector(

                            onTap: () {
                              if(_isDelhiSelected == false){
                                _toggleButton(_isDelhiSelected, (val) => _isDelhiSelected = val);
                              }

                            },

                            child: Container(

                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.0,
                              ),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .max, // Ensure the Row takes up the full available width
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.008,
                                      right: _isDelhiSelected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                                      top: MediaQuery.of(context).size.height * 0.007,
                                      bottom: MediaQuery.of(context).size.height * 0.007,
                                    ),

                                    margin: EdgeInsets.zero,

                                    decoration: BoxDecoration(
                                      color: _isDelhiSelected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // Center the content
                                          children: <Widget>[
                                            Text(
                                              "Delhi",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: _isDelhiSelected ? Color(0xFF126086) : Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.014,
                                              ),
                                            ),

                                          ],
                                        ),
                                        if(_isDelhiSelected)
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                                        if(_isDelhiSelected)
                                          Column(

                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  if(_isDelhiSelected){
                                                    _toggleButton(_isDelhiSelected, (val) => _isDelhiSelected = val);
                                                  }

                                                },
                                                child: Container(
                                                  // color : Colors.red,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: MediaQuery.of(context).size.height * 0.018,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),

                      ]
                  ),
                ),



              ]
          ),
        ),





      ],
    );
  }

}