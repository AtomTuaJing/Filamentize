import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FilamentizeData extends ChangeNotifier {
  var filamentizeDevice;
  var filamentizeOne;
  var filamentizeTwo;
  var filamentizeThree;
  var temp01;
  var temp02;
  var coolingFan01;
  var coolingFan02;
  var spoolMotor;
  var extruder;
  var stepper;
  var vibrator;
  var color;

  void changeFilamentizeOne({required BluetoothCharacteristic characteristic}) {
    filamentizeOne = characteristic;
    notifyListeners();
  }

  void changeFilamentizeTwo({required BluetoothCharacteristic characteristic}) {
    filamentizeTwo = characteristic;
    notifyListeners();
  }

  void changeFilamentizeThree(
      {required BluetoothCharacteristic characteristic}) {
    filamentizeThree = characteristic;
    notifyListeners();
  }

  void changeTemp01({required BluetoothCharacteristic characteristic}) {
    temp01 = characteristic;
    notifyListeners();
  }

  void changeTemp02({required BluetoothCharacteristic characteristic}) {
    temp02 = characteristic;
    notifyListeners();
  }

  void changeCoolingFan01({required BluetoothCharacteristic characteristic}) {
    coolingFan01 = characteristic;
    notifyListeners();
  }

  void changeCoolingFan02({required BluetoothCharacteristic characteristic}) {
    coolingFan02 = characteristic;
    notifyListeners();
  }

  void changeSpoolMotor({required BluetoothCharacteristic characteristic}) {
    spoolMotor = characteristic;
    notifyListeners();
  }

  void changeExtruder({required BluetoothCharacteristic characteristic}) {
    extruder = characteristic;
    notifyListeners();
  }

  void changeStepper({required BluetoothCharacteristic characteristic}) {
    stepper = characteristic;
    notifyListeners();
  }

  void changeVibrator({required BluetoothCharacteristic characteristic}) {
    vibrator = characteristic;
    notifyListeners();
  }

  void changeColor({required BluetoothCharacteristic characteristic}) {
    color = characteristic;
    notifyListeners();
  }
}
