import 'dart:io';
import 'package:balighni/models/Incidents.dart';
import 'package:balighni/models/addr.dart';
import 'package:balighni/provider/incidents_provider.dart';
import 'package:balighni/repo/repository.dart';
import 'package:balighni/models/Wilayas.dart';
import 'package:balighni/screens/reporting_screen/screens/page4.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balighni/screens/reporting_screen/screens/page1.dart';
import 'package:balighni/screens/reporting_screen/screens/page3.dart';
import 'package:balighni/screens/reporting_screen/widgets/progress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../app_home_screen.dart';

class LoginPage extends StatefulWidget {
  final Wilayamenu wilaya;

  LoginPage(this.wilaya);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Repository repo = Repository();
  late List<Commune> ListCommunes = [];
  late List<String> ListCommunesNames = [];
  late List<Daira> ListDairas = [];
  late List<Wilaya> Listwilaya = [];
  late XFile? myimage = null;
  late List<XFile?> myimages = [];
  late Position p;
  late String description = "", address = "";
  late int commune_id = -1, daira_id = -1, wilaya_id = -1;
  late List<int> inctype = [];
  TextEditingController descriptionController = new TextEditingController();
  late Placemark place;
  var stepperType;
  late Address addr = Address();
  int _currentStep = 0;

  confirm() async {
    context.loaderOverlay.show();
    var serv = Api();
    await serv.Auth();
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "الرجاء تفعيل ال gps  ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
//verif of permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      bool permissionbool = await Permission.location.request().isDenied;
      if (permissionbool) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "يرجى منح التصاريح اللازمة ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }
//verif of internet
    try {
      var test = await InternetAddress.lookup('www.google.com');
      if (test.isEmpty) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "لايوجد انترنت ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    } on SocketException catch (e) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "لايوجد انترنت ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (inctype.isEmpty) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "الرجاء ملئ المعلومات الناقصة  ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (myimages.isEmpty) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "   الرجاء ملئ التقاط الصور اللازمة    ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (description == "") description = "لا يوجد وصف ";

    Position pos;
    try {
      pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "   حدث مشكل أثناء التحقق من الموقع    ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    List<Placemark> loca = await placemarkFromCoordinates(
        pos.latitude, pos.longitude,
        localeIdentifier: "en");

    if (loca.isEmpty) {
      Fluttertoast.showToast(
          msg: "   حدث مشكل أثناء التحقق من الموقع    ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      context.loaderOverlay.hide();
      return;
    }
    if (loca.first.locality == null) {
      Fluttertoast.showToast(
          msg: "   حدث مشكل أثناء التحقق من الموقع يرجى اعادة المحاولة     ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      context.loaderOverlay.hide();
      return;
    }
    int i = loca.first.locality.bestMatch(ListCommunesNames).bestMatchIndex;
    if (ListCommunesNames[i].similarityTo(loca.first.locality) == 0.0) {
      Fluttertoast.showToast(
          msg: "   حدث مشكل أثناء التحقق من الموقع    ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      context.loaderOverlay.hide();
      return;
    }
    Commune c = ListCommunes.firstWhere(
        (element) => element.name == ListCommunesNames[i]);
    commune_id = c.id;
    daira_id = c.dairaId;

    wilaya_id = widget.wilaya.wilayas.firstWhere(
        (element) => element.dairas.any((element) => element.id == daira_id),
        orElse: () {
      context.loaderOverlay.hide();
      throw FlutterError("message");
    }).id;
    if (loca.first.street == "") {
      address = " غير معروف ";
    } else {
      address = loca.first.street ?? " غير معروف ";
    }
    try {
      if (!await serv.postReports(
          description,
          pos.longitude,
          pos.latitude,
          commune_id,
          daira_id,
          wilaya_id,
          address,
          myimages.map((item) => item!.path).toList(),
          inctype)) {
        context.loaderOverlay.hide();
        Fluttertoast.showToast(
            msg: "يرجى اعادة المحاولة ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      Fluttertoast.showToast(
          msg: "تم الارسال بنجاح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      context.loaderOverlay.hide();
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (_) => AppHomeScreen()));
      repo.fetchReports(context);
      context.loaderOverlay.hide();
    } catch (e) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
          msg: "يرجى اعادة المحاولة ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    context.loaderOverlay.hide();
  }

  callbackListImage(newAbc) {
    if (myimages.length >= 3) {
      Fluttertoast.showToast(
          msg: "nombre de photo limite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        myimages.add(newAbc);
      });
    }
  }

  callbackDeleteImage(newAbc) {
    if (myimages.isNotEmpty) {
      setState(() {
        myimages.removeWhere((element) => element!.path == newAbc);
      });
    }
  }

  callbackListDaira(newAbc) {
    setState(() {
      ListDairas = newAbc;
    });
  }

  callbackListwilaya(newAbc) {
    setState(() {
      Listwilaya = newAbc;
    });
  }

  callbackListCommunes(newAbc) {
    setState(() {
      ListCommunes = newAbc;
    });
  }

  callbackImage(newAbc) {
    setState(() {
      myimage = newAbc;
    });
  }

  callbackCommune(newAbc) {
    setState(() {
      commune_id = newAbc;
    });
  }

  callbackDaira(newAbc) {
    setState(() {
      daira_id = newAbc;
    });
  }

  callbackWilaya(newAbc) {
    setState(() {
      wilaya_id = newAbc;
    });
  }

  callbackIncTypes(newAbc) {
    setState(() {
      inctype.clear();
      inctype.add(int.parse(newAbc));
    });
  }

  callbackDescription(newAbc) {
    setState(() {
      description = newAbc;
    });
  }

  callbackAddress(newAbc) {
    setState(() {
      address = newAbc;
    });
  }

  late PFormController pformController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.wilaya.wilayas.isEmpty) {
      Repository rep = Repository();
      rep.fetchIncidents(context);
      rep.fetchWilayas(context);
    }
    for (var w in widget.wilaya.wilayas) {
// for each wilaya
      for (var d in w.dairas) {
        ListCommunes.addAll(d.communes);
        for (var c in d.communes) {
          ListCommunesNames.add(c.name);
        }
      }
    }
    pformController = PFormController(3);
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.fill,
            //image: Svg("assets/Icon/95300.svg", source: SvgSource.asset)),
            image: AssetImage("assets/Icon/Artboard1.png")),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(25.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
                child: GestureDetector(
                  /* onTap: () => Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (_) => AppHomeScreen())),*/
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFFFFFF),
                        semanticLabel: 'Return',
                      )),
                )),
            const Expanded(
              child: Center(
                child: Text(
                  'تبلــيغ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Wessam',
                      fontWeight: FontWeight.normal,
                      fontSize: 38,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      try {
        _determinePosition().then((value) => {
              setState(() {
                p = value;
                print(p.toString());
              }),
              placemarkFromCoordinates(p.latitude, p.longitude,
                      localeIdentifier: "ar-DZ")
                  .then((k) => setState(() {
                        if (k.isNotEmpty) {
                          place = k.first;
                          addr = Address(
                              commune: place.locality,
                              daira: place.subAdministrativeArea,
                              street: place.street,
                              wilaya: place.administrativeArea);
                        }
                      }))
            });
      } catch (e) {}

      return WillPopScope(
        onWillPop: () async {
          context.loaderOverlay.hide();
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onVerticalDragDown: (DragDownDetails) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              child: Column(
                children: [
                  getAppBarUI(),
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                          accentColor: const Color(0xff06ade2),
                          primarySwatch: Colors.lightBlue,
                          colorScheme: const ColorScheme.light(
                              primary: const Color(0xff06ade2))),
                      child: LoaderOverlay(
                        disableBackButton: false,
                        useDefaultLoading: false,
                        overlayWidget:
                            Center(child: Image.asset("assets/oleg.gif")),
                        child: Stepper(
                          type: StepperType.horizontal,
                          physics: const ScrollPhysics(),
                          currentStep: _currentStep,
                          onStepTapped: (step) => tapped(step),
                          onStepContinue: continued,
                          onStepCancel: cancel,
                          steps: <Step>[
                            Step(
                              title: new Text(""),
                              content: Page3(
                                  callbackListImage,
                                  myimages.map((item) => item!.path).toList(),
                                  callbackDeleteImage),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: new Text(""),
                              content:
                                  Page1(callbackIncTypes, callbackDescription),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            /*Step(
                                title: new Text(""),
                                content: Page2(
                                    callbackListDaira,
                                    callbackListCommunes,
                                    callbackDaira,
                                    callbackCommune,
                                    callbackWilaya,
                                    ListCommunes,
                                    ListDairas,
                                    Listwilaya,
                                    callbackAddress),
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 2
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),*/
                            Step(
                              title: new Text(""),
                              content: Consumer<IncidentsProvider>(builder:
                                  (_, IncidentsProvider incidentsprovider, __) {
                                List<Incident> list = [];

                                for (var element in inctype) {
                                  list.add(incidentsprovider.incidents.incident
                                      .firstWhere(
                                          (value) => value.id == element));
                                }
                                return Page4(confirm, addr, list, description,
                                    myimages.length);
                              }),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
                            )
                          ],
                          controlsBuilder: (context, details) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  if (_currentStep != 0)
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 33, 172, 211)),
                                          color: const Color.fromARGB(
                                              255, 33, 172, 211),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      //   color: Colors.red,
                                      child: TextButton(
                                        onPressed: details.onStepCancel,
                                        child: const Text(
                                          "رجوع",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (_currentStep != 2)
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 33, 172, 211)),
                                          color: const Color(0xff11aad4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      //   color: Colors.red,
                                      child: TextButton(
                                        onPressed: details.onStepContinue,
                                        child: const Text(
                                          "التالي",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ))
                                  else
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 33, 172, 211)),
                                          color: const Color(0xff11aad4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      //   color: Colors.red,
                                      child: TextButton(
                                        onPressed: confirm,
                                        child: const Text(
                                          "ارسال التقرير ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),

                                  /* CupertinoButton(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.zero,
                                          child: Text(
                                            "Back",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: details.onStepCancel),*/
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      /*Fluttertoast.showToast(
          msg: "Veuillez activer  la localisation (GPS) ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);*/
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        /*Fluttertoast.showToast(
            msg: "Veuillez Autorisez la localisation  ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);*/
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
