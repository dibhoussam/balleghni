import 'package:admin/models/Announces.dart';
import 'package:admin/service/Api.dart';
//import 'package:cross_file/src/types/interface.dart';

//import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncesProvider with ChangeNotifier {
  Announces _announces = Announces(data: []);

  final Api _api = Api();

  Announces get announces => _announces;

  set announces(Announces value) {
    _announces = value;
    notifyListeners();
  }

  Future<void> fetchAnnounces() async {
    announces = await _api.fetechAnnounces();
  }

  Future<bool> AddAnnounces(
      int id, String titre, String des, String des_fr, XFile img) async {
    return await _api.AddAnnounce(id, des, des_fr, img, titre);
  }

  DeleteAnnounces(int id) async {
    bool worked = await _api.deleteAnnounce(id);
    if (worked) fetchAnnounces();
    return worked;
  }

  EditAnnounces(int id, String? titre, String? des, XFile? img) async {
    bool worked = await _api.editAnnounce(id, titre, des, img);
    if (worked) fetchAnnounces();
    return worked;
  }
}
