import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {

  final Function(DateTime selectedDate, String dayLabel)? onDateSelected;
  const Calendar({
    Key? key,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.01,),
        Center(
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

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
          child: RepaintBoundary(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rowHeight: screenHeight * 0.04,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
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
                  return _dateCell(context, date, screenHeight,
                      isSelected: true);
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
                disabledBuilder: (context, date, _) {
                  return _dateCell(context, date, screenHeight,
                      dimmed: true, disabled: true);
                },
              ),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // onDaySelected: (selectedDay, focusedDay) {
              //   setState(() {
              //     _selectedDay = selectedDay;
              //     _focusedDay = focusedDay;
              //   });
              //
              //   if (widget.onDateSelected != null) {
              //     widget.onDateSelected!(selectedDay);
              //   }
              // },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                if (widget.onDateSelected != null) {
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final tomorrow = today.add(const Duration(days: 1));
                  final selected = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

                  String formattedDay;
                  if (selected == today) {
                    formattedDay = "Today";
                  } else if (selected == tomorrow) {
                    formattedDay = "Tomorrow";
                  } else {
                    formattedDay = DateFormat.EEEE().format(selectedDay); // e.g., Monday
                  }

                  widget.onDateSelected!(selectedDay, formattedDay); // <-- Pass both
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
              enabledDayPredicate: (day) {
                return day
                    .isAfter(DateTime.now().subtract(const Duration(days: 1)));
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

  Widget _buildHeader(BuildContext context, DateTime date, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(


              icon: Icon(Icons.keyboard_double_arrow_left,
                  size: MediaQuery.of(context).size.height * 0.02),
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime(
                      _focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
                });
              },
            ),
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
          ],
        ),

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
            IconButton(
              icon: Icon(Icons.keyboard_double_arrow_right,
                  size: height * 0.02),
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime(
                      _focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
                });
              },
            ),
          ],
        )

      ],
    );
  }


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
      textColor = textColor.withOpacity(0.25);
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
