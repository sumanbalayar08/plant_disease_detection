import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:plant_disease_detection/service/PredictService.dart';

class DiseasePredict extends StatefulWidget {
  const DiseasePredict({super.key});

  @override
  State<DiseasePredict> createState() => _DiseasePredictState();
}

class _DiseasePredictState extends State<DiseasePredict> {
  File? _pickedImage;
  ImagePicker picker = ImagePicker();

  Future<void> _pick(ImageSource source) async {
    final pickedImageFile = await ImagePicker().pickImage(source: source);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Disease Prediction"),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: screenWidth,
                  height: 165,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 172, 0),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        // Shadow color
                        spreadRadius: 0.01,
                        // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        // Shadow color
                        spreadRadius: 0.01,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text('Open Gallery',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Montserrat')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 172, 0),
                        ),
                        onPressed: () {
                          _pick(ImageSource.gallery);
                        },
                      ),
                      ElevatedButton(
                        child: Text('Start Camera',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Montserrat')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 57, 191, 0),
                        ),
                        onPressed: () {
                          _pick(ImageSource.camera);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.orangeAccent.withOpacity(0.3),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: _pickedImage != null
                      ? Image(
                          image: FileImage(_pickedImage!),
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text("Please Add Image"),
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                PredictService.predictDisease(_pickedImage!);
                },
                child: Text('DETECT',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Montserrat')),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 57, 191, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            )
          ]),
        ));
  }
}
