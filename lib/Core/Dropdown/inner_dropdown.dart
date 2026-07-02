import 'package:flutter/material.dart';

class InnnerDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final double? size;
  final String hint;
  final bool enabled;

  const InnnerDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.size = 11,
    this.hint = '--Select--',
    this.enabled = true,
  });

  // 🔥 Yeh function click hone par screen par menu show karega
  // void _showCustomMenu(BuildContext context) async {
  //   // 1. Button ka current size aur position get karna
  //   final RenderBox button = context.findRenderObject() as RenderBox;
  //   final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

  //   // 2. Menu kahan khulega uski position set karna (Button ke theek neeche)
  //   final RelativeRect position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
  //       button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
  //     ),
  //     Offset.zero & overlay.size,
  //   );

  //   // 3. Menu show karna
  //   final selectedValue = await showMenu<String>(
  //     context: context,
  //     position: position,
  //     color: Colors.white,
  //     elevation: 0,
  //     // 🔥 Yahan par hum width fixed kar rahe hain (Button ke size ke barabar)
  //     constraints: BoxConstraints(
  //       minWidth: button.size.width,
  //       maxWidth: button.size.width,
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
  //       // ✅ Menu ka border bhi TextField ke jaisa halka (F1F1F1) kar diya
  //       side: const BorderSide(color: Color(0xFFF1F1F1), width: 1),
  //     ),
  //     items: items.map((item) {
  //       return PopupMenuItem<String>(
  //         value: item,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.005),
  //           child: Text(
  //             item,
  //             style: TextStyle(
  //               color: Colors.black87,
  //               fontSize: MediaQuery.of(context).size.height * 0.014,
  //               fontWeight: FontWeight.w400, // ✅ Dropdown list ke items ka weight
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );

  //   // 4. Agar user ne kuch select kiya h, to usko update karna
  //   if (selectedValue != null) {
  //     onChanged(selectedValue);
  //   }
  // }

  void _showCustomMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final buttonTop = button.localToGlobal(Offset.zero, ancestor: overlay).dy;
    final buttonBottom = button
        .localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay)
        .dy;

    const double estimatedMenuHeight = 220;

    final double spaceBelow = overlay.size.height - buttonBottom;
    final bool openAbove = spaceBelow < estimatedMenuHeight;

    late RelativeRect position;

    if (openAbove) {
      position = RelativeRect.fromLTRB(
        button.localToGlobal(Offset.zero, ancestor: overlay).dx,
        buttonTop - estimatedMenuHeight,
        overlay.size.width -
            button
                .localToGlobal(button.size.topRight(Offset.zero),
                    ancestor: overlay)
                .dx,
        overlay.size.height - buttonTop,
      );
    } else {
      position = RelativeRect.fromLTRB(
        button
            .localToGlobal(button.size.bottomLeft(Offset.zero),
                ancestor: overlay)
            .dx,
        buttonBottom,
        overlay.size.width -
            button
                .localToGlobal(button.size.bottomRight(Offset.zero),
                    ancestor: overlay)
                .dx,
        overlay.size.height - buttonBottom,
      );
    }

    final selectedValue = await showMenu<String>(
      context: context,
      position: position,
      constraints: BoxConstraints(
        minWidth: button.size.width,
        maxWidth: button.size.width,
        maxHeight: estimatedMenuHeight,
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );

    if (selectedValue != null) {
      onChanged(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Check kar rahe hain ki hint dikhana hai ya selected value
    bool isHint = value == null || value!.isEmpty || value == hint;

    // 🔥 GestureDetector ka use karke hum pure container ko clickable bana rahe hain
    return GestureDetector(
      onTap: () {
        if (enabled) _showCustomMenu(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size!,
        ),
        width: double
            .infinity, // Ye space le lega apne parent (Expanded) ke hisaab se
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          // ✅ Container ka border color TextField wala (F1F1F1)
          border: Border.all(color: const Color(0xFFF1F1F1), width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.018),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isHint ? hint : value!,
                  style: TextStyle(
                    // ✅ Agar disabled hai toh grey, Hint hai toh 0x4D000000, Selected hai toh black87
                    color: !enabled
                        ? Colors.grey.shade500
                        : isHint
                            ? const Color(0x4D000000) // TextField Hint Color
                            : Colors.black87, // TextField Text Color
                    fontSize: isHint
                        ? MediaQuery.of(context).size.height * 0.014
                        : MediaQuery.of(context).size.height * 0.016,
                    // ✅ Hint ke liye w400, Value ke liye w500 (TextField jaisa)
                    fontWeight: isHint ? FontWeight.w400 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 20,
                // ✅ Dropdown arrow ko bhi hint color jaisa rakha hai taaki clean lage
                color: enabled ? const Color(0x4D000000) : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
