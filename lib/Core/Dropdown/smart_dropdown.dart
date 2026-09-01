import 'package:flutter/material.dart';

class SmartAdaptiveDropdown extends StatefulWidget {

  final List<String> items;
  final String hint;
  final Function(String) onChanged;
  final String? initialValue;

  const SmartAdaptiveDropdown({

    Key? key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _SmartAdaptiveDropdownState createState() => _SmartAdaptiveDropdownState();
}

class _SmartAdaptiveDropdownState extends State<SmartAdaptiveDropdown> {
  // Ye dono widgets ko aapas me link karne ka kaam aayega
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // ✅ 3. Init state me initial value set karein taki edit me value show ho
    _selectedValue = widget.initialValue;
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double spaceBelow = screenHeight - keyboardHeight - (offset.dy + size.height);

    bool showAbove = spaceBelow < 200;

    _overlayEntry = _createOverlayEntry(size, showAbove);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry(Size size, bool showAbove) {
    return OverlayEntry(
      builder: (context) => SafeArea(
        child: ClipRect(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeDropdown,
            child: Stack(
              children: [
                Positioned(
                  width: size.width,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
          
                    // YAHAN EXACT OVERLAP WALA LOGIC LAGA HAI
                    targetAnchor: showAbove ? Alignment.bottomCenter : Alignment.topCenter,
                    followerAnchor: showAbove ? Alignment.bottomCenter : Alignment.topCenter,
                    offset: Offset.zero, // Koi gap nahi
          
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        // constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFF1F1F1)),
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.items.map((item) {
                            return InkWell(
                              onTap: () {
                                setState(() => _selectedValue = item);
                                widget.onChanged(item);
                                _closeDropdown();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Color(0xFF171717),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Target widget jiske sath dropdown chipkega
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.018,
              vertical: 11,
          ),
          width: double.infinity,
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
                  _selectedValue ?? widget.hint,
                  style: TextStyle(
                    color: _selectedValue == null ? const Color(0x4D000000) : Colors.black87,
                    fontSize: _selectedValue == null
                        ? MediaQuery.of(context).size.height * 0.014
                        : MediaQuery.of(context).size.height * 0.016,
                    fontWeight: _selectedValue == null ? FontWeight.w400 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: const Color(0x4D000000),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}