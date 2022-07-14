import 'package:balighni/models/Reports.dart';
import 'package:balighni/repo/repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../main.dart';

import 'package:group_button/group_button.dart';

class ReportListView extends StatelessWidget {
  ReportListView(
      {Key? key,
      required this.rep,
      this.animationController,
      this.animation,
      this.callback,
      this.token})
      : super(key: key);

  String? token;
  final VoidCallback? callback;
  final Report rep;
  final AnimationController? animationController;
  final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
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
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.6),
                                        offset: const Offset(0, 0),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: AspectRatio(
                                        aspectRatio: 1.2,
                                        child: CachedNetworkImage(
                                          filterQuality: FilterQuality.low,
                                          imageUrl: rep.images[0].thumbnail,
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  LiquidLinearProgressIndicator(
                                            value: progress.progress ??
                                                0.5, // Defaults to 0.5.
                                            valueColor:
                                                const AlwaysStoppedAnimation(Colors
                                                    .pink), // Defaults to the current Theme's accentColor.
                                            backgroundColor: Colors
                                                .white, // Defaults to the current Theme's backgroundColor.
                                            borderColor: Colors.red,
                                            borderWidth: 5.0,
                                            direction: Axis
                                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                            center:
                                                const Text("جاري التحميل..."),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        )

                                        /* 
                                        Image.network(
                                            rep.images[0].thumbnail,
                                            fit: BoxFit.cover) */
                                        ),
                                  ))),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10),
                            child: Container(
                              ///Inner  Second Box
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      HexColor("#ffffff"),
                                      HexColor("#f0f5fb")
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13.0)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Text(
                                                      "",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    const Text(
                                                      "",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      (rep.createdAt
                                                          .toIso8601String()
                                                          .split('T')[0]
                                                      /*(rep.createdAt.day
                                                                  .toString() +
                                                              "/" +
                                                              rep.createdAt
                                                                  .month
                                                                  .toString() +
                                                              "/" +
                                                              rep.createdAt.year
                                                                  .toString()) +
                                                          " " +
                                                          rep.createdAt.hour
                                                              .toString() +
                                                          ":" +
                                                          rep.createdAt.minute
                                                              .toString()*/
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      (rep.createdAt
                                                          .toIso8601String()
                                                          .split('.')[0]
                                                          .split('T')[1]
                                                      /*(rep.createdAt.day
                                                                  .toString() +
                                                              "/" +
                                                              rep.createdAt
                                                                  .month
                                                                  .toString() +
                                                              "/" +
                                                              rep.createdAt.year
                                                                  .toString()) +
                                                          " " +
                                                          rep.createdAt.hour
                                                              .toString() +
                                                          ":" +
                                                          rep.createdAt.minute
                                                              .toString()*/
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            top: 8,
                                                            bottom: 8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        Text(
                                                          rep.location?.commune
                                                                  ?.ar_name ??
                                                              "unknwon",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16,
                                                              color: HexColor(
                                                                  "#304a77")),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .mapMarkerAlt,
                                                              size: 12,
                                                              color: Colors
                                                                  .red.shade300,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              rep
                                                                      .location
                                                                      ?.daira
                                                                      ?.ar_name ??
                                                                  "unknwon",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: HexColor(
                                                                          "#3f81e2")
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                            Text(
                                                              " - ",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: HexColor(
                                                                          "#3f81e2")
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                            Text(
                                                              rep
                                                                      .location
                                                                      ?.wilaya
                                                                      ?.ar_name ??
                                                                  "unknwon",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: HexColor(
                                                                          "#3f81e2")
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth:
                                                                      100),
                                                          child: Text(
                                                              rep.description,
                                                              //"unknwonfdsqfndsqfdsqgsdg,sdglmdsfqdlmfdsmmfdsqmlfdsqflmdsqf,dsqfdsq,fldsqfdsml," ,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 8,
                                                                color:
                                                                    Colors.grey,
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                horizontal: 10.0),
                                            child: Center(
                                              child: GroupButton(
                                                buttons: rep.incidentTypes
                                                    .map((incident) =>
                                                        incident.title)
                                                    .toList(),
                                                selectedTextStyle:
                                                    const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                isRadio: false,
                                                selectedColor:
                                                    Colors.red.shade300,
                                                unselectedColor:
                                                    HexColor("#4d7794"),
                                                unselectedTextStyle:
                                                    const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                onSelected: (i, selected) {},
                                                onDisablePressed: (i) {},
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
                      /*Positioned(
                        top: 8,
                        left: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () async {
                              Repository repo = Repository();
                              await repo.deleteReport(context, rep.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Icon(Icons.delete,
                                      color: Colors.black)), //hna 1
                            ),
                          ),
                        ),
                      ),*/
                      if (rep.globalStatus == 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/Icon/stopwatch.png",
                                height: 40, width: 30),
                          ),
                        ),
                      if (rep.globalStatus == 1)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/Icon/reject.png",
                                height: 40, width: 30),
                          ),
                        ),
                      if (rep.globalStatus == 2)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/Icon/settings.png",
                                height: 40, width: 30),
                          ),
                        ),
                      if (rep.globalStatus == 3)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/Icon/check-mark.png",
                                height: 40, width: 30),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
