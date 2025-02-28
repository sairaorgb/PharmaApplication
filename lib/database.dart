import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Database {
  var mybox = Hive.box('myBox');

  void initdatabase() {
    mybox.put("doctorName", doctorName);
  }

  void updatedatabase(String Key, String Value) {
    mybox.put(Key, Value);
  }

  dynamic getdatabase(String Key) {
    return mybox.get(Key);
  }

  String doctorName = '';
  String get DoctorName => doctorName;
}
