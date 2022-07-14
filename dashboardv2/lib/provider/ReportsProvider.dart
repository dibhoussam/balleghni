import 'package:admin/models/Reports.dart';
import 'package:admin/service/Api.dart';
//import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';

class ReportsProvider with ChangeNotifier {
  Reports _reports = Reports(data: []);
  final Api _api = Api();

  Reports get reports => _reports;
  set reports(Reports value) {
    _reports = value;
    notifyListeners();
  }

  set reportsList(List<Report> value) {
    _reports.data.addAll(value);
    notifyListeners();
  }

  Future<void> fetchReports() async {
    reports = await _api.fetechReports();
  }

  Future<void> deleteReports(int id) async {
    bool deleted = await _api.DeleteReport(id);
    if (deleted) {
      reports.data.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

  Future<bool> updateReport(int id, String? Commentaire, int? st) async {
    if (await _api.updateReport(id, Commentaire, st)) {
      reports = await _api.fetechReports();
      // notifyListeners();
      return true;
    }
    return false;
  }
}
