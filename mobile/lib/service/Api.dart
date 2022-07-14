import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:balighni/config/config.dart';
import 'package:balighni/models/Authorities.dart';
import 'package:balighni/models/Incidents.dart';
import 'package:balighni/models/Reports.dart';
import 'package:balighni/models/Wilayas.dart';
import 'package:balighni/models/upload_reponse.dart';
import 'package:balighni/models/Announces.dart';
import 'package:device_info/device_info.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:is_first_run/is_first_run.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  //String baseurl = "http://${Golb_Config.Ip}:${Golb_Config.Port}/";
  String baseurl = "http://41.111.148.170:8081/";
  //String baseurl = "http://192.168.43.17:8081/";

  final http.Client _client = http.Client();
  final _storage = const FlutterSecureStorage();

  /// api GET /announces
  Future<Announces> fetechAnnounces() async {
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "announces");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error
      return Announces(data: DataAnnounces(announces: []));
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Announces.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Announces(data: DataAnnounces(announces: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Announces.fromJson(data);
        }
      }
      return Announces(data: DataAnnounces(announces: []));
    }
  }

  /// Api call POST /reports
  Future<bool> postReports(
      String description,
      double longitude,
      double latitude,
      int commune_id,
      int daira_id,
      int wilaya_id,
      String address,
      List<String> img,
      List<int> inctype) async {
    await Auth();

    String? token = await _storage.read(key: "token");
    //ImageUpload tmp = await UploadImage( img.path );
    List<ImageUpload> tmp = [];
    ImageUpload x;
    for (var element in img) {
      try {
        x = await UploadImage(element);
        tmp.add(x);
      } catch (e) {
        throw Exception("error");
      }
    }
    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "reports");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'description': description,
          'longitude': longitude,
          'latitude': latitude,
          'commune_id': commune_id,
          'daira_id': daira_id,
          'wilaya_id': wilaya_id,
          'address': address,
          'images': tmp,
          'incident_types': inctype
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      return true;
    } else {
      if (reponse.statusCode == 401) {
        //Retry

        await Auth();
        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({
              'description': description,
              'longitude': longitude,
              'latitude': latitude,
              'commune_id': commune_id,
              'daira_id': daira_id,
              'wilaya_id': wilaya_id,
              'address': address,
              'images': json,
              'incident_types': inctype
            }),
          );

          if (reponse.statusCode == 200) {
            return true;
          }
        } on SocketException {
          return false;
        }
      } else {
        throw Error();
      }
      return false;
    }
  }

// POST /user/citoyen
  Future<bool> CitoyenRegisration(String username, String password) async {
    Uri url2 = Uri.parse(baseurl + "users/auth");
    http.Response reponseauth;
    try {
      /// Calling the Api
      reponseauth = await _client.post(
        url2,
        body: {
          'username': "citoyen-creator",
          // 'username': androidDeviceInfo.id,
          'password': "citoyen-creator"
          // 'password': androidDeviceInfo.id
        },
      );
    } on SocketException {
      ///Error
      await IsFirstRun.reset();
      return false;
    }
    if (reponseauth.statusCode != 200) {
      await IsFirstRun.reset();
      return false;
    }
    var data;
    data = json.decode(reponseauth.body);
    // registre request
    Uri url = Uri.parse(baseurl + "users/citoyen");
    http.Response reponse;
    try {
      String tmp = "Bearer " + data["access_token"];
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$tmp'
        },
        body: jsonEncode({
          'username': username,
          'attributes': {"citoyen": true},
          'enabled': true,
          'credentials': [
            {"type": "password", "value": password, "temporary": false}
          ],
          'realmRoles': ["citoyen"],
          "groups": ["citoyen"]
        }),
      );
    } on SocketException {
      ///Error
      await IsFirstRun.reset();
      return false;
    }

    if (reponse.statusCode == 200) {
      //  var data = json.decode(reponse.body);
      return true;
    } else {
      await IsFirstRun.reset();
      return false;
    }
  }

  /// Api call post  Authentification
  Future<bool> Auth() async {
    DeviceInfoPlugin deviceInfo =
        DeviceInfoPlugin(); // instantiate device info plugin
    AndroidDeviceInfo androidDeviceInfo =
        await deviceInfo.androidInfo; // instantiate Android Device Information
    Uri url = Uri.parse(baseurl + "users/auth");
    http.Response reponse;

    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        body: {
          //'username': "default-citoyen",
          'username': androidDeviceInfo.id,
          //'password': "default-citoyen"
          'password': androidDeviceInfo.id
        },
      );
    } on SocketException {
      ///Error

      return false;
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      _storage.write(key: "token", value: data["access_token"]);
      _storage.write(key: "refresh_token", value: data["refresh_token"]);
      //print(reponse.body);
      return true;
    } else {
      if (reponse.statusCode == 500) {
        //      CitoyenRegisration(androidDeviceInfo.id, androidDeviceInfo.id);
        return false;
      }
      // await IsFirstRun.reset();
    }
    return false;
  }

  /// Api call GET /incidents
  Future<Incidents> fetechIncidents() async {
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "incidents");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Incidents(incident: []);
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      return Incidents.fromJson(data);
      //return Incidents( incident: []) ;

    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");

        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Incidents(incident: []);
        }

        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body)["data"];

          ///return Incidents.fromJson(data["data"]);
          return Incidents.fromJson(data);
        }
      }

      return Incidents(incident: []);
    }
  }

  /// Api call GET /incidents
  Future<Wilayamenu> fetechWilayas() async {
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "wilayas");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Wilayamenu(wilayas: []);
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      return Wilayamenu.fromJson(data);
      //return Incidents( incident: []) ;

    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");

        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Wilayamenu(wilayas: []);
        }

        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body)["data"];

          ///return Incidents.fromJson(data["data"]);
          return Wilayamenu.fromJson(data);
        }
      }

      return Wilayamenu(wilayas: []);
    }
  }

  ///  GET /Reports
  Future<Reports> fetechReports() async {
    http.Response reponse;
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "reports");
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Reports(data: Data(reports: []));
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Reports.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Reports(data: Data(reports: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Reports.fromJson(data);
        }
      }
      return Reports(data: Data(reports: []));
    }
  }

  /// API CAll POST MULTIPART /image
  Future<ImageUpload> UploadImage(String path) async {
    ///for multipartrequest
    String s = baseurl + "images";
    String? token = await _storage.read(key: "token");

    var request = http.MultipartRequest('POST', Uri.parse(s));

    ///for token
    request.headers.addAll({"Authorization": "Bearer $token"});

    ///for image and videos and files
    request.files.add(await http.MultipartFile.fromPath("file", path));

    //for completeing the request
    var response;
    try {
      response =
          await request.send().timeout(Duration(seconds: 360), onTimeout: () {
        throw "TimeOut";
      });
    } catch (e) {
      throw SocketException("error");
    }

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return ImageUpload.fromJson(responseData);
    } else {
      throw Exception("error");
      //return ImageUpload(status: "error");
    }
  }

  /// GET authorities
  Future<Authorities> fetechAuthorities() async {
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "authorities");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Authorities(data: DataAuthoritie(authoritie: []));
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      // print(data.toString());
      return Authorities.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Authorities(data: DataAuthoritie(authoritie: []));
        }

        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Authorities.fromJson(data);
        }
      }

      return Authorities(data: DataAuthoritie(authoritie: []));
    }
  }

  ///  Load More Reports Get /Reports
  Future<Reports> LoadMoreReports(String page) async {
    String? token = await _storage.read(key: "token");
    page = page.replaceAll("core/api", "41.111.148.170:8081");
    Uri url = Uri.parse(page);
    http.Response reponse;

    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Reports(data: Data(reports: []));
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      //print(data.toString());
      return Reports.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Reports(data: Data(reports: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Reports.fromJson(data);
        }
      }

      return Reports(data: Data(reports: []));
    }
  }

  ///  Load More Authorities Get /Authorities
  Future<Authorities> LoadMoreAuthorities(String page) async {
    String? token = await _storage.read(key: "token");
    //if (page !=2) return  Reports( data: Data(reports:[] ));
    // Uri url =Uri.parse(baseurl+"reports?page=$page");
    page = page.replaceAll("core/api", "41.111.148.170:8081");

    Uri url = Uri.parse(page);
    http.Response reponse;

    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Authorities(data: DataAuthoritie(authoritie: []));
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      //print(data.toString());
      return Authorities.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Authorities(data: DataAuthoritie(authoritie: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Authorities.fromJson(data);
        }
      }

      return Authorities(data: DataAuthoritie(authoritie: []));
    }
  }

  ///  Load More Announces Get /Announces
  Future<Announces> LoadMoreAnnounces(String page) async {
    String? token = await _storage.read(key: "token");
    page = page.replaceAll("core/api", "41.111.148.170:8081");

    //if (page !=2) return  Reports( data: Data(reports:[] ));
    // Uri url =Uri.parse(baseurl+"reports?page=$page");
    Uri url = Uri.parse(page);
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Announces(data: DataAnnounces(announces: []));
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      //print(data.toString());
      return Announces.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Announces(data: DataAnnounces(announces: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Announces.fromJson(data);
        }
      }

      return Announces(data: DataAnnounces(announces: []));
    }
  }

// nearby Reports
  Future<Reports> fetechNearbyReports() async {
    Position p = await _determinePosition();
    double latitude = p.latitude;
    double longitude = p.longitude;
    http.Response reponse;
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "reports/nearby");

    try {
      /// Calling the Api
      /*reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });*/
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'longitude': longitude,
          'latitude': latitude,
        }),
      );
    } on SocketException {
      ///Error

      return Reports(data: Data(reports: []));
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      List<Report> l =
          List<Report>.from(data["data"].map((x) => Report.fromJson(x)));
      return Reports(data: Data(reports: l));
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({
              'longitude': longitude,
              'latitude': latitude,
            }),
          );
        } on SocketException {
          ///Error

          return Reports(data: Data(reports: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);

          List<Report> l =
              List<Report>.from(data["data"].map((x) => Report.fromJson(x)));
          return Reports(data: Data(reports: l));
        }
      }
      return Reports(data: Data(reports: []));
    }
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

//fetech all reports
  Future<Reports> fetechAllReports() async {
    http.Response reponse;
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "reports/all");
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error

      return Reports(data: Data(reports: []));
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Reports.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error

          return Reports(data: Data(reports: []));
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Reports.fromJson(data);
        }
      }
      return Reports(data: Data(reports: []));
    }
  }

  Future<bool> DeleteReport(int id) async {
    String? token = await _storage.read(key: "token");
    Uri url = Uri.parse(baseurl + "reports/" + "$id");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
    } on SocketException {
      ///Error
      return false;
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);


    if(data.containsKey("error_log") ) 
      if(data["error_log"].containsKey("http_status_code")) {
        if (data["error_log"]["http_status_code"] == 204) {
        return true;
      }
      }

      //return Incidents( incident: []) ;
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = await _storage.read(key: "token");
        try {
          /// Calling the Api
          reponse = await _client.delete(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          });
        } on SocketException {
          ///Error
          return false;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body)["data"];
           if(data.containsKey("error_log") ) 
      if(data["error_log"].containsKey("http_status_code")) {
        if (data["error_log"]["http_status_code"] == 204) {
        return true;
      }
      }

          ///return Incidents.fromJson(data["data"]);
          return true;
        }
      }
      return false;
    } return false;
  }
}
