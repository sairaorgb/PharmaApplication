import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/database.dart';

class Doctor {
  final String firstName;
  final String lastName;
  final String district;
  final String town;
  final String maritalStatus;
  final String dateOfBirth;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.district,
    required this.town,
    required this.maritalStatus,
    required this.dateOfBirth,
  });
}

class Detailspage extends StatelessWidget {
  final Database db;
  Detailspage({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    var doctorsList = db.doctorsList;

    Map<String, Map<String, List<List<String>>>> groupedDoctors = {};

    for (var doctor in doctorsList) {
      if (doctor.length < 4) continue; // Ensure there are enough elements

      String district = doctor[2];
      String town = doctor[3];

      // Group by district
      groupedDoctors.putIfAbsent(district, () => {});

      // Group by town within the district
      groupedDoctors[district]!.putIfAbsent(town, () => []);

      // Add doctor to the respective town
      groupedDoctors[district]![town]!.add(doctor);
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: SizedBox(
                      width: 40,
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ))),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.logout_sharp))
          ],
          title: Text(
            'Doctor Details',
            style: GoogleFonts.secularOne(fontSize: 26),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF75cdbd), Color(0xFF007acc)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0, // Optional: Removes shadow for a cleaner look
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF75cdbd), Color(0xFF007acc)],
          )),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: groupedDoctors.entries.map((districtEntry) {
                final districtColor = _generateColor(districtEntry.key);
                return Card(
                  color: districtColor,
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      districtEntry.key,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    children: districtEntry.value.entries.map((townEntry) {
                      final townColor = adjustOpacity(districtColor, 0.3);
                      return Card(
                        color: townColor,
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            townEntry.key,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          children: townEntry.value.map((doctor) {
                            return ListTile(
                              tileColor: adjustOpacity(districtColor, 0.1),
                              title: Text(
                                  "${doctor[0].toUpperCase()} ${doctor[1]}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Marital Status: ${doctor[4]}",
                                      style: TextStyle(fontSize: 12)),
                                  if (doctor[4].toLowerCase() == 'yes')
                                    Text("DOM: ${doctor[5]}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }

  Color adjustOpacity(Color color, double opacity) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + (1 - opacity)) / 2).toColor();
  }

  Color _generateColor(String key) {
    final random = Random(key.hashCode);
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
