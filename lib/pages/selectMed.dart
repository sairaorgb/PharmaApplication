import 'package:flutter/material.dart';
import 'package:pharma_application/database.dart';

class SelectImageNames extends StatefulWidget {
  final Database db;
  final List<String> totMedicines;
  final Function(List<String>) onNamesSelected;
  const SelectImageNames(
      {Key? key,
      required this.db,
      required this.onNamesSelected,
      required this.totMedicines})
      : super(key: key);

  @override
  _SelectImageNamesState createState() => _SelectImageNamesState();
}

class _SelectImageNamesState extends State<SelectImageNames> {
  Set<String> selectedNames = {}; // To store selected names
  late List<String> imageNames;

  @override
  void initState() {
    super.initState();
    imageNames = widget.totMedicines;
  }

  @override
  Widget build(BuildContext context) {
    imageNames = widget.totMedicines;
    return AlertDialog(
      backgroundColor: Color.fromRGBO(169, 211, 197, 1),
      title: Text("Select Images"),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents full expansion
          children: [
            // List of Image Names with Add/Remove Buttons
            SizedBox(
              height: 250, // Set a fixed height for the list
              child: ListView.builder(
                itemCount: imageNames.length,
                itemBuilder: (context, index) {
                  String name = imageNames[index];
                  bool isSelected = selectedNames.contains(name);

                  return ListTile(
                    title: Text(name),
                    trailing: IconButton(
                      icon: Icon(
                        isSelected ? Icons.remove_circle : Icons.add_circle,
                        color: isSelected ? Colors.red : Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          isSelected
                              ? selectedNames.remove(name)
                              : selectedNames.add(name);
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // "Set" Button to Send Data to Parent
            ElevatedButton(
              onPressed: () {
                widget.onNamesSelected(selectedNames.toList());
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Set"),
            ),
          ],
        ),
      ),
    );
  }
}
