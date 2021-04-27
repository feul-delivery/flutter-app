import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class GeoCoder extends StatefulWidget {
  GeoCoder({Key key}) : super(key: key);

  @override
  _GeoCoderState createState() => _GeoCoderState();
}

String address = "";
Future<Coordinates> getCoordinatesFromAddress() async {
  final query = "1600 Amphiteatre Parkway, Mountain View";
  var addresses = await Geocoder.local.findAddressesFromQuery(query);
  var first = addresses.first;
  print("${first.featureName} : ${first.coordinates}");
  return first.coordinates;
}

Future<String> getAddressFromCoordinates(Coordinates coordinates) async {
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  print("${first.featureName} : ${first.addressLine}");
  return first.addressLine;
}

class _GeoCoderState extends State<GeoCoder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(address),
              TextButton(
                  onPressed: () async {
                    var str = await getAddressFromCoordinates(
                        Coordinates(34.016183, -4.985991));
                    setState(() {
                      address = str;
                    });
                  },
                  child: Text('Get it'))
            ],
          ),
        ),
      ),
    );
  }
}
