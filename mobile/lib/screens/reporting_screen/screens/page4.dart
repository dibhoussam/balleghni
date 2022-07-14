import 'package:balighni/models/Incidents.dart';
import 'package:balighni/models/addr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:balighni/main.dart';
import 'package:group_button/group_button.dart';

class Page4 extends StatelessWidget {
  final Function() callbackConfirm;
  Address? addr;
  List<Incident> typeinc;
  String? description;
  int? nbrimages;
  Page4(this.callbackConfirm, this.addr, this.typeinc, this.description,
      this.nbrimages);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
      child: InkWell(
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor("#ffffff"), HexColor("#f0f5fb")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
                    child: Container(
                      ///Inner  Second Box
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor("#ffffff"), HexColor("#f0f5fb")],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 8, bottom: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              top: 8,
                                              bottom: 8,
                                              right: 16),
                                          child: Column(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "العنوان",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 24,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "الولاية",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    addr!.wilaya ?? "unknwon",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "الدائرة",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    addr!.daira ?? "unknwon",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "البلدية",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    addr?.commune ?? "unknwon",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "الشارع",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  ),
                                                  Text(
                                                    addr!.street ?? "unknwon",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "الوصف",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 24,
                                                        color: HexColor(
                                                            "#304a77")),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(description ?? "unknwon",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    indent: 16,
                                    endIndent: 16,
                                    thickness: 0.70,
                                    color: Colors.grey[400],
                                    height: 4.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: Center(
                                      child: GroupButton(
                                        options: GroupButtonOptions(
                                          alignment: Alignment.center,
                                          groupRunAlignment:
                                              GroupRunAlignment.center,
                                          direction: Axis.horizontal,
                                          crossGroupAlignment:
                                              CrossGroupAlignment.center,
                                          mainGroupAlignment:
                                              MainGroupAlignment.center,
                                          selectedTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold),
                                          selectedColor: Colors.red.shade300,
                                          selectedShadow: const [],
                                          unselectedShadow: const [],
                                          unselectedColor: HexColor("#4d7794"),
                                          unselectedTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        buttons: typeinc
                                            .map((incident) => incident.title)
                                            .toList(),
                                        onSelected: (i, selected) {},
                                        onDisablePressed: (i) {},
                                        isRadio: false,
                                      ),
                                    ),
                                  ),

                                  /*                      Text(
                                        //hotelData!.title,
                                        "Reports tu sais que j'essye mais bon quesque je pourrai faire je sais mais mais on esssye   ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              /*   Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: AppTheme.buildLightTheme()
                                .primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )*/
            ],
          ),
        ),
      ),
    );
  }
}
