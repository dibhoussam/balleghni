import 'package:balighni/models/Reports.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';

class ReportsProvider with ChangeNotifier {
  Reports _reports = Reports(data: Data(reports: []));
  Reports reports_all = Reports(data: Data(reports: []));
  final Api _api = Api();

  Reports get reports => _reports;
  set reports(Reports value) {
    _reports = value;
    notifyListeners();
  }

  set reportsList(List<Report> value) {
    _reports.data.reports.addAll(value);
    notifyListeners();
  }

  Future<void> fetchReports() async {
    reports = await _api.fetechReports();
  }

  Future<void> fetchMore(String page) async {
    Reports rep = await _api.LoadMoreReports(page);

    reports.data.nextPageUrl = rep.data.nextPageUrl;

    reports.data.reports.addAll(rep.data.reports);

    notifyListeners();
  }

  Future<void> fetechMoreAll(String page) async {
    Reports rep = await _api.LoadMoreReports(page);

    reports_all.data.nextPageUrl = rep.data.nextPageUrl;

    reports_all.data.reports.addAll(rep.data.reports);

    notifyListeners();
  }

  Future<void> fetch_all_Reports() async {
    reports_all = await _api.fetechAllReports();
    notifyListeners();
  }

  Future<void> deleteReports(int id) async {
    bool deleted = await _api.DeleteReport(id);
    if (deleted) {
      reports.data.reports.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}
