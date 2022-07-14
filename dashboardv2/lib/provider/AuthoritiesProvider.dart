import 'package:admin/main.dart';
import 'package:admin/models/Authorities.dart';
import 'package:admin/service/Api.dart';
//import 'package:admin/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class AuthoritiesProvider with ChangeNotifier {
  Authorities _authorities = Authorities(data: []);
  final Api _api = Api();
  Authorities get authorities => _authorities;
  set authorities(Authorities value) {
    _authorities = value;
    notifyListeners();
  }

  Future<void> fetchAuthorities() async {
    authorities = await _api.fetechAuthorities();
  }

  Future<bool> updateAuthoritie(
      int id, String? description, String? name, XFile? image) async {
    if (await _api.updateAuthoritie(id, description, name, image)) {
      authorities = await _api.fetechAuthorities();
      // notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> DeleteAuthoritie(int id) async {
    bool worked = await _api.deleteAuthorities(id);
    if (worked) fetchAuthorities();
    return worked;
  }

  Future<bool> addAuthoritie(
      int id, String description, String name, XFile image, String slug) async {
    bool worked = await _api.AddAuthoritie(description, image, name, slug);
    if (worked) fetchAuthorities();
    return worked;
  }
}
