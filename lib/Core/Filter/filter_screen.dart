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
        required double left_right_size,
      }) {
    return showModalBottomSheet<Map<String, List<String>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false, // User manual drag down disable karne ke liye
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

  Map<String, String> searchQueries = {};

  @override
  void initState() {
    super.initState();
    categories = widget.initialCategories.map((c) {
      return FilterCategory(
          key: c.key,
          title: c.title,
          options: c.options,
          initialSelectedOptions: List.from(c.selectedOptions),
          hasSearchBar: c.hasSearchBar);
    }).toList();

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
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        // Sirf UI update trigger karenge, AnimatedContainer baki kaam khud kar lega
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

    List<String> filteredList = currentCategory.options
        .where((opt) => opt.toLowerCase().contains(currentQuery.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (currentCategory.hasSearchBar)
          _buildSearchBar(currentCategory.key, context),
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
        textInputAction: TextInputAction.done, // Keyboard me 'Done' button dikhane ke liye
        onEditingComplete: () {
          // 'Done' par click karne par keyboard hide ho jayega
          FocusScope.of(context).unfocus();
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
        ],
        style: const TextStyle(color: Colors.black45),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.012),
          filled: true,
          fillColor: const Color(0xFFF7F5F6).withOpacity(0.9),
          hintText: "Search",
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
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
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
                  color: selected ? const Color(0x1A116A94) : const Color(0x80EEEEEE),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      opt,
                      style: TextStyle(
                        color: selected ? const Color(0xFF126086) : Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (selected) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.close, size: 18)
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
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // Normal base height 55%
    double innerHeight = screenHeight * widget.initialChildSize;

    // Agar text field focus me hai ya keyboard open hai, to screen ko stretch karein (max 90% minus keyboard height)
    if (_searchFocusNode.hasFocus || keyboardHeight > 0) {
      double expandedHeight = (screenHeight * 0.9) - keyboardHeight;
      // Ensure karein ki height kabhi normal base height se kam na ho
      if (expandedHeight > innerHeight) {
        innerHeight = expandedHeight;
      }
    }

    return GestureDetector(
      // Bahar kahin bhi click karne par keyboard close ho jayega
      onTap: () => FocusScope.of(context).unfocus(),
      // Padding ko bahar rakha hai, taaki container squeeze na ho
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: innerHeight, // Dynamically adjusted height
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              // Handle Indicator
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.015, bottom: 8),
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
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "Add Filters",
                          style: TextStyle(
                            color: const Color(0xFF2F3335),
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height * 0.016,
                          ),
                        ),
                        if (selectedCount > 0)
                          Text(
                            ' ($selectedCount)',
                            style: TextStyle(
                              color: const Color(0xFF2F3335),
                              fontWeight: FontWeight.w600,
                              fontSize: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus(); // Close keyboard on Clear All
                        clearAll();
                      },
                      child: Text(
                        "Clear all",
                        style: TextStyle(
                          color: const Color(0xFF126086),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.height * 0.012,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Left & Right Panels
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Side
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF95C8D6).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.020,
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus(); // MUST DO THIS to avoid overflow
                                setState(() {
                                  _searchController.clear();
                                  searchQueries[categories[selectedCategoryIndex].key] = '';
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
                                        left: MediaQuery.of(context).size.height * 0.02,
                                        bottom: MediaQuery.of(context).size.height * 0.01,
                                        top: MediaQuery.of(context).size.height * 0.01,
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

                    // Right Side
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: _getFilterOptionsWidget(context),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.015),

              // Apply Filters Button
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.03,
                  right: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: selectedCount > 0 ? () {
                    final Map<String, List<String>> result = {};
                    for (var category in categories) {
                      if (category.selectedOptions.isNotEmpty) {
                        result[category.key] = category.selectedOptions;
                      }
                    }
                    Navigator.pop(context, result);
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF126086),
                    minimumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.045),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.012),
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
  }
}

