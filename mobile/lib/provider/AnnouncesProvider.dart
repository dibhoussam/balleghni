import 'package:balighni/models/Announces.dart';

import 'package:balighni/service/Api.dart';
import 'package:flutter/cupertino.dart';



class AnnouncesProvider with ChangeNotifier {

  Announces _announces = Announces(data:DataAnnounces(announces: [])) ;

  final Api _api = Api() ;

  Announces get announces => _announces;

  set announces(Announces value) {
    _announces = value;
    notifyListeners();
  }
Future  <void > fetchAnnounces()async{

  announces= await _api.fetechAnnounces();

}



  Future  <void > fetchMore(String page )async{
    //List<Report> l=[];
    //l.addAll(reports.data.reports);

    Announces rep = await _api.LoadMoreAnnounces(page);

    /// fix the ANNOUNCES MODEL
    /// announces.data.nextPageUrl=rep.data.nextPageUrl;
    ///  announces.data.reports.addAll(rep.data.reports);
    notifyListeners();
    //reports=rep;
    //rep.data.reports.addAll(l);

  }






}