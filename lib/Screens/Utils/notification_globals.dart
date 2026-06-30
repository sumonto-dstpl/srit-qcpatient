
import 'package:flutter/material.dart';

// 1. Model yahan move kar diya gaya hai
class NotificationModel {
  final int id;
  final String date;
  final String time;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String buttonSelected;
  bool markAllRead;

  NotificationModel({
    required this.id,
    required this.date,
    required this.time,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.buttonSelected,
    this.markAllRead = false,
  });
}

// 2. Global ValueNotifier
final ValueNotifier<int> globalNotificationCount = ValueNotifier<int>(0);

// 3. Offers Count Global
int globalOffers = 3;

// 4. Aapki puri list yahan Global ban gayi hai
final List<NotificationModel> globalNotifications = [
  NotificationModel(id: 01, date: "2025-10-30", time: "09:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sharma", subtitle2: "Dental Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 02, date: "2025-10-30", time: "09:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Neha", subtitle2: "Blood Test", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 03, date: "2025-10-30", time: "10:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Reddy", subtitle2: "Eye Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 04, date: "2025-10-30", time: "10:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Priya", subtitle2: "ECG Scan", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 05, date: "2025-10-30", time: "11:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Mehta", subtitle2: "Heart Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 06, date: "2025-10-30", time: "11:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Gupta", subtitle2: "X-Ray Imaging", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 07, date: "2025-10-30", time: "12:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sneha", subtitle2: "General Consultation", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 08, date: "2025-10-30", time: "12:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Arjun", subtitle2: "MRI Scan", buttonSelected: "Reports", markAllRead: true),
  NotificationModel(id: 09, date: "2025-10-30", time: "01:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. A. Kumar", subtitle2: "ENT Checkup", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 10, date: "2025-10-30", time: "01:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Rohit", subtitle2: "Ultrasound Report", buttonSelected: "Reports", markAllRead: false),

  NotificationModel(id: 11, date: "2025-10-29", time: "09:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sharma", subtitle2: "Dental Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 12, date: "2025-10-29", time: "09:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Neha", subtitle2: "Blood Test", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 13, date: "2025-10-29", time: "10:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Reddy", subtitle2: "Eye Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 14, date: "2025-10-29", time: "10:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Priya", subtitle2: "ECG Scan", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 15, date: "2025-10-29", time: "11:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Mehta", subtitle2: "Heart Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 16, date: "2025-10-29", time: "11:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Gupta", subtitle2: "X-Ray Imaging", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 17, date: "2025-10-29", time: "12:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sneha", subtitle2: "General Consultation", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 18, date: "2025-10-29", time: "12:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Arjun", subtitle2: "MRI Scan", buttonSelected: "Reports", markAllRead: true),
  NotificationModel(id: 19, date: "2025-10-29", time: "01:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. A. Kumar", subtitle2: "ENT Checkup", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 20, date: "2025-10-29", time: "01:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Rohit", subtitle2: "Ultrasound Report", buttonSelected: "Reports", markAllRead: false),

  NotificationModel(id: 21, date: "2025-10-28", time: "09:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sharma", subtitle2: "Dental Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 22, date: "2025-10-28", time: "09:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Neha", subtitle2: "Blood Test", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 23, date: "2025-10-28", time: "10:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Reddy", subtitle2: "Eye Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 24, date: "2025-10-28", time: "10:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Priya", subtitle2: "ECG Scan", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 25, date: "2025-10-28", time: "11:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Mehta", subtitle2: "Heart Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 26, date: "2025-10-28", time: "11:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Gupta", subtitle2: "X-Ray Imaging", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 27, date: "2025-10-28", time: "12:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sneha", subtitle2: "General Consultation", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 28, date: "2025-10-28", time: "12:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Arjun", subtitle2: "MRI Scan", buttonSelected: "ReportsServices", markAllRead: true),
  NotificationModel(id: 29, date: "2025-10-28", time: "01:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. A. Kumar", subtitle2: "ENT Checkup", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 30, date: "2025-10-28", time: "01:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Rohit", subtitle2: "Ultrasound Report", buttonSelected: "Reports", markAllRead: false),

  NotificationModel(id: 31, date: "2025-10-27", time: "09:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sharma", subtitle2: "Dental Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 32, date: "2025-10-27", time: "09:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Neha", subtitle2: "Blood Test", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 33, date: "2025-10-27", time: "10:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Reddy", subtitle2: "Eye Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 34, date: "2025-10-27", time: "10:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Priya", subtitle2: "ECG Scan", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 35, date: "2025-10-27", time: "11:00 AM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Mehta", subtitle2: "Heart Checkup", buttonSelected: "Appointments", markAllRead: true),
  NotificationModel(id: 36, date: "2025-10-27", time: "11:30 AM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Gupta", subtitle2: "X-Ray Imaging", buttonSelected: "Reports", markAllRead: false),
  NotificationModel(id: 37, date: "2025-10-27", time: "12:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. Sneha", subtitle2: "General Consultation", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 38, date: "2025-10-27", time: "12:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Arjun", subtitle2: "MRI Scan", buttonSelected: "Reports", markAllRead: true),
  NotificationModel(id: 39, date: "2025-10-27", time: "01:00 PM", image: "assets/NutanBhatt.png", title: "Appointments", subtitle1: "Dr. A. Kumar", subtitle2: "ENT Checkup", buttonSelected: "Appointments", markAllRead: false),
  NotificationModel(id: 40, date: "2025-10-27", time: "01:30 PM", image: "assets/NutanBhatt.png", title: "Reports", subtitle1: "Dr. Rohit", subtitle2: "Ultrasound Report", buttonSelected: "Reports", markAllRead: false),
];

// 5. Yeh function app open hote hi count calculate kar lega
void calculateAndUpdateGlobalCount() {
  int unreadNotificationsCount = globalNotifications.where((n) => n.markAllRead == false).length;
  globalNotificationCount.value = globalOffers + unreadNotificationsCount;
}