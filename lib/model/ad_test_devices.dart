import 'package:flutter_google_ad_manager/flutter_google_ad_manager.dart';

class ADTestDevices extends TestDevices {
  static ADTestDevices _instance;

  factory ADTestDevices() {
    if (_instance == null) _instance = new ADTestDevices._internal();
    return _instance;
  }

  ADTestDevices._internal();

  @override
  List<String> get values => List()..add("863581047913111")..add("863581047913103"); // Set here.
}