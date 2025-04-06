import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharma_application/database.dart';
import 'package:pharma_application/pages/addMedicine.dart';
import 'package:pharma_application/pages/selectMed.dart';
import 'package:pharma_application/pages/setBrochure.dart';

class Brochurepage extends StatefulWidget {
  final Database db;
  Brochurepage({super.key, required this.db});

  @override
  State<Brochurepage> createState() => _BrochurepageState();
}

class _BrochurepageState extends State<Brochurepage> {
  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Storage permission granted!");
    } else {
      print("Storage permission denied!");
    }
  }

  late List<String> selectedMedicines;
  late List<String> totMedicines;
  late List<Map<String, dynamic>> loadedMedicineImages;

  @override
  void initState() {
    super.initState();
    selectedMedicines = getTotalMedicines();
    loadedMedicineImages = (widget.db.mybox.get("medicineImages") as List)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  List<String> getTotalMedicines() {
    var medNameFromDB;
    setState(() {
      var storedData = (widget.db.mybox.get("medicineImages") as List);
      // .cast<Map<String, dynamic>>();

      if (storedData is List) {
        // List<Map<String, dynamic>> validEntries = storedData
        //     .whereType<Map<String, dynamic>>() // Filters out invalid entries
        //     .toList();
        totMedicines = storedData
            .where((map) => map.containsKey("name")) // Ensure "name" key exists
            .map((map) => map["name"].toString()) // Convert to String
            .toList();
        medNameFromDB = totMedicines;
      } else {
        totMedicines = [];
        medNameFromDB = totMedicines;
      }
    });

    return medNameFromDB;
  }

  void selectedMeds(List<String> selectedImgs) {
    setState(() {
      selectedMedicines = selectedImgs;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("brochure");
    // print(selectedMedicines);
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Addmedicine(
                        db: widget.db,
                      ),
                    ),
                icon: Icon(Icons.add_box_outlined)),
            IconButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => SelectImageNames(
                        db: widget.db,
                        onNamesSelected: (p0) => selectedMeds(p0),
                        totMedicines: totMedicines,
                      ),
                    ),
                icon: Icon(Icons.settings))
          ],
          title: Text(
            'Brochure',
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
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 530.0,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
                items: selectedMedicines.map((path) {
                  // Find the matching map by name
                  final matchingEntry = loadedMedicineImages.firstWhere(
                    (map) => map['name'] == path,
                    orElse: () => {}, // fallback if not found
                  );

                  final imageBytes = matchingEntry['image'];

                  return Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: imageBytes != null
                          ? DecorationImage(
                              image: MemoryImage(imageBytes),
                              fit: BoxFit.contain,
                            )
                          : null,
                    ),
                    child: imageBytes == null
                        ? Center(child: Text("Image not found"))
                        : null,
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}
