import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/components/button.dart';
import 'package:pharma_application/database.dart';
import 'package:pharma_application/pages/addChemistPage.dart';
import 'package:pharma_application/pages/brochurePage.dart';
import 'package:pharma_application/pages/detailsPage.dart';
import 'package:pharma_application/pages/doctorNamePage.dart';

class welcomePage extends StatelessWidget {
  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    db.initdatabase();
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF75cdbd),
              Color(0xFF007acc)
            ], // Green to deep blue
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Company logo placeholder
            CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Container(
                  width: 170,
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
            SizedBox(height: 20),
            // Welcome text
            Text(
              'Welcome to Crasenim Pharma',
              style: GoogleFonts.secularOne(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            // Four rectangular buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    label: '   Add Doctor ',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorNamePage(
                            db: db,
                          ),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Button(
                    label: 'Add Chemist  ',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Addchemistpage(
                            db: db,
                          ),
                        ))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    label: 'Brochure',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Brochurepage(db: db),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Button(
                    label: 'Details   ',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detailspage(
                            db: db,
                          ),
                        ))),
              ],
            ),
            SizedBox(height: 30),
            // Footer text
            Text(
              'For Healthy Life',
              style: GoogleFonts.secularOne(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
