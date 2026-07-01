import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Core/Date%20Time%20Picker/calendar.dart';
import 'package:newfolder/utils/custom_calendar.dart';

// Note: Ensure CustomCalendar is imported here if it's in a different file
// import 'path_to_your_custom_calendar.dart';

class CustomDateTimePicker extends StatefulWidget {
  final Function(DateTime selectedDate, String selectedTime) onDateTimeSelected;
  final Map<String, List<String>> globallyBookedSlots;

  const CustomDateTimePicker({
    Key? key,
    required this.onDateTimeSelected,
    this.globallyBookedSlots = const {},
  }) : super(key: key);

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime _selectedDate = DateTime.now();
  DateTime _listStartDate = DateTime.now(); // 🌟 NAYA VARIABLE: List kahan se start hogi
  String _selectedCategory = 'Morning';
  String? _selectedTime;


  // 🌟 UPDATE: Ab dates sirf usi mahine ke end tak generate hongi
  List<DateTime> _generateDates() {
    int daysInMonth = DateTime(_listStartDate.year, _listStartDate.month + 1, 0).day;
    int remainingDays = daysInMonth - _listStartDate.day + 1; // +1 isliye taaki selected date bhi include ho
    return List.generate(remainingDays, (index) => _listStartDate.add(Duration(days: index)));
  }

  // 🌟 NAYA FUNCTION: Aapka Bottom Sheet yahan se khulega
  void _openCalendarBottomSheet() async {
    var result = await showModalBottomSheet<Map<String, dynamic>>(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.white,
        barrierColor: Colors.grey.withOpacity(0.9),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Calendar(
                onDateSelected: (DateTime date, String label) {
                  Navigator.pop(context, {'date': date, 'label': label});
                },
              );
            },
          );
        }
    );

    // Agar user ne date select ki hai
    if (result != null) {
      DateTime pickedDate = result['date'];

      setState(() {
        _listStartDate = pickedDate; // List ab is nayi date se start hogi
        _selectedDate = pickedDate;  // Ye date automatically select ho jayegi
        _selectedTime = null;        // Nayi date aane par time reset kar do
      });
    }
  }

  final Map<String, List<String>> _timeSlots = {
    'Morning': [
      "06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM",
      "08:00 AM", "08:30 AM", "09:00 AM", "09:30 AM",
      "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM"
    ],
    'Afternoon': [
      "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM",
      "02:00 PM", "02:30 PM", "03:00 PM"
    ],
    'Evening': [
      "07:30 PM", "08:00 PM", "08:30 PM", "09:00 PM",
      "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"
    ],
  };

  final List<Map<String, dynamic>> timeCategories = [
    {'title': 'Morning', 'image': 'assets/morning.png'},
    {'title': 'Afternoon', 'image': 'assets/afternoon.png'},
    {'title': 'Evening', 'image': 'assets/evening.png'},
  ];

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = _generateDates();
    String formattedSelectedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
    List<String> bookedSlotsForSelectedDate = widget.globallyBookedSlots[formattedSelectedDate] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. DATE PICKER UI (Horizontal List)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Pick Date",
                  style: TextStyle(
                      color: Color(0xFF13668E),
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height * 0.014)
              ),

              // 🌟 YAHAN GESTURE DETECTOR ADD KIYA HAI 🌟
              GestureDetector(
                onTap: _openCalendarBottomSheet, // Click par bottom sheet khulega
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  color: Colors.transparent, // Red ki jagah transparent kar diya better UI ke liye (aap red bhi rakh sakte ho)
                  child: Text(
                    // Yahan hum _listStartDate dikhayenge taaki month list ke hisaab se dikhe
                    DateFormat('MMMM yyyy').format(_listStartDate),
                    style: TextStyle(
                        color: Color(0xFF13668E),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF13668E),
                        fontSize: MediaQuery.of(context).size.height * 0.014),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 16),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                DateTime date = dates[index];
                bool isSelected = DateUtils.isSameDay(_selectedDate, date);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                      _selectedTime = null;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: isSelected
                            ? [const Color(0xFF126086), const Color(0xFF00C9BD)]
                            : [Colors.grey.shade100, Colors.grey.shade100],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('MMM').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
        SizedBox(height: 20),

        // 2. TIME CATEGORY TABS (Morning / Afternoon / Evening)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: timeCategories.map((category) {
              String title = category['title'];
              bool isSelected = _selectedCategory == title;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = title;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF13668E) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "${category['image']}",
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),

        // 3. TIME SLOTS GRID
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            itemCount: _timeSlots[_selectedCategory]!.length,
            itemBuilder: (context, index) {
              String slot = _timeSlots[_selectedCategory]![index];

              DateTime parsedTime;
              try {
                parsedTime = DateFormat("hh:mm a").parse(slot);
              } catch (e) {
                parsedTime = DateTime.now();
              }

              final slotTime = DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day,
                parsedTime.hour, parsedTime.minute,
              );

              final isPast = DateUtils.isSameDay(_selectedDate, DateTime.now()) && slotTime.isBefore(DateTime.now());
              final isBooked = bookedSlotsForSelectedDate.contains(slot);
              final isDisabled = isPast || isBooked;
              final isSelected = _selectedTime == slot;

              Color bgColor;
              Color txtColor;
              BoxBorder? border;

              if (isDisabled) {
                bgColor = Color(0x1A999999);
                txtColor = Color(0x99333333);
              } else if (isSelected) {
                bgColor = Color(0xFF00C9BD);
                txtColor = Colors.white;
              } else {
                bgColor = Color(0x0D13668E);
                txtColor = Color(0xFF13668E);
                border = Border.all(color: Color(0x4D13668E));
              }

              return IgnorePointer(
                ignoring: isDisabled,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = slot;
                    });
                    widget.onDateTimeSelected(_selectedDate, slot);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: border,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      slot,
                      style: TextStyle(
                        color: txtColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}