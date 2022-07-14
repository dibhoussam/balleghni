import 'package:flutter/cupertino.dart';
import 'package:admin/models/Wilayas.dart';

class WilayasmenuProvider with ChangeNotifier {
  Wilayamenu _wilayas = Wilayamenu(wilayas: []);

  //final Api _api = Api();

  Wilayamenu get wilayas => _wilayas;

  set wilayas(Wilayamenu value) {
    _wilayas = value;
    notifyListeners();
  }

  Future<void> fetchWilayasmenu() async {
    // wilayas = await _api.fetechWilayas();
  }
}
