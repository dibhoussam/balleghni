import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/Branchs.dart';
import 'package:admin/models/User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:io';
import 'package:admin/models/Authorities.dart';
import 'package:admin/models/Incidents.dart';
import 'package:admin/models/Reports.dart';
import 'package:admin/models/Wilayas.dart';
import 'package:admin/models/upload_reponse.dart';
import 'package:admin/models/Announces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart' as str;
import 'package:dio/dio.dart';

//import 'package:is_first_run/is_first_run.dart';//
class Api {
  //String baseurl = "http://${Golb_Config.Ip}:${Golb_Config.Port}/";
  String baseurl = "http://41.111.148.170:8081/";
  //String baseurl = "http://192.168.43.17:8081/";
  String acces = "";
  final box = str.GetStorage();

  final http.Client _client = http.Client();
  // late var  _storage  = await SharedPreferences.getInstance(); //const FlutterSecureStorage();
  //var _storage = null;

  /// api GET /announces
  ///
  /// branchs/all
  /// announces/all
/*#############################################################################

                          Announces Operations 

//#############################################################################*/
  Future<Announces> fetechAnnounces() async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "announces/all");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error
      return Announces(data: []);
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Announces.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Announces(data: []);
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Announces.fromJson(data);
        }
      }
      return Announces(data: []);
    }
  }

  Future<bool> AddAnnounce(int auth_id, String description, String des_fr,
      XFile img, String titre) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    //ImageUpload tmp = await UploadImage( img.path );

    ImageUpload x;

    try {
      x = await UploadImage(img);
    } catch (e) {
      throw Exception("error");
    }
    print(x.url);
    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "announces");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'description': description,
          'title': titre,
          'authoritie_id': auth_id,
          'file': x.url,
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        //Retry

        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
              'Pragma': 'no-cache',
              'Expires': '0',
            },
            body: jsonEncode({
              'description': description,
              'title': titre,
              'authoritie': auth_id,
              'file': x.url,
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

  deleteAnnounce(int id) {}

  editAnnounce(int id, String? titre, String? des, XFile? img) {}

/*#############################################################################

                          Branchs Operations 

//#############################################################################*/
  Future<Branchs> fetechBranchs() async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "branchs/all");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error
      return Branchs(branch: []);
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Branchs.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Branchs(branch: []);
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Branchs.fromJson(data);
        }
      }
      return Branchs(branch: []);
    }
  }

// POST /user/citoyen
  Future<bool> CitoyenRegisration(String username, String password) async {
    var _storage = await SharedPreferences.getInstance();

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
      return false;
    }
    if (reponseauth.statusCode != 200) {
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
      return false;
    }

    if (reponse.statusCode == 200) {
      //  var data = json.decode(reponse.body);
      return true;
    } else {
      return false;
    }
  }

  /// Api call post  Authentification
  /*#############################################################################

                          Users Operations 

//#############################################################################*/
  Future<bool> Auth() async {
    Uri url = Uri.parse(baseurl + "users/auth");
    http.Response reponse;
    var _storage = await SharedPreferences.getInstance();
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        body: {
          //'username': "default-citoyen",
          'username': "wilaya-16-admin",
          //'password': "default-citoyen"
          'password': "wilaya-16-admin"
        },
      );
    } on SocketException {
      ///Error

      return false;
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      _storage.setString("token", data["access_token"]);
      //_storage.write(key: "refresh_token", value: data["refresh_token"]);*/
      acces = data["access_token"];
      //print(reponse.body);

      Map<String, dynamic> payload = Jwt.parseJwt(acces);
      if (payload.containsKey("authoritie"))
        _storage.setString("authoritie", payload["authoritie"]);
      else if (payload.containsKey("wilaya"))
        _storage.setString("authoritie", payload["wilaya"]);
      else if (payload.containsKey("superadmin"))
        _storage.setString("superadmin", "0");

      print(payload);

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

  Future<bool> Auth2(String username, String password) async {
    Uri url = Uri.parse(baseurl + "users/auth");
    http.Response reponse;
    var _storage = await SharedPreferences.getInstance();
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        body: {
          //'username': "default-citoyen",
          'username': username,
          //'password': "default-citoyen"
          'password': password
        },
      );
    } on SocketException {
      ///Error

      return false;
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      _storage.setString("token", data["access_token"]);
      //_storage.write(key: "refresh_token", value: data["refresh_token"]);*/
      acces = data["access_token"];
      //print(reponse.body);

      Map<String, dynamic> payload = Jwt.parseJwt(acces);

      if (payload.containsKey("name")) box.write("name", payload["name"]);
      if (payload.containsKey("authoritie"))
        box.write("authoritie", payload["authoritie"]);
      else if (payload.containsKey("wilaya"))
        box.write("authoritie", payload["wilaya"]);
      else if (payload.containsKey("superadmin")) box.write("superadmin", "0");

      print(payload);

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

  Future<Users> fetechUsers() async {
    var _storage = await SharedPreferences.getInstance();

    http.Response reponse;
    String? token = _storage.getString("token");
    Uri url = Uri.parse(
        baseurl + "users/wilaya/" + (_storage.getString("authoritie") ?? ""));
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error

      return Users(user: []);
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Users.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Users(user: []);
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Users.fromJson(data);
        }
      }
      return Users(user: []);
    }
  }

  Future<void> logOut() async {
    var _storage = await SharedPreferences.getInstance();
    _storage.clear();
  }

  Future<bool> AddUserWilaya(String username, String password, String mail,
      String prenom, String nom) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    //ImageUpload tmp = await UploadImage( img.path );

    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "users/wilaya");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "username": username,
          "email": mail,
          "attributes": {"wilaya": int.parse(box.read("authoritie"))},
          "firstName": prenom,
          "lastName": nom,
          "enabled": true,
          "credentials": [
            {"id": 1, "type": "password", "value": password, "temporary": false}
          ],
          "realmRoles": ["admin"],
          "groups": ["wilaya-admin"] //["authoritie-admin"]
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        //Retry

        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
              'Pragma': 'no-cache',
              'Expires': '0',
            },
            body: jsonEncode({
              "username": username,
              "email": mail,
              "attributes": {"wilaya": int.parse(box.read("authoritie"))},
              "firstName": prenom,
              "lastName": nom,
              "enabled": true,
              "credentials": [
                {
                  "id": 1,
                  "type": "password",
                  "value": password,
                  "temporary": false
                }
              ],
              "realmRoles": ["admin"],
              "groups": ["wilaya-admin"] //["authoritie-admin"]
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

  Future<bool> AddUserAuthoritie(String username, String password, String mail,
      String prenom, String nom, int Auth_id) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    //ImageUpload tmp = await UploadImage( img.path );
    int i = int.parse(box.read("authoritie"));
    if (i < 100) i = Auth_id;
    ImageUpload x;

    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "/users/authoritie");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "username": username,
          "email": mail,
          "attributes": {"authoritie": i},
          "firstName": prenom,
          "lastName": nom,
          "enabled": true,
          "credentials": [
            {"id": 1, "type": "password", "value": password, "temporary": false}
          ],
          "realmRoles": ["admin"],
          "groups": ["authoritie-admin"]
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        //Retry

        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
              'Pragma': 'no-cache',
              'Expires': '0',
            },
            body: jsonEncode({
              "username": username,
              "email": mail,
              "attributes": {"authoritie": i},
              "firstName": prenom,
              "lastName": nom,
              "enabled": true,
              "credentials": [
                {
                  "id": 1,
                  "type": "password",
                  "value": password,
                  "temporary": false
                }
              ],
              "realmRoles": ["admin"],
              "groups": ["authoritie-admin"] //["authoritie-admin"]
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

  deleteUser(int id) {}

  editUser(int id, String? username, String? password, String? mail,
      String? prenom, String? nom) {}

  /// Api call GET /incidents
  /*#############################################################################

                          Incidents Operations 

//#############################################################################*/
  Future<Incidents> fetechIncidents() async {
    var _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "incidents");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
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
        String? token = _storage.getString("token");

        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
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

  Future<bool> AddIncident(int auth_id, String description, XFile icon,
      String titre, String slug) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    //ImageUpload tmp = await UploadImage( img.path );

    ImageUpload x;

    try {
      x = await UploadImage(icon);
    } catch (e) {
      throw Exception("error");
    }
    print(x.url);
    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "incidents");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'slug': slug,
          'title': titre,
          'authoritie_id': auth_id,
          'description': description,
          'icon': x.url
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        //Retry

        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
              'Pragma': 'no-cache',
              'Expires': '0',
            },
            body: jsonEncode({
              'slug': slug,
              'title': titre,
              'authoritie_id': auth_id,
              'description': description,
              'icon': x.url
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

  updateIncidents(
      int id, String? description, String? icon, String? slug, String? title) {}

  deleteIncident(int id) {}

  /// Api call GET /incidents

  ///  GET /Reports
  /*#############################################################################

                          Reports Operations 

//#############################################################################*/
  Future<Reports> fetechReports() async {
    await Auth();
    http.Response reponse;
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");

    Uri url = Uri.parse(baseurl + "reports/nopag");
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error

      return Reports(data: []);
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      //print("la :" + data["data"]);
      log(reponse.body);

      return Reports.fromJson(data["data"]);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        //String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Reports(data: []);
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          print("la :" + data["data"]);
          return Reports.fromJson(data["data"]);
        }
      }
      return Reports(data: []);
    }
  }

  Future<Reports> fetechAllReports() async {
    var _storage = await SharedPreferences.getInstance();

    http.Response reponse;
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "reports/all");
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error

      return Reports(data: []);
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Reports.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Reports(data: []);
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Reports.fromJson(data);
        }
      }
      return Reports(data: []);
    }
  }

  Future<bool> DeleteReport(int id) async {
    var _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "reports/" + "$id");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error
      return false;
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      if (data.containsKey("error_log")) if (data["error_log"]
          .containsKey("http_status_code")) {
        if (data["error_log"]["http_status_code"] == 204) {
          return true;
        }
      }

      //return Incidents( incident: []) ;
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.delete(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error
          return false;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body)["data"];
          if (data.containsKey("error_log")) if (data["error_log"]
              .containsKey("http_status_code")) {
            if (data["error_log"]["http_status_code"] == 204) {
              return true;
            }
          }

          ///return Incidents.fromJson(data["data"]);
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<bool> updateReport(int id, String? commentaire, int? st) async {
    var _storage = await SharedPreferences.getInstance();
    http.Response reponse;
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "reports/$id");
    var jsonMap;
    if (commentaire != null && st != null)
      jsonMap = {
        'global_status': st,
        'comment': commentaire,
      };

    if (commentaire != null && st == null)
      jsonMap = {
        'comment': commentaire,
      };

    if (commentaire == null && st != null)
      jsonMap = {
        'global_status': st,
      };
    if (commentaire == null && st == null) return false;

    try {
      /// Calling the Api
      reponse = await _client
          .put(url, body: jsonEncode(jsonMap), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
    } on SocketException {
      ///Error

      return false;
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return true;
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse =
              await _client.put(url, body: jsonMap, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        } on SocketException {
          ///Error

          return false;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return true;
        }
      }
      return false;
    }
  }

  /*#############################################################################

                          Utils Operations 

//#############################################################################*/
  /// API CAll POST MULTIPART /image
  Future<ImageUpload> UploadImage(XFile path) async {
    var _storage = await SharedPreferences.getInstance();
    String s = baseurl + "images";
    String? token = await _storage.getString("token");

    var request = http.MultipartRequest('POST', Uri.parse(s));

    ///for token
    request.headers.addAll({"Authorization": "Bearer $token"});

    ///for image and videos and files
    request.files.add(await http.MultipartFile.fromBytes(
        "file", await path.readAsBytes(),
        filename: path.name));

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

  Future<Wilayamenu> fetechWilayas() async {
    var _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "wilayas");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
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
        String? token = _storage.getString("token");

        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
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

  /// GET authorities
  /*#############################################################################

                           Authorities Operations 

//#############################################################################*/
  Future<Authorities> fetechAuthorities() async {
    var _storage = await SharedPreferences.getInstance();

    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "authorities/all");
    http.Response reponse;

    try {
      /// Calling the Api

      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
      });
    } on SocketException {
      ///Error

      return Authorities(data: []);
    }

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);
      // print(data.toString());
      return Authorities.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api

          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error

          return Authorities(data: []);
        }

        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Authorities.fromJson(data);
        }
      }

      return Authorities(data: []);
    }
  }

  Future<bool> updateAuthoritie(
      int id, String? description, String? name, XFile? image) async {
    var _storage = await SharedPreferences.getInstance();
    http.Response reponse;
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "authorities/$id");
    //Map jsonMap = Map();
    ImageUpload? im;
    if (image != null)
      im = await UploadImage(image);
    else
      im = null;
//Map<String, dynamic> jsonMap = Map();
    var lastjsonMap = {};

    if (description != null) lastjsonMap.addAll({"description": description});
    if (name != null) lastjsonMap.addAll({"name": name});
    if (image != null) lastjsonMap.addAll({"logo": im!.url});
    if (description == null && name == null && image == null) return false;
    print(jsonEncode(lastjsonMap));
    try {
      /// Calling the Api
      reponse = await _client
          .put(url, body: jsonEncode(lastjsonMap), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
    } on SocketException {
      ///Error

      return false;
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      var data = json.decode(reponse.body);

      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.put(url,
              body: jsonEncode(lastjsonMap),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              });
        } on SocketException {
          ///Error

          return false;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return true;
        }
      }
      return false;
    }
  }

  Future<bool> AddAuthoritie(
      String description, XFile logo, String name, String slug) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    //ImageUpload tmp = await UploadImage( img.path );

    ImageUpload x;

    try {
      x = await UploadImage(logo);
    } catch (e) {
      throw Exception("error");
    }
    print(x.url);
    //print("len : " + tmp.length.toString());
    //var json = jsonEncode(tmp);
    Uri url = Uri.parse(baseurl + "incidents");
    //Uri url =Uri.parse("http://kda.requestcatcher.com/test");

    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'slug': slug,
          'name': name,
          'description': description,
          'logo': x.url
        }),
      );
    } on SocketException {
      ///Error
      ///
      ///
      throw SocketException("eroor");
    }
    if (reponse.statusCode == 200) {
      print(reponse.body);
      return true;
    } else {
      print(reponse.body);
      if (reponse.statusCode == 401) {
        //Retry

        try {
          /// Calling the Api
          reponse = await _client.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
              'Cache-Control': 'no-cache',
              'Pragma': 'no-cache',
              'Expires': '0',
            },
            body: jsonEncode({
              'slug': slug,
              'name': name,
              'description': description,
              'logo': x.url
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

  Future<bool> deleteAuthorities(int id) async {
    var _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "authorities/" + "$id");
    http.Response reponse;
    try {
      /// Calling the Api
      reponse = await _client.delete(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
    } on SocketException {
      ///Error
      return false;
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      if (data.containsKey("error_log")) if (data["error_log"]
          .containsKey("http_status_code")) {
        if (data["error_log"]["http_status_code"] == 204) {
          return true;
        }
      }

      //return Incidents( incident: []) ;
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.delete(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          });
        } on SocketException {
          ///Error
          return false;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body)["data"];
          if (data.containsKey("error_log")) if (data["error_log"]
              .containsKey("http_status_code")) {
            if (data["error_log"]["http_status_code"] == 204) {
              return true;
            }
          }

          ///return Incidents.fromJson(data["data"]);
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<Authoritie?> fetechAutorite(int id) async {
    var _storage = await SharedPreferences.getInstance();

    http.Response reponse;
    String? token = _storage.getString("token");
    Uri url = Uri.parse(baseurl + "authoritie/$id");
    try {
      /// Calling the Api
      reponse = await _client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
    } on SocketException {
      ///Error

      return null;
    }
    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      return Authoritie.fromJson(data);
    } else {
      if (reponse.statusCode == 401) {
        await Auth();
        String? token = _storage.getString("token");
        try {
          /// Calling the Api
          reponse = await _client.get(url, headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        } on SocketException {
          ///Error

          return null;
        }
        if (reponse.statusCode == 200) {
          var data = json.decode(reponse.body);
          return Authoritie.fromJson(data);
        }
      }
      return null;
    }
  }

  /*#############################################################################

                        

//#############################################################################*/

}
