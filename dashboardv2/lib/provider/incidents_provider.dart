import 'package:admin/models/Incidents.dart';
import 'package:admin/service/Api.dart';
//import 'package:admin/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class IncidentsProvider with ChangeNotifier {
  Incidents _incidents = Incidents(incident: []);

  final Api _api = Api();
  final box = GetStorage();

  Incidents get incidents => _incidents;

  set incidents(Incidents value) {
    _incidents = value;
    notifyListeners();
  }

  Future<void> fetchIncidents() async {
    incidents = await _api.fetechIncidents();
  }

  Future<bool> deleteIncidents(int id) async {
    bool worked = await _api.deleteIncident(id);
    if (worked) fetchIncidents();
    return worked;
  }

  Future<bool> UpdateIncidents(int id, int? authoritie_id, String? description,
      String? icon, String? slug, String? title) async {
    bool worked =
        await _api.updateIncidents(id, description, icon, slug, title);
    if (worked) fetchIncidents();
    return worked;
  }

  Future<bool> addIncidents(int? authoritie_id, String description, XFile icon,
      String slug, String title) async {
    int id;
    if (authoritie_id == null)
      id = box.read("authoritie");
    else
      id = authoritie_id;

    bool worked = await _api.AddIncident(id, description, icon, title, slug);
    if (worked) fetchIncidents();
    return worked;
  }
}
