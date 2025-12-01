import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddFilterForFullBodyCheckup extends StatefulWidget {
  @override
  AddFilterForFullBodyCheckupState createState() => AddFilterForFullBodyCheckupState();
}

class AddFilterForFullBodyCheckupState extends State<AddFilterForFullBodyCheckup> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  DraggableScrollableController  _scrollController = DraggableScrollableController();



  TextEditingController SearchfilterEditTextController1 = TextEditingController();
  TextEditingController SearchfilterEditTextController2 = TextEditingController();

  @override
  void initState() {
    super.initState();


    // Listen for focus changes (keyboard open)
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        // Expand sheet when textfield gets focus
        Future.delayed(const Duration(milliseconds: 150), () {
          _sheetController.animateTo(
            0.95, // expand to top
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        });
      }
    });

    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        // Expand sheet when textfield gets focus
        Future.delayed(const Duration(milliseconds: 150), () {
          _sheetController.animateTo(
            0.95, // expand to top
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        });
      }
    });

    _filteredTests = List.from(_allTests);
    SearchfilterEditTextController1.addListener(_applyFilter);

    _filteredCategories = List.from(_allCategories);
    SearchfilterEditTextController2.addListener(_filterCategories);
  }

  void _applyFilter() {
    String query = SearchfilterEditTextController1.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredTests = List.from(_allTests);
      } else {
        _filteredTests = _allTests
            .where((test) => test.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _filterCategories() {
    String query = SearchfilterEditTextController2.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredCategories = List.from(_allCategories);
      } else {
        _filteredCategories = _allCategories
            .where((test) => test.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {

    _focusNode1.dispose();
    _focusNode2.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // List of filter categories
  final List<String> categories = [
    'Must have tests',
    'Category',
  ];

  int selectedCategoryIndex = 0;

  int selectedCount = 0;



  bool _is_CBC_Selected = false;
  bool _is_GPP_Selected = false;
  bool _is_CUX_Selected = false;
  bool _is_TP_Selected = false;
  bool _is_LP_Selected = false;
  bool _is_LFT_Selected = false;
  bool _is_CRP_Selected = false;

  bool _is_Pregnancy_Selected = false;
  bool _is_XRAY_Selected = false;
  bool _is_BS_Selected = false;
  bool _is_Allergy_Selected = false;
  bool _is_TS_Selected = false;
  bool _is_Bone_Selected = false;
  bool _is_MH_Selected = false;


  void clearAll(){
    setState(() {
      selectedCount = 0;
        _is_CBC_Selected = false;
        _is_GPP_Selected = false;
        _is_CUX_Selected = false;
        _is_TP_Selected = false;
        _is_LP_Selected = false;
        _is_LFT_Selected = false;
        _is_CRP_Selected = false;

        _is_Pregnancy_Selected = false;
        _is_XRAY_Selected = false;
        _is_BS_Selected = false;
        _is_Allergy_Selected = false;
        _is_TS_Selected = false;
        _is_Bone_Selected = false;
        _is_MH_Selected = false;


    });
  }

  void _toggleButton(bool currentState, Function(bool) setStateCallback) {
    setState(() {
      final newState = !currentState;
      setStateCallback(newState);
      selectedCount += newState ? 1 : -1;
    });
  }

  List<String> _allTests = [
    "Complete Blood Count",
    "Glucose,Post Prandial(PP),2 Hours",
    "Complete Urine Examination",
    "Thyroid Profile(Total T3,Total T4)",
    "Lipid Profile",
    "Liver Function Text(I-FT)",
    "C-Reactive Protein(Quantitative)",
  ];

  List<String> _filteredTests = [];

  List<String> _allCategories = [
    "Pregnancy",
    "X - ray MRI CT Ultrasound",
    "Blood Studies",
    "Allergy",
    "Tax Saver",
    "Bone",
    "Men's Health",
  ];

  List<String> _filteredCategories = [];


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
                        Navigator.pop(context);
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
                                        Navigator.pop(context);
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

  /*
  'Must have tests',
    'Category',
   */

  Widget _getFilterWidget(String category, BuildContext context) {
    switch (category) {
      case 'Must have tests':
        return   _must_have_testsFilterWidget(context);
      case 'Category':
        return _categoryFilterWidget(context);

      default:
        return Container();
    }
  }

  Widget _must_have_testsFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        GestureDetector(
          onTap: () {
            _focusNode1.requestFocus(); // Show keyboard
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
              focusNode: _focusNode1, // Attach the focus node
              readOnly: false, // Important: set to false so it can accept input

              controller: SearchfilterEditTextController1,
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
                if (_filteredTests.contains("Complete Blood Count"))
                GestureDetector(

                  onTap: () {
                    if(_is_CBC_Selected == false){
                      _toggleButton(_is_CBC_Selected, (val) => _is_CBC_Selected = val);
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
                            color: _is_CBC_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Complete Blood Count",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_CBC_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_CBC_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_CBC_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_CBC_Selected){
                                          _toggleButton(_is_CBC_Selected, (val) => _is_CBC_Selected = val);
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
                if (_filteredTests.contains("Glucose,Post Prandial(PP),2 Hours"))
                GestureDetector(

                  onTap: () {
                    if(_is_GPP_Selected == false){
                      _toggleButton(_is_GPP_Selected, (val) => _is_GPP_Selected = val);
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
                            color: _is_GPP_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Glucose,Post Prandial(PP),2 Hours",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_GPP_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_GPP_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_GPP_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_GPP_Selected){
                                          _toggleButton(_is_GPP_Selected, (val) => _is_GPP_Selected = val);
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
                if (_filteredTests.contains("Complete Urine Examination"))
                GestureDetector(

                  onTap: () {
                    if(_is_CUX_Selected == false){
                      _toggleButton(_is_CUX_Selected, (val) => _is_CUX_Selected = val);
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
                            right: _is_CUX_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_CUX_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Complete Urine Examination",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_CUX_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_CUX_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_CUX_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_CUX_Selected){
                                          _toggleButton(_is_CUX_Selected, (val) => _is_CUX_Selected = val);
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
                if (_filteredTests.contains("Thyroid Profile(Total T3,Total T4)"))
                GestureDetector(

                  onTap: () {
                    if(_is_TP_Selected == false){
                      _toggleButton(_is_TP_Selected, (val) => _is_TP_Selected = val);
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
                            color: _is_TP_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Thyroid Profile(Total T3,Total T4)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_TP_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_TP_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_TP_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_TP_Selected){
                                          _toggleButton(_is_TP_Selected, (val) => _is_TP_Selected = val);
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
                if (_filteredTests.contains("Lipid Profile"))
                GestureDetector(

                  onTap: () {
                    if(_is_LP_Selected == false){
                      _toggleButton(_is_LP_Selected, (val) => _is_LP_Selected = val);
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
                            color: _is_LP_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Lipid Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_LP_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_LP_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_LP_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_LP_Selected){
                                          _toggleButton(_is_LP_Selected, (val) => _is_LP_Selected = val);
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
                if (_filteredTests.contains("Liver Function Text(I-FT)"))
                GestureDetector(

                  onTap: () {
                    if(_is_LFT_Selected == false){
                      _toggleButton(_is_LFT_Selected, (val) => _is_LFT_Selected = val);
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
                            right: _is_LFT_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_LFT_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Liver Function Text(I-FT)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_LFT_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_LFT_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_LFT_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_LFT_Selected){
                                          _toggleButton(_is_LFT_Selected, (val) => _is_LFT_Selected = val);
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
                if (_filteredTests.contains("C-Reactive Protein(Quantitative)"))
                GestureDetector(

                  onTap: () {
                    if(_is_CRP_Selected == false){
                      _toggleButton(_is_CRP_Selected, (val) => _is_CRP_Selected = val);
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
                            right: _is_CRP_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_CRP_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "C-Reactive Protein(Quantitative)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_CRP_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_CRP_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_CRP_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_CRP_Selected){
                                          _toggleButton(_is_CRP_Selected, (val) => _is_CRP_Selected = val);
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
  Widget _categoryFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        GestureDetector(
          onTap: () {
            _focusNode2.requestFocus(); // Show keyboard
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
              focusNode: _focusNode2, // Attach the focus node
              readOnly: false, // Important: set to false so it can accept input

              controller: SearchfilterEditTextController2,
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
                if (_filteredCategories.contains("Pregnancy"))
                GestureDetector(

                  onTap: () {
                    if(_is_Pregnancy_Selected == false){
                      _toggleButton(_is_Pregnancy_Selected, (val) => _is_Pregnancy_Selected = val);
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
                            color: _is_Pregnancy_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Pregnancy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Pregnancy_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Pregnancy_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Pregnancy_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Pregnancy_Selected){
                                          _toggleButton(_is_Pregnancy_Selected, (val) => _is_Pregnancy_Selected = val);
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
                if (_filteredCategories.contains("X - ray MRI CT Ultrasound"))
                GestureDetector(

                  onTap: () {
                    if(_is_XRAY_Selected == false){
                      _toggleButton(_is_XRAY_Selected, (val) => _is_XRAY_Selected = val);
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
                            color: _is_XRAY_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "X - ray MRI CT Ultrasound",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_XRAY_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_XRAY_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_XRAY_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_XRAY_Selected){
                                          _toggleButton(_is_XRAY_Selected, (val) => _is_XRAY_Selected = val);
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

                if (_filteredCategories.contains("Blood Studies"))
                GestureDetector(

                  onTap: () {
                    if(_is_BS_Selected == false){
                      _toggleButton(_is_BS_Selected, (val) => _is_BS_Selected = val);
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
                            right: _is_BS_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_BS_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Blood Studies",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_BS_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.013,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_BS_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_BS_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_BS_Selected){
                                          _toggleButton(_is_BS_Selected, (val) => _is_BS_Selected = val);
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
                if (_filteredCategories.contains("Allergy"))
                GestureDetector(

                  onTap: () {
                    if(_is_Allergy_Selected == false){
                      _toggleButton(_is_Allergy_Selected, (val) => _is_Allergy_Selected = val);
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
                            color: _is_Allergy_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Allergy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Allergy_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Allergy_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Allergy_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Allergy_Selected){
                                          _toggleButton(_is_Allergy_Selected, (val) => _is_Allergy_Selected = val);
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
                if (_filteredCategories.contains("Tax Saver"))
                GestureDetector(

                  onTap: () {
                    if(_is_TS_Selected == false){
                      _toggleButton(_is_TS_Selected, (val) => _is_TS_Selected = val);
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
                            color: _is_TS_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Tax Saver",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_TS_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_TS_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_TS_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_TS_Selected){
                                          _toggleButton(_is_TS_Selected, (val) => _is_TS_Selected = val);
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
                if (_filteredCategories.contains("Bone"))
                GestureDetector(

                  onTap: () {
                    if(_is_Bone_Selected == false){
                      _toggleButton(_is_Bone_Selected, (val) => _is_Bone_Selected = val);
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
                            right: _is_Bone_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_Bone_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Bone",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Bone_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Bone_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Bone_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Bone_Selected){
                                          _toggleButton(_is_Bone_Selected, (val) => _is_Bone_Selected = val);
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
                if (_filteredCategories.contains("Men's Health"))
                GestureDetector(

                  onTap: () {
                    if(_is_MH_Selected == false){
                      _toggleButton(_is_MH_Selected, (val) => _is_MH_Selected = val);
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
                            right: _is_MH_Selected ?  MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.008,
                            top: MediaQuery.of(context).size.height * 0.007,
                            bottom: MediaQuery.of(context).size.height * 0.007,
                          ),

                          margin: EdgeInsets.zero,

                          decoration: BoxDecoration(
                            color: _is_MH_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Men's Health",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_MH_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_MH_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_MH_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_MH_Selected){
                                          _toggleButton(_is_MH_Selected, (val) => _is_MH_Selected = val);
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


}