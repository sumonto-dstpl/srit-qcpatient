// Ye import add karna zaruri hai ValueNotifier ke liye
import 'package:flutter/foundation.dart';

class DummyData {

  static List<String> cityFilters = [
    "Doha",
    "Al Wakrah",
    "Al Khor",
    "Umm Salal",
    "Al Rayyan",
    "Madinat"
  ];

  static List<Map<String, dynamic>> hospitalLocations = [
    for(int i = 1; i <= 100; i++) {
      "id": "qc_${i.toString().padLeft(3, '0')}",
      "name": "QCT Clinic ${String.fromCharCode(64 + (i % 26) + 1)} ($i)",
      "city": cityFilters[(i - 1) % cityFilters.length],
      "area": (cityFilters[(i - 1) % cityFilters.length] == "Doha")
          ? ((i % 2 == 0) ? "Al Meqab" : "Sohp")
          : (cityFilters[(i - 1) % cityFilters.length] == "Al Wakrah")
          ? ((i % 2 == 0) ? "Al Wukair" : "Al Mashaf")
          : "Area ${i % 10 + 1}",
      "street": "Street $i",
      "locality": "Locality ${i % 5 + 1}",
      "distance" : (i % 6 == 0)
          ? "1.0 km"
          : (i % 6 == 1)
          ? "2.0 km"
          : (i % 6 == 2)
          ? "3.0 km"
          : (i % 6 == 3)
          ? "4.0 km"
          : (i % 6 == 4)
          ? "5.0 km"
          :"6.0 km",
    }
  ];

  // Purana code:
  // static String hospitalLocation = "QCT Clinic A,QATAR 500006";

  // Naya code (Isko Replace karein):
  static ValueNotifier<String> hospitalLocationNotifier = ValueNotifier<String>("QCT Clinic A,QATAR 500006");

}