import 'package:flutter/material.dart';

class TimeSlotSelector extends StatefulWidget {
  final List<String> timeSlots;
  final int defaultSelectedIndex;
  final ValueChanged<String> onSelected;
  final DateTime selectedDate;

  const TimeSlotSelector({
    super.key,
    required this.timeSlots,
    required this.onSelected,
    required this.selectedDate,
    this.defaultSelectedIndex = -1,
  });

  @override
  State<TimeSlotSelector> createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(widget.selectedDate, now);

    return GridView.builder(
      shrinkWrap: true, // ✅ allows height to match content
      physics: NeverScrollableScrollPhysics(), // ✅ disables inner scroll
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2,
      ),
      itemCount: widget.timeSlots.length,
      itemBuilder: (context, index) {
        final slot = widget.timeSlots[index];
        final parts = slot.split(":");
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        final slotTime = DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month,
          widget.selectedDate.day,
          hour + 12,
          minute,
        );

        final isPast = isToday && slotTime.isBefore(now);
        final isSelected = selectedIndex == index;

        Color backgroundColor;
        Color textColor;
        BoxBorder? border;

        if (isPast) {
          backgroundColor = Colors.grey.shade300;
          textColor = Colors.grey;
          border = null;
        } else if (isSelected) {
          backgroundColor = const Color(0xFF00C9BD);
          textColor = Colors.white;
          border = null;
        } else {
          backgroundColor = const Color(0xFF13668E).withOpacity(0.1);
          textColor = const Color(0xFF126086);
          border = Border.all(color: const Color(0x4D13668E), width: 0.4);
        }

        return IgnorePointer(
          ignoring: isPast,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelected(slot);
            },
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: border,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.012,
                    ),
                  ),
                  Text(
                    "PM",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.012,
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
