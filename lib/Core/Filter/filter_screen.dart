// lib/utils/filter/FilterScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/Filter/filter_model.dart';
// import 'package:Core/Filter/filter_model.dart';



class FilterScreen {
  static Future<Map<String, List<String>>?> show(
      BuildContext context, {
        required List<FilterCategory> categories,
        double initialChildSize = 0.55,
        required double left_right_size ,

      }) {
    return showModalBottomSheet<Map<String, List<String>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReusableFilterSheet(
        initialCategories: categories,
        initialChildSize: initialChildSize,
        left_right_size: left_right_size,
      ),
    );
  }
}


class ReusableFilterSheet extends StatefulWidget {
  final List<FilterCategory> initialCategories;
  final double initialChildSize;
  final double left_right_size;

  const ReusableFilterSheet({
    Key? key,
    required this.initialCategories,
    this.initialChildSize = 0.55,
    required this.left_right_size ,
  }) : super(key: key);

  @override
  _ReusableFilterSheetState createState() => _ReusableFilterSheetState();
}

class _ReusableFilterSheetState extends State<ReusableFilterSheet> {

  late List<FilterCategory> categories;

  int selectedCategoryIndex = 0;

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  double _currentChildSize = 0.55;
  bool _isDismissed = false;
  double _lastExtent = 0.55;


  Map<String, String> searchQueries = {};

  @override
  void initState() {
    super.initState();
    // Deep copy of categories to allow local mutation
    categories = widget.initialCategories.map((c) {
      return FilterCategory(
          key: c.key,
          title: c.title,
          options: c.options,
          initialSelectedOptions: List.from(c.selectedOptions),
          hasSearchBar: c.hasSearchBar// Copy selected options
      );
    }).toList();

    _currentChildSize = widget.initialChildSize;
    _lastExtent = widget.initialChildSize;

    // Initialize search queries map
    for (var category in categories) {
      searchQueries[category.key] = '';
    }

    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        // Move up when search field is focused
        _currentChildSize = _searchFocusNode.hasFocus ? 0.9 : widget.initialChildSize;
        if (_searchFocusNode.hasFocus) {
          _sheetController.animateTo(
            0.9,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void clearAll() {
    setState(() {
      for (var category in categories) {
        category.selectedOptions.clear();
        searchQueries[category.key] = '';
      }
      _searchController.clear();
    });
  }

  int get selectedCount {
    return categories.fold<int>(0, (sum, category) => sum + category.selectedOptions.length);
  }


  Widget _getFilterOptionsWidget(BuildContext context) {
    if (categories.isEmpty) return const Center(child: Text("No filters available"));

    FilterCategory currentCategory = categories[selectedCategoryIndex];
    String currentQuery = searchQueries[currentCategory.key] ?? '';

    // Filter the options list
    List<String> filteredList = currentCategory.options
        .where((opt) => opt.toLowerCase().contains(currentQuery.toLowerCase()))
        .toList();
    print("hassearch bar : ${currentCategory.hasSearchBar}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        if (currentCategory.hasSearchBar)
          _buildSearchBar(currentCategory.key, context),

        // Filtered Chips (Options)
        Expanded(
          child: SingleChildScrollView(
            child: _buildChips(filteredList, currentCategory.selectedOptions),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(String categoryKey, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.038,
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.01,
        right: MediaQuery.of(context).size.height * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: TextFormField(
        focusNode: _searchFocusNode,
        controller: _searchController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
          // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')), // Allow all chars for better search
        ],
        style: const TextStyle(color: Colors.black45),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.012),
          filled: true,
          fillColor: const Color(0xFFF7F5F6).withOpacity(0.9),
          hintText: "Search ${categoryKey.toUpperCase()}",
          hintStyle: TextStyle(
              color: const Color(0xFFA8A8A8),
              fontSize: MediaQuery.of(context).size.height * 0.012,
              fontWeight: FontWeight.w500),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black45,
            size: MediaQuery.of(context).size.height * 0.02,
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQueries[categoryKey] = value;
          });
        },
      ),
    );
  }


  Widget _buildChips(List<String> list, List<String> selection) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.01
      ),
      child: Wrap(
          spacing: 8, runSpacing: 8,
          children: list.map((opt) {
            final selected = selection.contains(opt);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selected) {
                    selection.remove(opt);
                  } else {
                    selection.add(opt);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? Color(0x1A116A94) : Color(0x80EEEEEE),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      opt,
                      style: TextStyle(
                        color: selected ? Color(0xFF126086) : Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (selected) ...[
                      SizedBox(width: 6),
                      Icon(Icons.close, size: 18)
                    ]
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _currentChildSize,
      minChildSize: _currentChildSize,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            final currentExtent = notification.extent;

            // Hide keyboard when dragging down
            if (currentExtent < _lastExtent - 0.01) {
              FocusScope.of(context).unfocus();
            }

            // Dismiss the sheet if dragged below threshold
            if (!_isDismissed && currentExtent < 0.28) {
              _isDismissed = true;
              Navigator.of(context).pop();
            }

            _lastExtent = currentExtent;
            return true;
          },
          child: Container(
            // Use a specific shape for the sheet
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  // Handle/Drag Indicator
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: 8),
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: const Color(0x2413678F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Header (Add Filters / Clear all)
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,

                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(

                                child: Text(
                                  "Add Filters",
                                  style: TextStyle(
                                    color: Color(0xFF2F3335),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.016,
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


                  // Left & Right Panels
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side: Categories List
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF95C8D6).withOpacity(0.2),
                            // color : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.020,
                            top: MediaQuery.of(context).size.height * 0.01,

                          ),



                          height: widget.left_right_size,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Clear search bar on category switch
                                    _searchController.clear();
                                    searchQueries[categories[selectedCategoryIndex].key] = ''; // Clear query for previous category
                                    selectedCategoryIndex = index;
                                  });
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Blue Side Indicator Line
                                      if (selectedCategoryIndex == index)
                                        Positioned(
                                          top: 6,
                                          left: 0,
                                          bottom: 6,
                                          child: Container(
                                            width: 3.0,
                                            color: const Color(0xFF126086),
                                          ),
                                        ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                          left : MediaQuery.of(context).size.height * 0.02,

                                          bottom: MediaQuery.of(context).size.height * 0.01,
                                          top : MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        child: Text(
                                          categories[index].title,
                                          style: TextStyle(
                                            color: selectedCategoryIndex == index
                                                ? const Color(0xFF126086)
                                                : Colors.black87,
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
                        flex: 6,
                        child: Container(

                          height: widget.left_right_size,
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                          ),
                          child: _getFilterOptionsWidget(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
                  // Apply Filters Button
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.height * 0.03),
                    child: ElevatedButton(
                      onPressed: selectedCount > 0 ? () {
                        // Prepare the result map
                        final Map<String, List<String>> result = {};
                        for (var category in categories) {
                          if (category.selectedOptions.isNotEmpty) {
                            result[category.key] = category.selectedOptions;
                          }
                        }
                        Navigator.pop(context, result);
                      } : null, // Disable if no filters are selected
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF126086),
                        minimumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.045),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.012),
                        ),
                        disabledBackgroundColor: const Color(0x99909090),
                      ),
                      child: Text(
                        "Apply Filters",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

