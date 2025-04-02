import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/database.dart';

class Addchemistpage extends StatefulWidget {
  final Database db;
  const Addchemistpage({super.key, required this.db});

  @override
  State<Addchemistpage> createState() => _AddchemistpageState();
}

class _AddchemistpageState extends State<Addchemistpage> {
  final _formKey = GlobalKey<FormState>();

  String? maritalStatus;
  String? selectedDistrict;
  bool otherDistrictSelected = false;
  String? selectedTown;
  bool otherTownSelected = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  void updateDB(String key, dynamic value) {
    widget.db.updatedatabase(key, value);
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
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.logout_sharp))
        ],
        title: Text(
          'Chemist Details',
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // First Name & Last Name in a Row
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(firstNameController, "First Name"),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(lastNameController, "Last Name"),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Town & District in a Row
                Row(
                  children: [
                    if (otherDistrictSelected)
                      Expanded(
                          child: _buildTextField(
                              districtController, 'Enter your district'))
                    else
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "District",
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
                          value: selectedDistrict,
                          items: widget.db.districts.map((district) {
                            return DropdownMenuItem(
                              value: district,
                              child: Text(district),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != 'Other') selectedDistrict = value;
                              otherDistrictSelected = (value == 'Other');
                              otherTownSelected = (value == 'Other');
                              selectedTown = null;
                            });
                          },
                        ),
                      ),
                    SizedBox(width: 10),
                    otherTownSelected
                        ? Expanded(
                            child: _buildTextField(
                                townController, "Enter your town"))
                        : Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Town",
                                labelStyle:
                                    GoogleFonts.secularOne(fontSize: 16),
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
                              value: selectedTown,
                              items: (widget.db.towns[selectedDistrict] ?? [])
                                  .map<DropdownMenuItem<String>>((town) {
                                return DropdownMenuItem(
                                  value: town,
                                  child: Text(town),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTown = value;
                                  otherTownSelected = (value == 'Other');
                                });
                              },
                            ),
                          ),
                  ],
                ),

                SizedBox(
                  height: 32,
                ),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateDB("chemistList", [
                        firstNameController.text,
                        lastNameController.text,
                        selectedDistrict ?? districtController.text,
                        selectedTown ?? townController.text,
                      ]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form Submitted Successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button background color
                    foregroundColor: Colors.white, // Text & icon color
                  ),
                  child: SizedBox(child: Center(child: Text('Submit'))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Text Field Builder Function
Widget _buildTextField(TextEditingController myController, String label,
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
