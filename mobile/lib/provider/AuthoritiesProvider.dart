import 'package:balighni/models/Authorities.dart';
import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';

class AuthoritiesProvider with ChangeNotifier {
  Authorities _authorities = Authorities(data: DataAuthoritie(authoritie: []));

  final Api _api = Api();

  Authorities get authorities => _authorities;

  set authorities(Authorities value) {
    _authorities = value;
    notifyListeners();
  }

  Future<void> fetchAuthorities() async {
    authorities = await _api.fetechAuthorities();
  }

  Future<void> fetchMore(String page) async {
    //List<Report> l=[];
    //l.addAll(reports.data.reports);

    Authorities rep = await _api.LoadMoreAuthorities(page);

    /// fix the authorities MODEL
    authorities.data.nextPageUrl = rep.data.nextPageUrl;
    authorities.data.authoritie.addAll(rep.data.authoritie);
    notifyListeners();
  }
}
