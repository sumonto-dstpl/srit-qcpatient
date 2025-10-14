import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

enum NotificationType { success, error }

/// Function to show top notification
// void showTopNotification(
//     BuildContext context, {
//       required String title,
//       required String message,
//       required NotificationType type,
//       Duration duration = const Duration(seconds: 3),
//     }) {
//   final overlay = Overlay.of(context);
//   late OverlayEntry entry;
//
//   entry = OverlayEntry(
//     builder: (context) {
//       Color bgColor =
//       type == NotificationType.success ? Color(0xFF0000FF) : Color(0xFFC40000);
//       IconData icon = type == NotificationType.success ? Icons.check : Icons.close;
//
//       return _TopNotificationWidget(
//         title: title,
//         message: message,
//         icon: icon,
//         bgColor: bgColor,
//         onDismiss: () => entry.remove(),
//         duration: duration,
//       );
//     },
//   );
//
//   overlay.insert(entry);
// }

void showTopNotification(
    BuildContext context, {
      required String title,
      required String message,
      required NotificationType type,
      Duration duration = const Duration(seconds: 1),
    }) {
  final overlay = Overlay.of(context);
  late OverlayEntry barrierEntry;
  late OverlayEntry notificationEntry;

  // 1️⃣ Barrier entry (background unclickable)
  barrierEntry = OverlayEntry(
    builder: (_) => const ModalBarrier(
      dismissible: false, // cannot tap to dismiss
      color: Colors.black26, // slight transparent overlay
    ),
  );

  // 2️⃣ Notification entry
  notificationEntry = OverlayEntry(
    builder: (context) {
      Color bgColor =
      type == NotificationType.success ? Color(0xFF0000FF) : Color(0xFFC40000);
      IconData icon = type == NotificationType.success ? Icons.check : Icons.close;

      return _TopNotificationWidget(
        title: title,
        message: message,
        icon: icon,
        bgColor: bgColor,
        onDismiss: () {
          notificationEntry.remove();
          barrierEntry.remove(); // remove barrier when notification is gone
        },
        duration: duration,
      );
    },
  );

  // 3️⃣ Insert barrier first, then notification on top
  overlay.insert(barrierEntry);
  overlay.insert(notificationEntry);
}


/// Widget for the notification
class _TopNotificationWidget extends StatefulWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onDismiss;
  final Duration duration;

  const _TopNotificationWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    required this.bgColor,
    required this.onDismiss,
    required this.duration,
  }) : super(key: key);

  @override
  _TopNotificationWidgetState createState() => _TopNotificationWidgetState();
}

class _TopNotificationWidgetState extends State<_TopNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // start off-screen top
      end: Offset.zero, // slide to original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto dismiss after duration
    Timer(widget.duration, () {
      _controller.reverse().then((value) => widget.onDismiss());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 10,
      right: 10,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.828),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.bgColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(6.828),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 0.683),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(widget.icon, color: Colors.white, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(height: 2),
                          Text(widget.message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
