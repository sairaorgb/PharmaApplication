import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

Widget customTextField(TextEditingController myController, String label,
    {bool isNumber = false}) {
  return TextFormField(
    controller: myController,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.secularOne(fontSize: 16),
      filled: true,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    ),
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
  );
}
