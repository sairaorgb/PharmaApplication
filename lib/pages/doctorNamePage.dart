import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/database.dart';
import 'package:pharma_application/pages/homePage.dart';

class Doctornamepage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome, Doctor!",
                      style: GoogleFonts.secularOne(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          hintText: "Enter your name",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = _controller.text;
                    if (name.isNotEmpty) {
                      // Navigate to the next screen or show welcome message

                      Database db = Database();
                      db.updatedatabase("doctorName", name);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Welcome, Dr. $name!")),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: GoogleFonts.sansita(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
