import 'dart:developer';

import 'package:balighni/repo/repository.dart';
import 'package:balighni/screens/starter_screens/app_starter_screen.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import '../app_home_screen.dart';
import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SpalshScreen> {
  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_callApi);
  }

  _gotToNextPage() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (_) => AppHomeScreen()),
        (Route<dynamic> route) => false);
  }

  _gotToStarterPage() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (_) => AppStarterScreen()),
        (Route<dynamic> route) => false);
  }

  _callApi(_) async {
    // instantiate device info plugin
    // instantiate Android Device Information
    Api api = Api();
    DeviceInfoPlugin deviceInfo =
        DeviceInfoPlugin(); // instantiate device info plugin
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    bool firstCall = await IsFirstRun.isFirstCall();
    if (firstCall) {
      await Permission.location.request();
      await Permission.camera.request();

      int i = 0;
      while (!await api.CitoyenRegisration(
          androidDeviceInfo.id, androidDeviceInfo.id)) {
        await Future.delayed(Duration(seconds: 3));
      }
      await api.Auth();
      await repo.fetchAnnounces(context);
      await repo.fetchIncidents(context);
      await repo.fetchReports(context);
      await repo.fetchAllReports(context);
      await repo.fetchAuthorities(context);
      await repo.fetchWilayas(context);
      // await Future.delayed(Duration(seconds: 3));
      _gotToStarterPage();
    } else {
      await Permission.location.request();
      await Permission.camera.request();
      // Either the permission was already granted before or the user just granted it.
      if (await api.Auth() == false) {
        await api.CitoyenRegisration(
            androidDeviceInfo.id, androidDeviceInfo.id);
        await api.Auth();
      }
      await repo.fetchAnnounces(context);
      await repo.fetchIncidents(context);
      await repo.fetchReports(context);
      await repo.fetchAllReports(context);
      await repo.fetchAuthorities(context);
      await repo.fetchWilayas(context);
      _gotToStarterPage();

      // _gotToNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ballighni ',
        home: Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              //color: HexColor("#06ade2"),s
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/Icon/Artboard2.png",
                  ))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: HexColor("#06ade2"),s

                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        offset: const Offset(0, 2),
                        blurRadius: 20.0),
                  ],
                ),
                child: Image.asset("assets/Icon/gifv2.gif"),
                height: 50,
                width: 50,
              ),
            ],
          ),
        ));
  }
}
