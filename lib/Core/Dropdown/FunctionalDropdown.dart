import 'package:flutter/material.dart';



import 'package:flutter/material.dart';

class FunctionalDropdown extends StatefulWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool enabled; // 1. Naya parameter add kiya

  const FunctionalDropdown({
    super.key,
    required this.value,
     this.hint = '--Select--',
    required this.items,
    required this.onChanged,
    this.enabled = true, // By default enable rahega
  });

  @override
  State<FunctionalDropdown> createState() => _FunctionalDropdownState();
}

class _FunctionalDropdownState extends State<FunctionalDropdown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 Top Field (Clickable)
        if (!isExpanded)
          GestureDetector(
            // 2. Agar enabled true hai tabhi click kaam karega, warna null (click disable)
            onTap: widget.enabled
                ? () {
              setState(() {
                isExpanded = !isExpanded;
              });
            }
                : null,
            child: Container(
              padding: const EdgeInsets.only(
                  left :  16,
                  top: 10,
                  bottom: 10,
                  right : 12,
              ),
              // decoration: BoxDecoration(
              //   // 3. Agar disable hai to background grey hoga, warna white
              //   color: widget.enabled ? Colors.white : Colors.grey.shade100,
              //   borderRadius: BorderRadius.vertical(
              //     top: const Radius.circular(8),
              //     bottom: Radius.circular(isExpanded ? 0 : 8),
              //   ),
              //   border: Border.all(color: Colors.grey.shade300, width: 1),
              // ),

              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),

                border: Border.all(color: const Color(0xFFF1F1F1), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.value ?? widget.hint,
                      style: TextStyle(
                        color: widget.value == null ? const Color(0x4D000000) : Colors.black87,
                        fontSize: widget.value == null
                            ? MediaQuery.of(context).size.height * 0.014
                            : MediaQuery.of(context).size.height * 0.016,
                        fontWeight: widget.value == null ? FontWeight.w400 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    // Disable hone par icon bhi thoda light ho jayega
                    color: widget.enabled ? Colors.grey : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),

        // 🔹 Expanded Items (Inline)
        if (isExpanded && widget.enabled) // Safety check: Dropdown tabhi dikhega jab isExpanded aur enabled dono true hon
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Column(
              children: widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return InkWell(
                  onTap: () {
                    widget.onChanged(item);
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 12,
                      top: index == 0 ? 0 : 14,
                      bottom: index == widget.items.length - 1 ? 0 : 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14,),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // 👇 Only first item gets arrow
                        if (index == 0)
                          const Icon(
                            Icons.arrow_drop_up_sharp,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}