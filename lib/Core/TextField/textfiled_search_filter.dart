import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomTextField extends StatelessWidget {
  // Controllers & Data
  final TextEditingController controller;
  final String? hintText;

  // Callbacks
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onCalendarTap;

  // Visibility Conditions
  final bool showSearchIcon;
  final bool showFilterIcon;
  final bool showCalendar;

  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLength;
  final Widget? label ;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = "Search by Patient Name / UHID",
    this.onChanged,
    this.onSearchTap,
    this.onFilterTap,
    this.onCalendarTap,
    this.showSearchIcon = true,
    this.showFilterIcon = true,
    this.showCalendar = true,
    this.focusNode,
    this.inputFormatters,
    this.maxLength = 50,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5F6), // Main background color here
              borderRadius: BorderRadius.circular(12), // FIXED: Changed to BorderRadius
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      inputFormatters: inputFormatters ?? [LengthLimitingTextInputFormatter(maxLength)],
                      onChanged: onChanged,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.015,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: label,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          top: 12,
                          bottom: 12,
                        ),

                        // FIXED: Removed filled: true and fillColor completely.
                        // Now it will take the background color of the parent Container.

                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: height * 0.014,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),

                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onSearchTap, // Updated to use callback
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black45,
                            size: height * 0.025,
                          ),
                        ),
                      ),
                      if(showFilterIcon)
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: 1,
                          height: 24,
                          color: Colors.grey,
                        ),
                      if(showFilterIcon)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,

                          onTap: onFilterTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/scansearch.png',
                              height: 18,
                              width: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),



      ],
    );
  }
}