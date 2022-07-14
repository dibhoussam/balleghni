import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/provider/AuthoritiesProvider.dart';
import 'package:balighni/provider/ReportsProvider.dart';
import 'package:balighni/provider/WilayasProvider.dart';
import 'package:balighni/provider/incidents_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balighni/splash/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnnouncesProvider()),
        ChangeNotifierProvider(create: (_) => IncidentsProvider()),
        ChangeNotifierProvider(create: (_) => ReportsProvider()),
        ChangeNotifierProvider(create: (_) => AuthoritiesProvider()),
        ChangeNotifierProvider(create: (_) => WilayasmenuProvider()),
      ],
      child: MaterialApp(
        title: 'Ballighni',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SpalshScreen(),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
