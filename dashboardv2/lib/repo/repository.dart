import 'package:admin/models/Authorities.dart';
import 'package:admin/models/Incidents.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/provider/WilayasProvider.dart';
import 'package:admin/provider/incidents_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Repository {
/*#############################################################################

                          Announces Operations 

//#############################################################################*/
  Future<void> fetchAnnounces(BuildContext context) async {
    AnnouncesProvider announcesprovider = Provider.of(context, listen: false);
    await announcesprovider.fetchAnnounces();
  }

  Future<bool> addAnnounces(BuildContext context, String des, String des_fr,
      String titre, XFile img, int id) async {
    AnnouncesProvider announcesprovider = Provider.of(context, listen: false);
    return await announcesprovider.AddAnnounces(id, titre, des, des_fr, img);
  }

  Future<bool> deleteAnnounces(BuildContext context, int id) async {
    AnnouncesProvider announcesprovider = Provider.of(context, listen: false);
    return await announcesprovider.DeleteAnnounces(id);
  }

  Future<bool> editAnnounces(BuildContext context, String? des, String? titre,
      XFile? img, int id) async {
    AnnouncesProvider announcesprovider = Provider.of(context, listen: false);
    return await announcesprovider.EditAnnounces(id, titre, des, img);
  }

/*#############################################################################

                          Authoritie Operations 

//#############################################################################*/
  Future<void> fetchAuthorities(BuildContext context) async {
    AuthoritiesProvider authoritiesProvider =
        Provider.of(context, listen: false);
    await authoritiesProvider.fetchAuthorities();
  }

  Future<bool> UpdateAutoritie(BuildContext context, String? description,
      String? name, XFile? image, int id) async {
    AuthoritiesProvider reportsprovider = Provider.of(context, listen: false);
    return await reportsprovider.updateAuthoritie(id, description, name, image);
  }

  Future<bool> deleteAutoritie(BuildContext context, int id) async {
    AuthoritiesProvider reportsprovider = Provider.of(context, listen: false);
    return await reportsprovider.DeleteAuthoritie(id);
  }

  Future<bool> addAutoritie(BuildContext context, String description,
      String name, XFile image, int id, String slug) async {
    AuthoritiesProvider reportsprovider = Provider.of(context, listen: false);
    return await reportsprovider.addAuthoritie(
        id, description, name, image, slug);
  }

  /*#############################################################################

                          Incidents Operations 

    #############################################################################*/

  Future<void> fetchIncidents(BuildContext context) async {
    IncidentsProvider incidentsprovider = Provider.of(context, listen: false);
    await incidentsprovider.fetchIncidents();
  }

  Future<void> updateIncidents(BuildContext context, int id, int? authoritie_id,
      String? description, String? icon, String? slug, String? title) async {
    IncidentsProvider incidentsprovider = Provider.of(context, listen: false);
    await incidentsprovider.UpdateIncidents(
        id, authoritie_id, description, icon, slug, title);
  }

  Future<void> deleteIncidents(BuildContext context, int id) async {
    IncidentsProvider incidentsprovider = Provider.of(context, listen: false);
    await incidentsprovider.deleteIncidents(id);
  }

  Future<void> addIncidents(BuildContext context, int? authoritie_id,
      String description, XFile icon, String slug, String title) async {
    IncidentsProvider incidentsprovider = Provider.of(context, listen: false);
    await incidentsprovider.addIncidents(
        authoritie_id, description, icon, slug, title);
  }
  /*#############################################################################

                          Reports Operations 

#############################################################################*/

  Future<void> fetchReports(BuildContext context) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.fetchReports();
  }

  Future<bool> UpdateReports(
      BuildContext context, String? Commentaire, int? st, int id) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    return await reportsprovider.updateReport(id, Commentaire, st!);
  }

  Future<void> deleteReport(BuildContext context, int id) async {
    ReportsProvider reportsprovider = Provider.of(context, listen: false);
    await reportsprovider.deleteReports(id);
  }

  /*#############################################################################

                          Users Operations 

    #############################################################################*/

  Future<void> fetchUsers(BuildContext context) async {
    UsersProvider provider = Provider.of(context, listen: false);
    await provider.fetchUsers();
  }

  Future<void> logoOut(BuildContext context) async {
    UsersProvider provider = Provider.of(context, listen: false);
    await provider.logout();
  }

  Future<void> deleteUser(BuildContext context, int id) async {
    UsersProvider provider = Provider.of(context, listen: false);
    await provider.DeleteUser(id);
  }

  Future<void> editUser(BuildContext context, int id, String? username,
      String? password, String? mail, String? prenom, String? nom) async {
    UsersProvider provider = Provider.of(context, listen: false);
    await provider.EditUser(id, username, password, mail, prenom, nom);
  }

  Future<void> addUser(BuildContext context, String username, String password,
      String mail, String prenom, String nom, int Auth_id) async {
    UsersProvider provider = Provider.of(context, listen: false);

    await provider.AddUser(username, password, mail, prenom, nom, Auth_id);
  }

  /*#############################################################################

                       

    #############################################################################*/
}
