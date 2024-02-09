import 'package:flutter/material.dart';
import 'package:enhanced_http/enhanced_http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class WeatherService extends StatefulWidget {

  @override
  State<WeatherService> createState() => _WeatherServiceState();
}

class _WeatherServiceState extends State<WeatherService> {
  late Position _currentPosition;
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle denied permissions
        return;
      }
    }
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    print("hello");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
    print(_currentPosition);
    _fetchWeatherData(_currentPosition.latitude, _currentPosition.longitude);
  }

  Future _fetchWeatherData(double lat, double lon) async {
    String apiKey =
        '17769e544a4a37e4e17e0e777ddd8fba'; // Replace with your OpenWeather API key
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';
    try {
      Uri uri = Uri.parse(apiUrl);
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
        });
        print(_weatherData);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove app bar to avoid overlaying with parent widget's app bar
      body: Center(
        child: Container(
          // Add constraints to give the container a specific size
          width: 200, // Adjust width as needed
          height: 200, // Adjust height as needed
          child: _weatherData != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Temperature: ${_weatherData!['main']['temp']}',
                    ),
                    // Add more widgets to display other weather data as needed
                  ],
                )
              : CircularProgressIndicator(), // Show loading indicator while fetching data
        ),
      ),
    );
  }

}
