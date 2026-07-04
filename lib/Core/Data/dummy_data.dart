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

  static Map<String, List<String>> globallyBookedSlots = {};

  static void addNewBooking(String dateStr, String timeSlot) {
    if (globallyBookedSlots.containsKey(dateStr)) {
      if (!globallyBookedSlots[dateStr]!.contains(timeSlot)) {
        globallyBookedSlots[dateStr]!.add(timeSlot);
      }
    } else {
      globallyBookedSlots[dateStr] = [timeSlot];
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////
  // Home Care
  //
  ////////////////////////////////////////////////////////////////////////////////////////////
  static Map<String, Map<String, List<String>>> homecareCategoryBookedSlots = {
    'doctor': {},
    'diagnosis': {},
    'nurse': {},
    'physio': {},
    'medical equipments': {},
  };


  static void addNewBookingForHomecare(String category, String dateStr, String timeSlot) {
    String key = category.toLowerCase();
    if (!homecareCategoryBookedSlots.containsKey(key)) {
      homecareCategoryBookedSlots[key] = {};
    }
    if (homecareCategoryBookedSlots[key]!.containsKey(dateStr)) {
      if (!homecareCategoryBookedSlots[key]![dateStr]!.contains(timeSlot)) {
        homecareCategoryBookedSlots[key]![dateStr]!.add(timeSlot);
      }
    } else {
      homecareCategoryBookedSlots[key]![dateStr] = [timeSlot];
    }
  }


   /////////////////////////////////////////////////////////////////////////////////////////////
  // Appointments
  //
  ////////////////////////////////////////////////////////////////////////////////////////////

  static List<Map<String, dynamic>> appointmentsDoctorList = [
    for (int i = 1; i <= 100; i++)
      {
        "doctorId": "doc_$i",

        "doctorName": (i % 8 == 0)
            ? "Dr. Arjun Mehta $i"
            : (i % 8 == 1)
            ? "Dr. Priya Nair $i"
            : (i % 8 == 2)
            ? "Dr. Sameer Khan $i"
            : (i % 8 == 3)
            ? "Dr. Neha Sharma $i"
            : (i % 8 == 4)
            ? "Dr. Rajesh Patel $i"
            : (i % 8 == 5)
            ? "Dr. Anjali Verma $i"
            : (i % 8 == 6)
            ? "Dr. Harish Reddy $i"
            : "Dr. Kavita Singh $i",

        "qualification": (i % 4 == 0)
            ? "MBBS, MD (General Medicine)"
            : (i % 4 == 1)
            ? "MBBS, MD (General Medicine)"
            : (i % 4 == 2)
            ? "MBBS, MD (General Medicine)"
            : "MBBS, MD (General Medicine)",

        // category wise
        "speciality": (i % 8 == 0)
            ? "General Physician / Internal Medicine"
            : (i % 8 == 1)
            ? "ENT / Internal Medicine"
            : (i % 8 == 2)
            ? "Dermatology / Internal Medicine"
            : (i % 8 == 3)
            ? "Cardiology / Internal Medicine"
            : (i % 8 == 4)
            ? "Urology / Internal Medicine"
            : (i % 8 == 5)
            ? "Orthopedics / Internal Medicine"
            : (i % 8 == 6)
            ? "Endocrinology / Internal Medicine"
            : "Pediatrics / Internal Medicine",

        "category": (i % 8 == 0)
            ? "General Physician"
            : (i % 8 == 1)
            ? "ENT"
            : (i % 8 == 2)
            ? "Dermatology"
            : (i % 8 == 3)
            ? "Cardiology"
            : (i % 8 == 4)
            ? "Urology"
            : (i % 8 == 5)
            ? "Orthopedics"
            : (i % 8 == 6)
            ? "Endocrinology"
            : "Pediatrics",

        // area / sub-speciality
        "area": (i % 6 == 0)
            ? "Adult Allergist"
            : (i % 6 == 1)
            ? "Allergy and Immunology"
            : (i % 6 == 2)
            ? "Asthma"
            : (i % 6 == 3)
            ? "Bariatrics"
            : (i % 6 == 4)
            ? "Medicine"
            : "General Consultation",

        // experience group
        "experienceYears": (i % 4 == 0)

            ? "0-5 years"
            : (i % 4 == 1)
            ? "6-10 years"
            : (i % 4 == 2)
            ? "11-16 years"
            : "17-21 years",

        "experience": (i % 4 == 0)
            ? '3 YEARS Experience'
            : (i % 4 == 1)
            ? '8 YEARS Experience'
            : (i % 4 == 2)
            ? '14 YEARS Experience'
            : '19 YEARS Experience',

        // fee group
        "fee": (i % 3 == 0)
            ? '400'
            : (i % 3 == 1)
            ? '900'
            : '3000',

        "feeRange": (i % 3 == 0)
            ? "QR 100-500"
            : (i % 3 == 1)
            ? "QR 500-1000"
            : "QR 1000-5000",

        "regularFee": (i % 3 == 0)
            ? "QR 400"
            : (i % 3 == 1)
            ? "QR 900"
            : "QR 3000",

        "discountFee": (i % 3 == 0)
            ? "QR 300"
            : (i % 3 == 1)
            ? "QR 800"
            : "QR 2500",

        // availability
        "availability": (i % 4 == 0)
            ? "Now"
            : (i % 4 == 1)
            ? "Today"
            : (i % 4 == 2)
            ? "Tomorrow"
            : "Next 3 Days",

        // gender
        "gender": (i % 2 == 0) ? "Male" : "Female",

        // language
        "language": (i % 3 == 0)
            ? "English"
            : (i % 3 == 1)
            ? "Tamil"
            : "Kannada",

        // city
        "city": (i % 5 == 0)
            ? "Bangalore"
            : (i % 5 == 1)
            ? "Hosur"
            : (i % 5 == 2)
            ? "Chennai"
            : (i % 5 == 3)
            ? "Mumbai"
            : "Agra",

        "rating": (i % 5 == 0)
            ? "4.5"
            : (i % 5 == 1)
            ? "4.6"
            : (i % 5 == 2)
            ? "4.7"
            : (i % 5 == 3)
            ? "4.8"
            : "4.9",

        "workLocation":
        "Hospital ${(i % 10) + 1}, ${(i % 5 == 0) ? "Bangalore" : (i % 5 == 1) ? "Hosur" : (i % 5 == 2) ? "Chennai" : (i % 5 == 3) ? "Mumbai" : "Agra"}",

        "photo": null,
      }
  ];
  static List<Map<String, dynamic>> getAppointmentsDoctorsByCategory({
    String category = "all",
  }) {
    List<Map<String, dynamic>> temp = List.from(appointmentsDoctorList);

    if (category.toLowerCase() != "all") {
      temp = temp.where((doctor) {
        return (doctor["category"] ?? "")
            .toString()
            .toLowerCase() ==
            category.toLowerCase();
      }).toList();
    }

    return temp;
  }

  static Map<String, Map<String, Map<String, List<String>>>> categoryDoctorBookedSlots = {};
  // Naya Appointment save karne ka function
  static void addAppointmentBooking(String category, String doctorId, String dateStr, String timeSlot) {
    String cat = category.toLowerCase();

    // 1. Agar category pehli baar aa rahi hai
    if (!categoryDoctorBookedSlots.containsKey(cat)) {
      categoryDoctorBookedSlots[cat] = {};
    }

    // 2. Agar doctor us category me pehli baar aa raha hai
    if (!categoryDoctorBookedSlots[cat]!.containsKey(doctorId)) {
      categoryDoctorBookedSlots[cat]![doctorId] = {};
    }

    // 3. Date aur Time save karna
    if (categoryDoctorBookedSlots[cat]![doctorId]!.containsKey(dateStr)) {
      if (!categoryDoctorBookedSlots[cat]![doctorId]![dateStr]!.contains(timeSlot)) {
        categoryDoctorBookedSlots[cat]![doctorId]![dateStr]!.add(timeSlot);
      }
    } else {
      categoryDoctorBookedSlots[cat]![doctorId]![dateStr] = [timeSlot];
    }
  }


  //////////////////////////////////////////////////////////////////////////////
  //    Medication
  //
  /////////////////////////////////////////////////////////////////////////////

  static Map<String, Map<String, List<String>>> medicationBookedSlots = {};
  static void addMedicationBooking(String id, String dateStr, String timeSlot) {
    // Agar id null ya khali hai, toh "unknown" set kar do
    String keyId = (id.isEmpty) ? "unknown" : id;

    // 1. Agar ID pehli baar aa rahi hai
    if (!medicationBookedSlots.containsKey(keyId)) {
      medicationBookedSlots[keyId] = {};
    }

    // 2. Date aur Time save karna
    if (medicationBookedSlots[keyId]!.containsKey(dateStr)) {
      if (!medicationBookedSlots[keyId]![dateStr]!.contains(timeSlot)) {
        medicationBookedSlots[keyId]![dateStr]!.add(timeSlot);
      }
    } else {
      medicationBookedSlots[keyId]![dateStr] = [timeSlot];
    }
  }
}