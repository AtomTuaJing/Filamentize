import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FilamentizeData extends ChangeNotifier {
  BluetoothDevice? filamentizeDevice;
  BluetoothCharacteristic? filamentizeStatus;
  BluetoothCharacteristic? filamentizeOne;
  BluetoothCharacteristic? filamentizeTwo;
  BluetoothCharacteristic? filamentizeThree;
  BluetoothCharacteristic? setDeviceStatus;
  BluetoothCharacteristic? setDeviceMode;
  BluetoothCharacteristic? temp01;
  BluetoothCharacteristic? temp02;
  BluetoothCharacteristic? coolingFan01;
  BluetoothCharacteristic? coolingFan02;
  BluetoothCharacteristic? spoolMotor;
  BluetoothCharacteristic? spoolReset;
  BluetoothCharacteristic? extruder;
  BluetoothCharacteristic? stepper;
  BluetoothCharacteristic? vibrator;
  BluetoothCharacteristic? color;

  void changeFilamentizeDevice({required BluetoothDevice device}) {
    filamentizeDevice = device;
    notifyListeners();
  }

  void changeFilamentizeStatus({required characteristic}) {
    filamentizeStatus = characteristic;
    notifyListeners();
  }

  void changeFilamentizeOne({required characteristic}) {
    filamentizeOne = characteristic;
    notifyListeners();
  }

  void changeFilamentizeTwo({required characteristic}) {
    filamentizeTwo = characteristic;
    notifyListeners();
  }

  void changeFilamentizeThree({required characteristic}) {
    filamentizeThree = characteristic;
    notifyListeners();
  }

  void changeSetDeviceStatus({required characteristic}) {
    setDeviceStatus = characteristic;
    notifyListeners();
  }

  void changeSetDeviceMode({required characteristic}) {
    setDeviceMode = characteristic;
    notifyListeners();
  }

  void changeTemp01({required characteristic}) {
    temp01 = characteristic;
    notifyListeners();
  }

  void changeTemp02({required characteristic}) {
    temp02 = characteristic;
    notifyListeners();
  }

  void changeCoolingFan01({required characteristic}) {
    coolingFan01 = characteristic;
    notifyListeners();
  }

  void changeCoolingFan02({required characteristic}) {
    coolingFan02 = characteristic;
    notifyListeners();
  }

  void changeSpoolMotor({required characteristic}) {
    spoolMotor = characteristic;
    notifyListeners();
  }

  void changeSpoolReset({required characteristic}) {
    spoolReset = characteristic;
    notifyListeners();
  }

  void changeExtruder({required characteristic}) {
    extruder = characteristic;
    notifyListeners();
  }

  void changeStepper({required characteristic}) {
    stepper = characteristic;
    notifyListeners();
  }

  void changeVibrator({required characteristic}) {
    vibrator = characteristic;
    notifyListeners();
  }

  void changeColor({required characteristic}) {
    color = characteristic;
    notifyListeners();
  }
}
