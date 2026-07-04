import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Core/Date%20Time%20Picker/calendar.dart';
// Note: Ensure CustomCalendar is imported here if it's in a different file

class CustomDateTimePicker extends StatefulWidget {
  final String mode;
  final Function(DateTime selectedDate, String selectedTime) onDateTimeSelected;
  final Map<String, List<String>> globallyBookedSlots;
  final Map<String, List<String>> homecareBookedSlots;

  // 🌟 NAYE VARIABLES: Appointment & Reschedule ke liye
  final Map<String, List<String>> appointmentBookedSlots;
  final DateTime? initialDate;
  final String? initialTime;

  const CustomDateTimePicker({
    Key? key,
    required this.onDateTimeSelected,
    this.globallyBookedSlots = const {},
    this.mode = '',
    this.homecareBookedSlots = const {},
    this.appointmentBookedSlots = const {}, // Empty by default
    this.initialDate,
    this.initialTime,
  }) : super(key: key);

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  late DateTime _selectedDate;
  late DateTime _listStartDate;
  String _selectedCategory = 'Morning';
  String? _selectedTime;

  @override
  void initState() {
    super.initState();

    // 🌟 Date wahi select rahegi jo user ne pehle ki thi (initialDate)
    _selectedDate = widget.initialDate ?? DateTime.now();

    // 🌟 YAHAN CHANGE KAREIN: List hamesha 'Aaj' (Today) se hi shuru hogi
    _listStartDate = DateTime.now();

    if (widget.initialTime != null) {
      _selectedTime = widget.initialTime;
      _setCategoryBasedOnTime(widget.initialTime!);
    }
  }

  // Time ke hisaab se correct tab (Morning/Afternoon/Evening) set karne ka logic
  void _setCategoryBasedOnTime(String time) {
    if (time.contains('AM')) {
      _selectedCategory = 'Morning';
    } else {
      try {
        int hour = int.parse(time.split(':')[0]);
        if (hour == 12 || (hour >= 1 && hour <= 5)) {
          _selectedCategory = 'Afternoon';
        } else {
          _selectedCategory = 'Evening';
        }
      } catch (e) {
        _selectedCategory = 'Evening';
      }
    }
  }

  List<DateTime> _generateDates() {
    int daysInMonth = DateTime(_listStartDate.year, _listStartDate.month + 1, 0).day;
    int remainingDays = daysInMonth - _listStartDate.day + 1;
    return List.generate(remainingDays, (index) => _listStartDate.add(Duration(days: index)));
  }

  void _openCalendarBottomSheet() async {
    var result = await showModalBottomSheet<Map<String, dynamic>>(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        backgroundColor: Colors.white,
        barrierColor: Colors.grey.withOpacity(0.9),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4, minChildSize: 0.3, maxChildSize: 0.9, expand: false,
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

    if (result != null) {
      setState(() {
        _listStartDate = result['date'];
        _selectedDate = result['date'];
        _selectedTime = null;
      });
    }
  }

  final Map<String, List<String>> _timeSlots = {
    'Morning': ["06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM", "08:00 AM", "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM"],
    'Afternoon': ["12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM", "02:30 PM", "03:00 PM"],
    'Evening': ["07:30 PM", "08:00 PM", "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"],
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

    // 🌟 MODE KE HISAAB SE DATA SELECT KAREIN
    List<String> bookedSlotsForSelectedDate = widget.globallyBookedSlots[formattedSelectedDate] ?? [];

    if (widget.mode == 'homecare') {
      bookedSlotsForSelectedDate = widget.homecareBookedSlots[formattedSelectedDate] ?? [];
    } else  {
      bookedSlotsForSelectedDate = widget.appointmentBookedSlots[formattedSelectedDate] ?? [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. DATE PICKER UI (Header)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pick Date", style: TextStyle(color: Color(0xFF13668E), fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height * 0.014)),
              GestureDetector(
                onTap: _openCalendarBottomSheet,
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  color: Colors.transparent,
                  child: Text(
                    DateFormat('MMMM yyyy').format(_listStartDate),
                    style: TextStyle(color: Color(0xFF13668E), fontWeight: FontWeight.w500, decoration: TextDecoration.underline, decorationColor: Color(0xFF13668E), fontSize: MediaQuery.of(context).size.height * 0.014),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Date ListView
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
                    width: 60, margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: isSelected ? [const Color(0xFF126086), const Color(0xFF00C9BD)] : [Colors.grey.shade100, Colors.grey.shade100]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('MMM').format(date), style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade600, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(DateFormat('dd').format(date), style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade600, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),

        // 2. TIME CATEGORY TABS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: timeCategories.map((category) {
              String title = category['title'];
              bool isSelected = _selectedCategory == title;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedCategory = title),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: isSelected ? const Color(0xFF13668E) : Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${category['image']}", height: 18, width: 18), const SizedBox(width: 6),
                        Text(title, style: TextStyle(fontSize: 13, color: isSelected ? Colors.white : Colors.grey.shade600, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
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
            padding: EdgeInsets.zero, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.2),
            itemCount: _timeSlots[_selectedCategory]!.length,
            itemBuilder: (context, index) {
              String slot = _timeSlots[_selectedCategory]![index];
              DateTime parsedTime;
              try { parsedTime = DateFormat("hh:mm a").parse(slot); } catch (e) { parsedTime = DateTime.now(); }
              final slotTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, parsedTime.hour, parsedTime.minute);

              final isPast = DateUtils.isSameDay(_selectedDate, DateTime.now()) && slotTime.isBefore(DateTime.now());
              final isBooked = bookedSlotsForSelectedDate.contains(slot);
              final isDisabled = isPast || isBooked;
              final isSelected = _selectedTime == slot;

              Color bgColor = isDisabled ? Color(0x1A999999) : (isSelected ? Color(0xFF00C9BD) : Color(0x0D13668E));
              Color txtColor = isDisabled ? Color(0x99333333) : (isSelected ? Colors.white : Color(0xFF13668E));
              BoxBorder? border = (!isDisabled && !isSelected) ? Border.all(color: Color(0x4D13668E)) : null;

              return IgnorePointer(
                ignoring: isDisabled,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedTime = slot);
                    widget.onDateTimeSelected(_selectedDate, slot);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8), border: border),
                    alignment: Alignment.center,
                    child: Text(slot, style: TextStyle(color: txtColor, fontWeight: FontWeight.w600, fontSize: 10)),
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