import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_application/database.dart';
import '../components/custTF.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Addmedicine extends StatefulWidget {
  final Database db;
  const Addmedicine({super.key, required this.db});

  @override
  State<Addmedicine> createState() => _AddmedicineState();
}

class _AddmedicineState extends State<Addmedicine> {
  // XFile? _image;
  String? medicineInput;
  bool takeInput = false;
  Uint8List? _imageBytes;

  final TextEditingController medicineController = TextEditingController();

  Future<void> _pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempFile = File(pickedFile.path);
      Uint8List imageBytes = await tempFile.readAsBytes();

      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  Future<void> _saveImage(Uint8List loadImageBytes, String medicineName) async {
    Map<String, dynamic> newImage = {
      "name": medicineName,
      "image": loadImageBytes,
    };

    widget.db.updatedatabase("medicineImages", newImage);
  }

  @override
  Widget build(BuildContext context) {
    var medicineImages = widget.db.getdatabase('medicineImages');
    print(medicineImages);
    return AlertDialog(
      backgroundColor: Color.fromRGBO(169, 211, 197, 1),
      title: Center(
          child: Text(
        "Upload Medicine",
        style:
            GoogleFonts.secularOne(fontSize: 28, fontWeight: FontWeight.bold),
      )),
      content: Center(
        child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width / 1.5,
            child: ListView(
              children: [
                if (_imageBytes != null)
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4.5,
                        width: MediaQuery.of(context).size.height / 3.5,
                        child: _imageBytes != null
                            ? Image.memory(_imageBytes!)
                            : Text("No image saved"),
                      ),
                      if (medicineInput != null)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(medicineInput!),
                        ),
                      if (takeInput)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: customTextField(medicineController,
                                    " Enter the Name of Medicine"),
                              ),
                              IconButton(
                                  onPressed: () => setState(() {
                                        takeInput = false;
                                        medicineInput = medicineController.text;
                                        if (_imageBytes == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Add an image first")));
                                        }
                                        if (_imageBytes != null) {
                                          _saveImage(
                                              _imageBytes!, medicineInput!);
                                        }
                                      }),
                                  icon: Icon(Icons.arrow_circle_up_outlined))
                            ],
                          ),
                        )
                    ],
                  ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () => _pickAndSaveImage(),
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () => setState(() {
                                takeInput = !takeInput;
                              }),
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                if (medicineImages != null)
                  Column(
                    children: List.generate(medicineImages.length, (index) {
                      final imgData = medicineImages[index];
                      return ListTile(
                        leading: Image.memory(imgData["image"],
                            width: 50, height: 50),
                        title: Text(imgData["name"]),
                      );
                    }),
                  ),
              ],
            )),
      ),
    );
  }
}
