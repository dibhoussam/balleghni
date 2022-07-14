import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/provider/WilayasProvider.dart';
import 'package:admin/provider/incidents_provider.dart';
import 'package:admin/screens/dashboard/dashboard_Incident_screen.dart';
import 'package:admin/screens/dashboard/dashboard_annonces_screen.dart';
import 'package:admin/screens/dashboard/dashboard_autortie_screen.dart';
import 'package:admin/screens/dashboard/dashboard_reports_screen.dart';
import 'package:admin/screens/dashboard/dashboard_users_screen.dart';
import 'package:admin/screens/dashboard/details_report_screen.dart';
import 'package:admin/screens/login_page.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance; // GetIt.I is also valid
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  serviceLocator.registerSingleton<MainScreen>(MainScreen());
  serviceLocator
      .registerSingleton<ReportsDashboardScreen>(ReportsDashboardScreen());
  serviceLocator.registerSingleton<DashboardAuthoritiesScreen>(
      DashboardAuthoritiesScreen());
  serviceLocator
      .registerSingleton<IncidentsDashboardScreen>(IncidentsDashboardScreen());
  serviceLocator
      .registerSingleton<AnnoncesDashboardScreen>(AnnoncesDashboardScreen());
  serviceLocator
      .registerSingleton<UsersDashboardScreen>(UsersDashboardScreen());
  serviceLocator.registerSingleton<DashboardScreen>(DashboardScreen());
  var _storage = await SharedPreferences.getInstance();
  await GetStorage.init();

  String? token = _storage.getString("token");
  print("token :$token" ?? "walo");
  if (token != null) {
    if (!Jwt.isExpired(token)) {
      runApp(MyApp());
    } else
      runApp(LoginPage());
  } else
    runApp(LoginPage());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProvider(create: (_) => AnnouncesProvider()),
          ChangeNotifierProvider(create: (_) => IncidentsProvider()),
          ChangeNotifierProvider(create: (_) => ReportsProvider()),
          ChangeNotifierProvider(create: (_) => AuthoritiesProvider()),
          ChangeNotifierProvider(create: (_) => WilayasmenuProvider()),
          ChangeNotifierProvider(create: (_) => UsersProvider())
        ],
        child: GetIt.instance.get<MainScreen>(),
      ),
    );
  }
}
