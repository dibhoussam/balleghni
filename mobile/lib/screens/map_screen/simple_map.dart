import 'dart:async';
import 'dart:developer';

import 'package:balighni/screens/detailsScreen/report_details_screen.dart';
import 'package:balighni/models/Reports.dart';
import 'package:balighni/provider/ReportsProvider.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;

  @override
  void initState() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.once;
    _centerCurrentLocationStreamController = StreamController<double?>();
    super.initState();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Position? p;
    Api api = Api();
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        // Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: FutureBuilder(
          future: api.fetechNearbyReports(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('جاري التحميل '));
            } else {
              if (snapshot.hasError) {
                return Center(
                    child: Text('GPSحدث خطأ ما  , يرجى تفعيل ال    '));
              } else {
                return Scaffold(
                  body: Center(
                    child: Consumer<ReportsProvider>(
                        builder: (_, ReportsProvider reportsprovider, __) {
                      _determinePosition();
                      return FlutterMap(
                          options: MapOptions(
                              maxZoom: 18,
                              interactiveFlags: InteractiveFlag.all,
                              plugins: [
                                const LocationMarkerPlugin(), // <-- add plugin here
                              ],
                              zoom: 16),
                          layers: [
                            TileLayerOptions(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: ['a', 'b', 'c']),
                            LocationMarkerLayerOptions(),
                            MarkerLayerOptions(
                                markers:
                                    nearByReports(snapshot.data!.data.reports)),
                          ],
                          children: [
                            LocationMarkerLayerWidget(
                              plugin: LocationMarkerPlugin(
                                centerCurrentLocationStream:
                                    _centerCurrentLocationStreamController
                                        .stream,
                                centerOnLocationUpdate: _centerOnLocationUpdate,
                              ),
                            ),
                          ]);
                    }),
                  ),
                );
              }
              ; // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          }),
    );
  }

  List<Marker> nearByReports(List<Report> reports) {
    List<Marker> tmp = [];

    for (var element in reports) {
      tmp.add(Marker(
          point: LatLng(element.latitude, element.longitude),
          builder: (context) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (_) => ReportDetailsScreen(report: element)));
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Consumer<AnnouncesProvider>(builder:
                            (_, AnnouncesProvider announcesprovider, __) {
                          return AnnouncesHomeScreen(
                              announcesprovider.announces);
                        })),
                  );*/
                },
                child: const Icon(
                  Icons.location_on_sharp,
                  color: Colors.red,
                  size: 35.0,
                ),
              )));
    }
    return tmp;
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

      /*  Fluttertoast.showToast(
          msg: "Veuillez activer  la localisation (GPS) ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0); */
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

        /*  Fluttertoast.showToast(
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
    return await Geolocator.getCurrentPosition();
  }
}
