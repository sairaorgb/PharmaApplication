import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_application/components/custTF.dart';
import 'package:pharma_application/database.dart';

class Setbrochure extends StatefulWidget {
  final Database db;
  const Setbrochure({super.key, required this.db});

  @override
  State<Setbrochure> createState() => _SetbrochureState();
}

class _SetbrochureState extends State<Setbrochure> {
  String? selectedDistrict;
  bool otherDistrictSelected = false;
  String? selectedTown;
  bool otherTownSelected = false;

  final TextEditingController townController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  List<List<String>> townDoctors(String districtName, String townName) {
    var doctorsList = widget.db.doctorsList;
    List<List<String>> groupedDoctors = [];
    for (var doctor in doctorsList) {
      if (doctor.length < 4) continue; // Ensure there are enough elements
      if (doctor[2] == districtName && doctor[3] == townName)
        groupedDoctors.add(doctor);
    }
    return groupedDoctors;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 1.8,
        width: MediaQuery.of(context).size.width / 1.5,
        child: ListView(
          children: [
            Row(
              children: [
                if (otherDistrictSelected)
                  Expanded(
                      child: customTextField(
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
                        child:
                            customTextField(townController, "Enter your town"))
                    : Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Town",
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
          ],
        ),
      ),
    );
  }
}
