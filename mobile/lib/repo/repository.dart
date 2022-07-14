import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/provider/AuthoritiesProvider.dart';
import 'package:balighni/provider/ReportsProvider.dart';
import 'package:balighni/provider/WilayasProvider.dart';
import 'package:balighni/provider/incidents_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Repository {
  Future<void> fetchAnnounces(BuildContext context) async {
    AnnouncesProvider announcesprovider = Provider.of(context, listen: false);
    await announcesprovider.fetchAnnounces();
  }

  Future<void> fetchIncidents(BuildContext context) async {
    IncidentsProvider incidentsprovider = Provider.of(context, listen: false);
    await incidentsprovider.fetchIncidents();
  }

  Future<void> fetchReports(BuildContext context) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.fetchReports();
  }

  Future<void> fetchAllReports(BuildContext context) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.fetch_all_Reports();
  }

  Future<void> fetchAuthorities(BuildContext context) async {
    AuthoritiesProvider authoritiesProvider =
        Provider.of(context, listen: false);
    await authoritiesProvider.fetchAuthorities();
  }

  Future<void> fetchMoreReports(BuildContext context, String page) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.fetchMore(page);
  }

  Future<void> fetchMoreAllReports(BuildContext context, String? page) async {
    if (page != null) {
      ReportsProvider reportsprovider = Provider.of(context, listen: false);
      await reportsprovider.fetechMoreAll(page);
    }
  }

  Future<void> fetchMoreAnnounces(BuildContext context, String page) async {
    AnnouncesProvider provider = Provider.of(context, listen: false);
    await provider.fetchMore(page);
  }

  Future<void> fetchMoreAuthorities(BuildContext context, String page) async {
    AuthoritiesProvider provider = Provider.of(context, listen: false);
    await provider.fetchMore(page);
  }

  Future<void> fetchWilayas(BuildContext context) async {
    WilayasmenuProvider announcesprovider = Provider.of(context, listen: false);
    await announcesprovider.fetchWilayasmenu();
  }

  Future<void> deleteReport(BuildContext context, int id) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.deleteReports(id);
  }
}
