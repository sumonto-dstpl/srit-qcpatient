// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
//
// class CustomTypeCalendar extends StatefulWidget {
//   final Function(DateTime selectedDate)? onDateSelected;
//
//   const CustomTypeCalendar({
//     Key? key,
//     this.onDateSelected,
//   }) : super(key: key);
//
//   @override
//   State<CustomTypeCalendar> createState() => _CustomTypeCalendarState();
// }
//
// class _CustomTypeCalendarState extends State<CustomTypeCalendar> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             left: screenHeight * 0.02,
//             top: screenHeight * 0.015,
//           ),
//           child: Text(
//             "Select Your Date",
//             style: TextStyle(
//               fontSize: screenHeight * 0.014,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
//           child: RepaintBoundary(
//             child: TableCalendar(
//               firstDay: DateTime.utc(1900, 1, 1), // allow past dates
//               lastDay: DateTime.utc(2100, 12, 31), // allow future dates
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               rowHeight: screenHeight * 0.04,
//               availableCalendarFormats: const {
//                 CalendarFormat.month: 'Month',
//               },
//               headerStyle: const HeaderStyle(
//                 formatButtonVisible: false,
//                 titleCentered: false,
//                 headerPadding: EdgeInsets.symmetric(vertical: 0.0),
//                 leftChevronVisible: false,
//                 rightChevronVisible: false,
//               ),
//               calendarBuilders: CalendarBuilders(
//                 defaultBuilder: (context, date, _) {
//                   return _dateCell(context, date, screenHeight,
//                       isSelected: false, isToday: false);
//                 },
//                 selectedBuilder: (context, date, _) {
//                   return _dateCell(context, date, screenHeight, isSelected: true);
//                 },
//                 todayBuilder: (context, date, _) {
//                   return _dateCell(context, date, screenHeight, isToday: true);
//                 },
//                 headerTitleBuilder: (context, date) {
//                   return _buildHeader(context, date, screenHeight);
//                 },
//                 outsideBuilder: (context, date, _) {
//                   return _dateCell(context, date, screenHeight, dimmed: true);
//                 },
//                 disabledBuilder: (context, date, _) {
//                   return _dateCell(context, date, screenHeight,
//                       dimmed: true, disabled: true);
//                 },
//               ),
//               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//               onDaySelected: (selectedDay, focusedDay) {
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay;
//                 });
//
//                 if (widget.onDateSelected != null) {
//                   widget.onDateSelected!(selectedDay);
//                 }
//               },
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//
//               // NOTE: No enabledDayPredicate -> all dates selectable (past + future)
//               daysOfWeekStyle: DaysOfWeekStyle(
//                 dowTextFormatter: (date, locale) =>
//                     DateFormat.E(locale).format(date).substring(0, 1),
//                 weekdayStyle: TextStyle(
//                   fontSize: screenHeight * 0.012,
//                   color: const Color(0xFF8F95B2),
//                   fontWeight: FontWeight.w500,
//                 ),
//                 weekendStyle: TextStyle(
//                   fontSize: screenHeight * 0.012,
//                   color: const Color(0xFF8F95B2),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Header builder (month + year with chevrons)
//   Widget _buildHeader(BuildContext context, DateTime date, double height) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: height * 0.02),
//           child: Text(
//             "${DateFormat.MMMM().format(date)} ${date.year}",
//             style: TextStyle(
//               fontSize: height * 0.014,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//         Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.chevron_left, size: height * 0.02),
//               onPressed: () {
//                 setState(() {
//                   _focusedDay = DateTime(
//                     _focusedDay.year,
//                     _focusedDay.month - 1,
//                     _focusedDay.day,
//                   );
//                 });
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.chevron_right, size: height * 0.02),
//               onPressed: () {
//                 setState(() {
//                   _focusedDay = DateTime(
//                     _focusedDay.year,
//                     _focusedDay.month + 1,
//                     _focusedDay.day,
//                   );
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Single date cell rendering
//   Widget _dateCell(
//       BuildContext context,
//       DateTime date,
//       double height, {
//         bool isSelected = false,
//         bool isToday = false,
//         bool dimmed = false,
//         bool disabled = false,
//       }) {
//     Color textColor = const Color(0xFF126086);
//     Color backgroundColor = Colors.transparent;
//
//     if (disabled) {
//       textColor = textColor.withOpacity(0.25);
//     } else if (dimmed) {
//       textColor = textColor.withOpacity(0.45);
//     } else if (isSelected) {
//       textColor = Colors.white;
//       backgroundColor = const Color(0xFF116A94);
//     } else if (isToday) {
//       textColor = const Color(0xFF116A94);
//       backgroundColor = const Color(0x33116A94);
//     }
//
//     return Container(
//       margin: const EdgeInsets.all(3.0),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         shape: BoxShape.circle,
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         '${date.day}',
//         style: TextStyle(
//           fontSize: height * 0.014,
//           fontWeight: FontWeight.w400,
//           color: textColor,
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomTypeCalendar extends StatefulWidget {
  final Function(DateTime selectedDate)? onDateSelected;
  final DateTime? minDate; // 1. Add this optional parameter

  const CustomTypeCalendar({
    Key? key,
    this.onDateSelected,
    this.minDate, // Initialize it
  }) : super(key: key);

  @override
  State<CustomTypeCalendar> createState() => _CustomTypeCalendarState();
}

class _CustomTypeCalendarState extends State<CustomTypeCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenHeight * 0.02,
            top: screenHeight * 0.015,
          ),
          child: Text(
            "Select Your Date",
            style: TextStyle(
              fontSize: screenHeight * 0.014,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
          child: RepaintBoundary(
            child: TableCalendar(
              firstDay: DateTime.utc(1900, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rowHeight: screenHeight * 0.04,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },

              // 2. Logic to disable specific days based on minDate
              enabledDayPredicate: (day) {
                if (widget.minDate != null) {
                  // If minDate is set, disable days before it
                  // We normalize dates to ignore time parts for accurate comparison
                  DateTime normalizedDay = DateTime(day.year, day.month, day.day);
                  DateTime normalizedMin = DateTime(widget.minDate!.year, widget.minDate!.month, widget.minDate!.day);

                  return !normalizedDay.isBefore(normalizedMin);
                }
                return true; // If no minDate, all days are enabled (default behavior)
              },

              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: false,
                headerPadding: EdgeInsets.symmetric(vertical: 0.0),
                leftChevronVisible: false,
                rightChevronVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight,
                      isSelected: false, isToday: false);
                },
                selectedBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight, isSelected: true);
                },
                todayBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight, isToday: true);
                },
                headerTitleBuilder: (context, date) {
                  return _buildHeader(context, date, screenHeight);
                },
                outsideBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight, dimmed: true);
                },
                // 3. Customize the look of disabled days (greyed out)
                disabledBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight,
                      dimmed: true, disabled: true);
                },
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                // 4. Double check to prevent selection of disabled days
                if (widget.minDate != null) {
                  DateTime normalizedSelected = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                  DateTime normalizedMin = DateTime(widget.minDate!.year, widget.minDate!.month, widget.minDate!.day);
                  if (normalizedSelected.isBefore(normalizedMin)) return;
                }

                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(selectedDay);
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) =>
                    DateFormat.E(locale).format(date).substring(0, 1),
                weekdayStyle: TextStyle(
                  fontSize: screenHeight * 0.012,
                  color: const Color(0xFF8F95B2),
                  fontWeight: FontWeight.w500,
                ),
                weekendStyle: TextStyle(
                  fontSize: screenHeight * 0.012,
                  color: const Color(0xFF8F95B2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Header builder (month + year with chevrons)
  Widget _buildHeader(BuildContext context, DateTime date, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: height * 0.02),
          child: Text(
            "${DateFormat.MMMM().format(date)} ${date.year}",
            style: TextStyle(
              fontSize: height * 0.014,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, size: height * 0.02),
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    _focusedDay.month - 1,
                    _focusedDay.day,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, size: height * 0.02),
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    _focusedDay.month + 1,
                    _focusedDay.day,
                  );
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  // Single date cell rendering
  Widget _dateCell(
      BuildContext context,
      DateTime date,
      double height, {
        bool isSelected = false,
        bool isToday = false,
        bool dimmed = false,
        bool disabled = false,
      }) {
    Color textColor = const Color(0xFF126086);
    Color backgroundColor = Colors.transparent;

    if (disabled) {
      textColor = textColor.withOpacity(0.25); // Visibly greyed out
    } else if (dimmed) {
      textColor = textColor.withOpacity(0.45);
    } else if (isSelected) {
      textColor = Colors.white;
      backgroundColor = const Color(0xFF116A94);
    } else if (isToday) {
      textColor = const Color(0xFF116A94);
      backgroundColor = const Color(0x33116A94);
    }

    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '${date.day}',
        style: TextStyle(
          fontSize: height * 0.014,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }
}