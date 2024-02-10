import 'dart:convert';
import 'dart:io';

import 'package:plant_disease_detection/screens/DiseasePredict.dart';
import 'package:enhanced_http/enhanced_http.dart' as http;

class PredictService {
  static void launchWebView() {
    print("1234");
  }

  static void predictDisease(File img) async {
    String predictURL = 'http://20.169.48.90/predict';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(predictURL));
      var file = await http.MultipartFile.fromPath('file', img.path);
      request.files.add(file);
      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        var response = await streamedResponse.stream.bytesToString();
        // Parse the JSON response
        var jsonResponse = json.decode(response);
        // Extract predicted_disease and solution from the JSON response
        String predictedDisease = jsonResponse['predicted_disease'];
        String solution = jsonResponse['solution'];
        // Use the extracted data as needed
        print('Predicted Disease: $predictedDisease');
        print('Solution: $solution');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      print("Error retrieving the data: $err");
    }
  }
}
