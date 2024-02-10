import 'package:flutter/material.dart';

class DiseasePredict extends StatefulWidget {
  const DiseasePredict({super.key});

  @override
  State<DiseasePredict> createState() => _DiseasePredictState();
}

class _DiseasePredictState extends State<DiseasePredict> {
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
                    color: Color.fromARGB(255, 114, 214, 0),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                    ),
                  ),
                ),
          ]),
        ));
  }
}
