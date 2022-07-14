


import 'package:balighni/models/Incidents.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';

class IncidentsProvider with ChangeNotifier {

  Incidents _incidents =   Incidents(incident: []) ;

  final Api _api = Api() ;

  Incidents get incidents => _incidents;

  set incidents(Incidents value) {
    _incidents = value;
    notifyListeners();
  }
  Future  <void > fetchIncidents()async{

    incidents= await _api.fetechIncidents();

  }



}