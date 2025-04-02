import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:hive_flutter/adapters.dart';

class Database {
  var mybox = Hive.box('myBox');

  void initdatabase() {
    if (!mybox.containsKey("districts")) {
      mybox.put("districts", districts);
    } else {
      districts = (mybox.get("districts") as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();
    }
    if (!mybox.containsKey("towns")) {
      mybox.put("towns", towns);
    } else {
      towns = (mybox.get("towns") as Map<dynamic, dynamic>).map((key, value) =>
          MapEntry(
              key.toString(), // Convert key to String
              (value as List<dynamic>)
                  .map((e) => e.toString())
                  .toList() // Convert value to List<String>
              ));
    }
    if (!mybox.containsKey("doctorsList")) {
      mybox.put("doctorsList", doctorsList);
    } else {
      doctorsList = (mybox.get("doctorsList") as List<dynamic>? ?? [])
          .whereType<List>() // Ensure only lists are included
          .map((e) => e
              .map((item) => item.toString())
              .toList()) // Convert inner elements to Strings
          .toList();
    }
    if (!mybox.containsKey("chemistList")) {
      mybox.put("chemistList", chemistList);
    } else {
      chemistList = (mybox.get("chemistList") as List<dynamic>? ?? [])
          .map((e) => List<String>.from(e as List))
          .toList();
    }
    if (!mybox.containsKey("medicineImages")) {
      mybox.put("medicineImages", medicineImages); // Store list of maps
    } else {
      medicineImages = (mybox.get("medicineImages") as List<dynamic>? ?? [])
          .cast<
              Map<String,
                  dynamic>>(); // Ensure it's a List<Map<String, dynamic>>
    }
  }

  void updatedatabase(String key, dynamic value) {
    if (key == "doctorsList") {
      doctorsList.add(value);
      mybox.put(key, doctorsList);
    } else if (key == "chemistList") {
      chemistList.add(value);
      mybox.put(key, chemistList);
    } else if (key == "medicineImages") {
      medicineImages.add(value);
      mybox.put(key, medicineImages);
      print("added $value[\"name\"]");
    }
  }

  dynamic getdatabase(String Key) {
    return mybox.get(Key);
  }

  List<List<String>> doctorsList = [];
  List<List<String>> chemistList = [];

  List<String> districts = [
    "Visakapatnam",
    "Srikakulam",
    "Vizianagaram",
    "Other"
  ];
  Map<String, List> towns = {
    "Vizianagaram": [
      "Vizianagaram",
      "Bobbili",
      "Salur",
      "Nellimarla",
      "Rajam",
      "Parvathipuram",
      "Cheepurupalli",
      "Other"
    ]
  };

  List<Map<String, dynamic>> medicineImages = [];
}
