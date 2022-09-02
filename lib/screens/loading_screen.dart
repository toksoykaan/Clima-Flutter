import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "3990381a3ce9b2b156a63c0001c046b1";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double long;
  double lat;

  @override
  void initState() {
    //Runs once the app is instantiated
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.lat;
    long = location.long;

    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    //RUNS everytime widget is rebuilds like many times :D change happens this runs
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
