import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharma_application/database.dart';
import 'package:pharma_application/pages/addMedicine.dart';

class Brochurepage extends StatelessWidget {
  final Database db;
  Brochurepage({super.key, required this.db});

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Storage permission granted!");
    } else {
      print("Storage permission denied!");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Addmedicine(
                        db: db,
                      ),
                    ),
                icon: Icon(Icons.add_box_outlined)),
            IconButton(
                onPressed: () => Navigator.pop(context),
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
          child: Column(),
        ));
  }
}
