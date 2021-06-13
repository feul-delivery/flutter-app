import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class ClientProvider extends ChangeNotifier {
  Coordinates locationCoordinates;
  setCoordinates(Coordinates coordinates) {
    this.locationCoordinates = coordinates;
    notifyListeners();
  }
}
