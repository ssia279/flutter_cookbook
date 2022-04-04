import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() {
    return _LocationScreenState();
  }

}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  @override
  void initState() {
    getPosition().then((Position? myPos) {

      myPosition = (myPos != null) ?'Latitude: ' + myPos!.latitude.toString() + ' - Longitude: ' + myPos.longitude.toString() : 'Not available';
      setState(() {
        myPosition = myPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Location')),
      body: Center(child: Text(myPosition)),
    );
  }

  Future<Position?> getPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();
    return position;
  }

}