import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FilterForImsurance extends StatefulWidget {
  @override
  AddFilterForFindDoctorListState createState() => AddFilterForFindDoctorListState();
}

class AddFilterForFindDoctorListState extends State<FilterForImsurance> {
  final FocusNode _focusNode = FocusNode();

  DraggableScrollableController  _scrollController = DraggableScrollableController();



  @override
  void dispose() {

    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // List of filter categories
  final List<String> categories = [
    'Category',
  ];

  int selectedCategoryIndex = 0;

  int selectedCount = 0;
  

  bool _is_All_Selected = false;
  bool _is_Approval_Selected = false;
  bool _is_Rejected_Selected = false;
  bool _is_Approved_Selected = false;

  void clearAll(){
    setState(() {
      selectedCount = 0;
        _is_All_Selected = false;
        _is_Approval_Selected = false;
        _is_Rejected_Selected = false;
        _is_Approved_Selected = false;

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
                        if(selectedCount != 0) {
                          List<String> selectedStatuses = [];

                          if (_is_All_Selected) {
                            selectedStatuses = ['approved', 'pending', 'rejected'];
                          } else {
                            if (_is_Approved_Selected) selectedStatuses.add('approved');
                            if (_is_Approval_Selected) selectedStatuses.add('pending');
                            if (_is_Rejected_Selected) selectedStatuses.add('rejected');
                          }

                          Navigator.pop(context, selectedStatuses); // return selected statuses
                        }
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

                                      color: selectedCount == 0 ?  Color(0x99909090) : Color(0xFF126086),

                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    child: TextButton(
                                      onPressed: () async {
                                        if(selectedCount != 0) {
                                          List<String> selectedStatuses = [];

                                          if (_is_All_Selected) {
                                            selectedStatuses = ['approved', 'pending', 'rejected'];
                                          } else {
                                            if (_is_Approved_Selected) selectedStatuses.add('approved');
                                            if (_is_Approval_Selected) selectedStatuses.add('pending');
                                            if (_is_Rejected_Selected) selectedStatuses.add('rejected');
                                          }

                                          Navigator.pop(context, selectedStatuses); // return selected statuses
                                        }


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
      case 'Category':
        return   _categoryFilterWidget(context);


      default:
        return Container();
    }
  }

  Widget _categoryFilterWidget(BuildContext context) {
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

                GestureDetector(

                  onTap: () {
                    if(_is_All_Selected == false){
                      _toggleButton(_is_All_Selected, (val) => _is_All_Selected = val);
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
                            color: _is_All_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "All",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_All_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_All_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_All_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_All_Selected){
                                          _toggleButton(_is_All_Selected, (val) => _is_All_Selected = val);
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
                    if(_is_Approval_Selected == false){
                      _toggleButton(_is_Approval_Selected, (val) => _is_Approval_Selected = val);
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
                            color: _is_Approval_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Send of Approval",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Approval_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Approval_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Approval_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Approval_Selected){
                                          _toggleButton(_is_Approval_Selected, (val) => _is_Approval_Selected = val);
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

                GestureDetector(

                  onTap: () {
                    if(_is_Rejected_Selected == false){
                      _toggleButton(_is_Rejected_Selected, (val) => _is_Rejected_Selected = val);
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
                            color: _is_Rejected_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Rejected",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Rejected_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Rejected_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Rejected_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Rejected_Selected){
                                          _toggleButton(_is_Rejected_Selected, (val) => _is_Rejected_Selected = val);
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
                    if(_is_Approved_Selected == false){
                      _toggleButton(_is_Approved_Selected, (val) => _is_Approved_Selected = val);
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
                            color: _is_Approved_Selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the content
                                children: <Widget>[
                                  Text(
                                    "Approved",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _is_Approved_Selected ? Color(0xFF126086) : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),

                                ],
                              ),
                              if(_is_Approved_Selected)
                                SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                              if(_is_Approved_Selected)
                                Column(

                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if(_is_Approved_Selected){
                                          _toggleButton(_is_Approved_Selected, (val) => _is_Approved_Selected = val);
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