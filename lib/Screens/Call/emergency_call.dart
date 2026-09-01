import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';


class GlobalDraggableEmergencyButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const GlobalDraggableEmergencyButton({super.key, this.onPressed});

  @override
  State<GlobalDraggableEmergencyButton> createState() => _GlobalDraggableEmergencyButtonState();
}

class _GlobalDraggableEmergencyButtonState extends State<GlobalDraggableEmergencyButton> {
  Offset position = Offset.zero;
  bool isInitialized = false;
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Jab widget pehli baar load ho, toh iski initial position Bottom-Right set karein
    if (!isInitialized) {
      final size = MediaQuery.of(context).size;
      position = Offset(size.width - 80, size.height - 150);
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final systemBottomPadding = MediaQuery.of(context).padding.bottom;
    final buttonSize = height * 0.06;
    final safePadding = 15.0;

    // 🔴 YAHAN CHANGE KIYA HAI: Aapke custom nav bar ki height image mein zyada lag rahi hai, isliye ise 120 kar diya hai.
    // Agar phir thoda niche jaye toh aap ise 130 ya 140 bhi karke dekh sakte hain.
    final bottomNavHeight = 130.0;

    // ✅ Screen limit clamping
    position = Offset(
      position.dx.clamp(
        safePadding,
        width - buttonSize - safePadding,
      ),
      position.dy.clamp(
        MediaQuery.of(context).padding.top + safePadding,
        height - buttonSize - safePadding - bottomNavHeight - systemBottomPadding,
      ),
    );

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            Offset newPosition = position + details.delta;

            // 👉 Drag karte waqt nayi limits
            double clampedX = newPosition.dx.clamp(
              safePadding,
              width - buttonSize - safePadding,
            );

            double clampedY = newPosition.dy.clamp(
              MediaQuery.of(context).padding.top + safePadding,
              // Ye logic ensures karega ki button nav bar ke niche na ghuse
              height - buttonSize - safePadding - bottomNavHeight - systemBottomPadding,
            );

            position = Offset(clampedX, clampedY);
          });
        },
        onTap: () {
          emergencycallalert.showticket(context);
        },
        child: Container(
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC80000),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ]
          ),
          child: Center(
            child: Image.asset(
              'assets/Emergency Call Button.png',
              fit: BoxFit.cover,
              height: height * 0.04,
              width: height * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}