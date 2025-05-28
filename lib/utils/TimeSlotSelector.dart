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

  // @override
  // Widget build(BuildContext context) {
  //   final now = DateTime.now();
  //   final isToday = DateUtils.isSameDay(widget.selectedDate, now);
  //
  //   return Container(
  //     padding: EdgeInsets.zero,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: List.generate(widget.timeSlots.length, (index) {
  //         final parts = widget.timeSlots[index].split(":");
  //         final hour = int.parse(parts[0]);
  //         final minute = int.parse(parts[1]);
  //         //      final slotTime = DateTime(now.year, now.month, now.day, hour + 12, minute); // PM times
  //         final slotTime = DateTime(
  //           widget.selectedDate.year,
  //           widget.selectedDate.month,
  //           widget.selectedDate.day,
  //           hour + 12,
  //           minute,
  //         );
  //         final isPast = isToday && slotTime.isBefore(now);
  //         final isSelected = selectedIndex == index;
  //
  //         Color backgroundColor;
  //         Color textColor;
  //         BoxBorder? border;
  //
  //         if (isPast) {
  //           backgroundColor = Colors.grey.shade300;
  //           textColor = Colors.grey;
  //           border = null;
  //         } else if (isSelected) {
  //           backgroundColor = const Color(0xFF126086);
  //           textColor = Colors.white;
  //           border = null;
  //         } else {
  //           backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
  //           textColor = const Color(0xFF126086);
  //           border = Border.all(color: const Color(0xFF126086), width: 1.0);
  //         }
  //
  //         return IgnorePointer(
  //           ignoring: isPast,
  //           child: GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 selectedIndex = index;
  //               });
  //               widget.onSelected(widget.timeSlots[index]);
  //             },
  //             child: Container(
  //               height: MediaQuery.of(context).size.height * 0.045,
  //               width: MediaQuery.of(context).size.width * 0.17,
  //               decoration: BoxDecoration(
  //                 color: backgroundColor,
  //                 borderRadius: BorderRadius.circular(10),
  //                 border: border,
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     widget.timeSlots[index],
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: MediaQuery.of(context).size.height * 0.012,
  //                     ),
  //                   ),
  //                   Text(
  //                     "PM",
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: MediaQuery.of(context).size.height * 0.012,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }

  // --- Horizontal Scrolling
  // @override
  // Widget build(BuildContext context) {
  //   final now = DateTime.now();
  //   final isToday = DateUtils.isSameDay(widget.selectedDate, now);
  //
  //   // Chunk the list into pages of 4 slots each
  //   List<List<String>> pages = [];
  //   for (var i = 0; i < widget.timeSlots.length; i += 4) {
  //     pages.add(widget.timeSlots.sublist(
  //       i,
  //       (i + 4) > widget.timeSlots.length ? widget.timeSlots.length : i + 4,
  //     ));
  //   }
  //
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.06, // height for one row
  //     child: PageView.builder(
  //       itemCount: pages.length,
  //       controller: PageController(viewportFraction: 1),
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, pageIndex) {
  //         final pageSlots = pages[pageIndex];
  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: List.generate(pageSlots.length, (index) {
  //             final slotIndex = pageIndex * 4 + index;
  //             final slot = pageSlots[index];
  //
  //             final parts = slot.split(":");
  //             final hour = int.parse(parts[0]);
  //             final minute = int.parse(parts[1]);
  //
  //             final slotTime = DateTime(
  //               widget.selectedDate.year,
  //               widget.selectedDate.month,
  //               widget.selectedDate.day,
  //               hour + 12,
  //               minute,
  //             );
  //
  //             final isPast = isToday && slotTime.isBefore(now);
  //             final isSelected = selectedIndex == slotIndex;
  //
  //             Color backgroundColor;
  //             Color textColor;
  //             BoxBorder? border;
  //
  //             if (isPast) {
  //               backgroundColor = Colors.grey.shade300;
  //               textColor = Colors.grey;
  //               border = null;
  //             } else if (isSelected) {
  //               backgroundColor = const Color(0xFF126086);
  //               textColor = Colors.white;
  //               border = null;
  //             } else {
  //               backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
  //               textColor = const Color(0xFF126086);
  //               border = Border.all(color: const Color(0xFF126086), width: 1.0);
  //             }
  //
  //             return IgnorePointer(
  //               ignoring: isPast,
  //               child: GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     selectedIndex = slotIndex;
  //                   });
  //                   widget.onSelected(slot);
  //                 },
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width *
  //                       0.2, // about 1/5 width
  //                   height: MediaQuery.of(context).size.height * 0.05,
  //                   decoration: BoxDecoration(
  //                     color: backgroundColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     border: border,
  //                   ),
  //                   alignment: Alignment.center,
  //                   margin: const EdgeInsets.symmetric(horizontal: 4),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         slot,
  //                         style: TextStyle(
  //                           color: textColor,
  //                           fontWeight: FontWeight.w400,
  //                           fontSize:
  //                               MediaQuery.of(context).size.height * 0.014,
  //                         ),
  //                       ),
  //                       Text(
  //                         "PM",
  //                         style: TextStyle(
  //                           color: textColor,
  //                           fontWeight: FontWeight.w400,
  //                           fontSize:
  //                               MediaQuery.of(context).size.height * 0.012,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }),
  //         );
  //       },
  //     ),
  //   );
  // }

  // --- Vertical Scrolling

  // @override
  // Widget build(BuildContext context) {
  //   final now = DateTime.now();
  //   final isToday = DateUtils.isSameDay(widget.selectedDate, now);
  //
  //   // Chunk the list into pages of 4 slots each (each page = one row)
  //   List<List<String>> pages = [];
  //   for (var i = 0; i < widget.timeSlots.length; i += 4) {
  //     pages.add(widget.timeSlots.sublist(
  //       i,
  //       (i + 4) > widget.timeSlots.length ? widget.timeSlots.length : i + 4,
  //     ));
  //   }
  //
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.07, // height of one row
  //     child: PageView.builder(
  //       itemCount: pages.length,
  //       controller: PageController(viewportFraction: 1),
  //       scrollDirection: Axis.vertical, // << Change here to vertical scroll
  //       itemBuilder: (context, pageIndex) {
  //         final pageSlots = pages[pageIndex];
  //         return Align(
  //           // 👈 keeps the content top-aligned
  //           alignment: Alignment.topCenter,
  //           child: SizedBox(
  //             height: MediaQuery.of(context).size.height * 0.1,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: List.generate(pageSlots.length, (index) {
  //                 final slotIndex = pageIndex * 4 + index;
  //                 final slot = pageSlots[index];
  //
  //                 final parts = slot.split(":");
  //                 final hour = int.parse(parts[0]);
  //                 final minute = int.parse(parts[1]);
  //
  //                 final slotTime = DateTime(
  //                   widget.selectedDate.year,
  //                   widget.selectedDate.month,
  //                   widget.selectedDate.day,
  //                   hour + 12,
  //                   minute,
  //                 );
  //
  //                 final isPast = isToday && slotTime.isBefore(now);
  //                 final isSelected = selectedIndex == slotIndex;
  //
  //                 Color backgroundColor;
  //                 Color textColor;
  //                 BoxBorder? border;
  //
  //                 if (isPast) {
  //                   backgroundColor = Colors.grey.shade300;
  //                   textColor = Colors.grey;
  //                   border = null;
  //                 } else if (isSelected) {
  //                   backgroundColor = const Color(0xFF126086);
  //                   textColor = Colors.white;
  //                   border = null;
  //                 } else {
  //                   backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
  //                   textColor = const Color(0xFF126086);
  //                   border =
  //                       Border.all(color: const Color(0xFF126086), width: 1.0);
  //                 }
  //
  //                 return IgnorePointer(
  //                   ignoring: isPast,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = slotIndex;
  //                       });
  //                       widget.onSelected(slot);
  //                     },
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width *
  //                           0.2, // ~1/5 width
  //                       height: MediaQuery.of(context).size.height * 0.05,
  //                       decoration: BoxDecoration(
  //                         color: backgroundColor,
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: border,
  //                       ),
  //                       alignment: Alignment.center,
  //                       margin: const EdgeInsets.symmetric(horizontal: 4),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             slot,
  //                             style: TextStyle(
  //                               color: textColor,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize:
  //                                   MediaQuery.of(context).size.height * 0.014,
  //                             ),
  //                           ),
  //                           Text(
  //                             "PM",
  //                             style: TextStyle(
  //                               color: textColor,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize:
  //                                   MediaQuery.of(context).size.height * 0.012,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               }),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final now = DateTime.now();
  //   final isToday = DateUtils.isSameDay(widget.selectedDate, now);
  //
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.16, // Show ~2 rows
  //     child: GridView.builder(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 4, // 4 per row
  //         mainAxisSpacing: 8,
  //         crossAxisSpacing: 8,
  //         childAspectRatio: 2,
  //       ),
  //       itemCount: widget.timeSlots.length,
  //       itemBuilder: (context, index) {
  //         final slot = widget.timeSlots[index];
  //         final parts = slot.split(":");
  //         final hour = int.parse(parts[0]);
  //         final minute = int.parse(parts[1]);
  //
  //         final slotTime = DateTime(
  //           widget.selectedDate.year,
  //           widget.selectedDate.month,
  //           widget.selectedDate.day,
  //           hour + 12,
  //           minute,
  //         );
  //
  //         final isPast = isToday && slotTime.isBefore(now);
  //         final isSelected = selectedIndex == index;
  //
  //         Color backgroundColor;
  //         Color textColor;
  //         BoxBorder? border;
  //
  //         if (isPast) {
  //           backgroundColor = Colors.grey.shade300;
  //           textColor = Colors.grey;
  //           border = null;
  //         } else if (isSelected) {
  //           backgroundColor = const Color(0xFF126086);
  //           textColor = Colors.white;
  //           border = null;
  //         } else {
  //           backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
  //           textColor = const Color(0xFF126086);
  //           border = Border.all(color: const Color(0xFF126086), width: 1.0);
  //         }
  //
  //         return IgnorePointer(
  //           ignoring: isPast,
  //           child: GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 selectedIndex = index;
  //               });
  //               widget.onSelected(slot);
  //             },
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: backgroundColor,
  //                 borderRadius: BorderRadius.circular(10),
  //                 border: border,
  //               ),
  //               alignment: Alignment.center,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     slot,
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: MediaQuery.of(context).size.height * 0.012,
  //                     ),
  //                   ),
  //                   Text(
  //                     "PM",
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: MediaQuery.of(context).size.height * 0.012,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: MediaQuery.of(context).size.height * 0.02,
  //     ),
  //     child: GridView.builder(
  //       shrinkWrap: true, // ✅ important: let it size naturally
  //       physics:
  //           NeverScrollableScrollPhysics(), // ✅ disables internal scrolling
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 4,
  //         crossAxisSpacing: 10,
  //         mainAxisSpacing: 10,
  //         childAspectRatio: 2.2,
  //       ),
  //       itemCount: widget.timeSlots.length,
  //       itemBuilder: (context, index) {
  //         final slot = widget.timeSlots[index];
  //         final parts = slot.split(":");
  //         final hour = int.parse(parts[0]);
  //         final minute = int.parse(parts[1]);
  //
  //         final now = DateTime.now();
  //         final isToday = DateUtils.isSameDay(widget.selectedDate, now);
  //         final slotTime = DateTime(
  //           widget.selectedDate.year,
  //           widget.selectedDate.month,
  //           widget.selectedDate.day,
  //           hour + 12,
  //           minute,
  //         );
  //
  //         final isPast = isToday && slotTime.isBefore(now);
  //         final isSelected = selectedIndex == index;
  //
  //         Color backgroundColor;
  //         Color textColor;
  //         BoxBorder? border;
  //
  //         if (isPast) {
  //           backgroundColor = Colors.grey.shade300;
  //           textColor = Colors.grey;
  //           border = null;
  //         } else if (isSelected) {
  //           backgroundColor = const Color(0xFF126086);
  //           textColor = Colors.white;
  //           border = null;
  //         } else {
  //           backgroundColor = const Color(0xFF13668E).withOpacity(0.3);
  //           textColor = const Color(0xFF126086);
  //           border = Border.all(color: const Color(0xFF126086), width: 1.0);
  //         }
  //
  //         return IgnorePointer(
  //           ignoring: isPast,
  //           child: GestureDetector(
  //             onTap: () => widget.onSelected(slot),
  //             child: Container(
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: backgroundColor,
  //                 borderRadius: BorderRadius.circular(10),
  //                 border: border,
  //               ),
  //               child: Text(
  //                 "$slot PM",
  //                 style: TextStyle(
  //                   color: textColor,
  //                   fontSize: MediaQuery.of(context).size.height * 0.014,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
