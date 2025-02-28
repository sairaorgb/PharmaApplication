import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/pages/doctorNamePage.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
              child: Container(
            height: 200,
            child: Image.asset(
              fit: BoxFit.cover,
              'assets/images/logo.jpg',
            ),
          )),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Doctornamepage(),
                )),
            child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                    "Get Started",
                    style: GoogleFonts.secularOne(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 21),
                  )),
                )),
          )
        ],
      ),
    );
  }
}
