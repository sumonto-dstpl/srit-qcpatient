import 'package:flutter/material.dart';


// class TimeSlotSelector extends StatefulWidget {
//
//
//   final List<String> timeSlots; // <-- Accept times via constructor
//   final int defaultSelectedIndex;
//
//   const TimeSlotSelector({
//     Key? key,
//     required this.timeSlots,
//     this.defaultSelectedIndex = 0,
//   })  : super(key: key);
//   @override
//   _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
//
// }
//
// class _TimeSlotSelectorState extends State<TimeSlotSelector> {
//   // int? selectedIndex;
//
//   late int selectedIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.defaultSelectedIndex;
//   }
//
//   // final List<String> timeSlots = ["06:00", "06:30", "07:00", "07:30"];
//
//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now().toLocal(); // ensure it's local time
//     print("Now: ${now.hour}:${now.minute}");
//
//     return Container(
//       padding: EdgeInsets.zero,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(widget.timeSlots.length, (index) {
//           final parts = widget.timeSlots[index].split(":");
//           final hour = int.parse(parts[0]);
//           final minute = int.parse(parts[1]);
//
//           final slotTime = DateTime(now.year, now.month, now.day, hour + 12, minute);
//           final isPast = slotTime.isBefore(now);
//
//           print("Slot ${widget.timeSlots[index]} PM => ${slotTime.hour}:${slotTime.minute} | Past? $isPast");
//
//           final isSelected = selectedIndex == index;
//
//           // Style
//           Color backgroundColor;
//           Color textColor;
//           BoxBorder? border;
//
//           if (isPast) {
//             backgroundColor = Colors.grey.shade300;
//             textColor = Colors.grey;
//             border = null;
//           } else if (isSelected) {
//             backgroundColor = Color(0xFF126086);
//             textColor = Colors.white;
//             border = null;
//           } else {
//             backgroundColor = Color(0xFF13668E).withOpacity(0.3);
//             textColor = Color(0xFF126086);
//             border = Border.all(color: Color(0xFF126086), width: 1.0);
//           }
//
//           return IgnorePointer(
//             ignoring: isPast,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.045,
//                 width: MediaQuery.of(context).size.width * 0.17,
//                 decoration: BoxDecoration(
//                   color: backgroundColor,
//                   borderRadius: BorderRadius.circular(10),
//                   border: border,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       widget.timeSlots[index],
//                       style: TextStyle(
//                         color: textColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: MediaQuery.of(context).size.height * 0.012,
//                       ),
//                     ),
//                     Text(
//                       "PM",
//                       style: TextStyle(
//                         color: textColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: MediaQuery.of(context).size.height * 0.012,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class TimeSlotSelector extends StatefulWidget {
  final List<String> timeSlots;
  final int defaultSelectedIndex;
  final ValueChanged<String> onSelected;

  const TimeSlotSelector({
    super.key,
    required this.timeSlots,
    required this.onSelected,
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

    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.timeSlots.length, (index) {
          final parts = widget.timeSlots[index].split(":");
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          final slotTime = DateTime(now.year, now.month, now.day, hour + 12, minute); // PM times
          final isPast = slotTime.isBefore(now);
          final isSelected = selectedIndex == index;

          Color backgroundColor;
          Color textColor;
          BoxBorder? border;

          if (isPast) {
            backgroundColor = Colors.grey.shade300;
            textColor = Colors.grey;
            border = null;
          } else if (isSelected) {
            backgroundColor = const Color(0xFF126086);
            textColor = Colors.white;
            border = null;
          } else {
            backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
            textColor = const Color(0xFF126086);
            border = Border.all(color: const Color(0xFF126086), width: 1.0);
          }

          return IgnorePointer(
            ignoring: isPast,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onSelected(widget.timeSlots[index]);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.17,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: border,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.timeSlots[index],
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
        }),
      ),
    );
  }
}
