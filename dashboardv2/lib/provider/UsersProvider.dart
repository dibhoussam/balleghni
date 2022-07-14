import 'package:admin/models/User.dart';
import 'package:admin/service/Api.dart';

//import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class UsersProvider with ChangeNotifier {
  Users _users = Users(user: []);

  final Api _api = Api();

  Users get users => _users;

  set users(Users value) {
    _users = value;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    users = await _api.fetechUsers();
  }

  logout() async {
    await _api.logOut();
  }

  Future<bool> DeleteUser(int id) async {
    bool worked = await _api.deleteUser(id);
    if (worked) fetchUsers();
    return worked;
  }

  Future<bool> AddUser(String username, String password, String mail,
      String prenom, String nom, int? auth_id) async {
    int id;
    bool worked;
    if (auth_id == null) {
      worked = await _api.AddUserWilaya(username, password, mail, prenom, nom);
    } else {
      id = auth_id;
      worked = await _api.AddUserAuthoritie(
          username, password, mail, prenom, nom, id);
    }

    if (worked) fetchUsers();
    return worked;
  }

  Future<bool> EditUser(int id, String? username, String? password,
      String? mail, String? prenom, String? nom) async {
    bool worked =
        await _api.editUser(id, username, password, mail, prenom, nom);
    if (worked) fetchUsers();
    return worked;
  }
}
