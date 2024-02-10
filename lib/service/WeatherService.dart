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

  String getImagePath() {
    String imgSource;

    String weatherMain = _weatherData!['weather'][0]['main'];

    if (weatherMain == 'Clouds') {
      imgSource = 'assets/images/cloud.png';
    } else if (weatherMain == 'Rain') {
      imgSource = 'assets/images/rainfall.png';
    } else if (weatherMain == 'Clear') {
      imgSource = 'assets/images/sunlight.svg';
    } else {
      imgSource = 'assets/images/weather.png'; // Default image if no match
    }

    return imgSource;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: _weatherData == null
          ? Center(
              child: CircularProgressIndicator(), // Circular loading indicator
            )
          : Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Today Weather",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${(_weatherData!['main']['temp'] - 273.15).toStringAsFixed(2)} °C",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${_weatherData!['weather'][0]['description']}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 118, 117, 117),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Image.asset(getImagePath())
              ],
            ),
    );
  }
}
