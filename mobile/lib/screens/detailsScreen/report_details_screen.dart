import 'dart:developer';

import 'package:balighni/models/Reports.dart';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:group_button/group_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../app_home_screen.dart';
import '../../main.dart';

//listOfDownloadedFile.where((element) => element.Url == "your URL link")
class ReportDetailsScreen extends StatefulWidget {
  const ReportDetailsScreen({Key? key, required this.report}) : super(key: key);

  final Report report;

  @override
  _ReportDetailsScreen createState() => _ReportDetailsScreen();
}

class _ReportDetailsScreen extends State<ReportDetailsScreen> {
  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#06ade2"),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFFFFFF),
                        semanticLabel: 'Return',
                      )),
                )),
            const Expanded(
              child: Center(
                child: Text(
                  'تفاصيل التبلــيغـة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Wessam',
                      fontWeight: FontWeight.normal,
                      fontSize: 38,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consumer<AnnouncesProvider>(
                                      builder: (_,
                                          AnnouncesProvider announcesprovider,
                                          __) {
                                    return AnnouncesHomeScreen(
                                        announcesprovider.announces);
                                  }))),
                      child: const ImageIcon(
                        AssetImage("assets/bell.gif"),
                        //FontAwesomeIcons.solidBell,
                        color: Colors.yellow,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //List<Placemark> placemarks =
    placemarkFromCoordinates(widget.report.latitude, widget.report.longitude
            // 52.2165157,
            // 6.9437819
            )
        .then((value) => log("address : " + value.first.toString()));

    Size size = MediaQuery.of(context).size;
    final List<String> imgList =
        widget.report.images.map((incident) => incident.image).toList();
    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        // Navigator.pop(context, false);
        Navigator.of(context).pop();
        //we need to return a future
        return Future.value(false);
      },
      child: SafeArea(
        bottom: false,
        top: false,
        left: false,
        right: false,
        child: Scaffold(
          backgroundColor: HexColor("#ffffff"),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getAppBarUI(),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 8.0),
                    child: FullScreenWidget(
                      child: CarouselSlider(
                        options: CarouselOptions(
                            viewportFraction: 0.85,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            enableInfiniteScroll: false),
                        items: imgList
                            .map((item) => Center(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      color: HexColor("#19374D"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      border: Border.all(
                                          color: HexColor("#19374D"),
                                          width: 1)),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Stack(
                                      children: [
                                        InteractiveViewer(
                                            child: CachedNetworkImage(
                                          imageUrl: item,
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
                                          height: 400.0,
                                          fit: BoxFit.fill,
                                          width: size.width,
                                        )),
                                        /* Image.network(item,
                                                fit: BoxFit.cover,
                                                height: 400.0,
                                                width: size.width)),*/
                                        Positioned(
                                          bottom: 8,
                                          left: 8,
                                          child: GestureDetector(
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                            child: NeumorphicButton(
                                                margin: const EdgeInsets.only(
                                                    top: 12),
                                                onPressed: () {},
                                                style: NeumorphicStyle(
                                                  color: Colors.white,
                                                  shape: NeumorphicShape.flat,
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      widget.report.location
                                                              ?.daira?.name ??
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
                                                      widget.report.location
                                                              ?.wilaya?.name ??
                                                          "unknwon",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: HexColor(
                                                                  "#3f81e2")
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mapMarkerAlt,
                                                      size: 12,
                                                      color:
                                                          Colors.red.shade300,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 64.0, bottom: 0.0, left: 24.0, right: 24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: []),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              widget.report.createdAt.day.toString() +
                                  "/" +
                                  widget.report.createdAt.month.toString() +
                                  "/" +
                                  widget.report.createdAt.year.toString(),
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: HexColor("#19374D").withOpacity(0.8),
                                  fontFamily: "Mulish-SemiBold")),
                          Container(
                              width: size.width / 2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                  //widget.annonce.title,
                                  widget.report.location?.commune?.ar_name ??
                                      "unknwon",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: HexColor("#19374D"),
                                      fontWeight: FontWeight.bold))),
                        ]),
                    Divider(
                      thickness: 1.0,
                      color: HexColor("#19374D").withOpacity(0.3),
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GroupButton(
                            buttons: widget.report.incidentTypes
                                .map((incident) => incident.title)
                                .toList(),
                            selectedButton: 4,
                            selectedShadow: const [],
                            unselectedShadow: const [],
                            unselectedColor: Colors.grey[300],
                            unselectedTextStyle: TextStyle(
                              color: Colors.grey[600],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            onSelected: (i, selected) {},
                            onDisablePressed: (i) {},
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1.0,
                      color: HexColor("#19374D").withOpacity(0.3),
                      height: 32.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      if (widget.report.globalStatus == 0)
                        Text(
                          " الوضعية : في انتظار استجابة الجهة المعنية  ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: HexColor("#19374D").withOpacity(0.8),
                              fontFamily: "Mulish-SemiBold",
                              fontWeight: FontWeight.bold),
                        ),
                      if (widget.report.globalStatus == 1)
                        Text(
                          " الوضعية : تبليغة مرفوضة من الجهة المعنية   ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: HexColor("#19374D").withOpacity(0.8),
                              fontFamily: "Mulish-SemiBold",
                              fontWeight: FontWeight.bold),
                        ),
                      if (widget.report.globalStatus == 2)
                        Text(
                          " الوضعية : جاري التكفل بالمشكل    ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: HexColor("#19374D").withOpacity(0.8),
                              fontFamily: "Mulish-SemiBold",
                              fontWeight: FontWeight.bold),
                        ),
                      if (widget.report.globalStatus == 3)
                        Text(
                          " الوضعية : تم التكفل بالمشكل     ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: HexColor("#19374D").withOpacity(0.8),
                            fontFamily: "Mulish-SemiBold",
                          ),
                        ),
                    ]),
                    Row(children: [
                      Expanded(
                        child: Text(
                          widget.report.description,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: HexColor("#19374D").withOpacity(0.8),
                            fontFamily: "Mulish-SemiBold",
                          ),
                        ),
                      ),
                    ]),
                    Divider(
                      thickness: 1.0,
                      color: HexColor("#19374D").withOpacity(0.3),
                      height: 32.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor("#19374D"),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(color: HexColor("#19374D"), width: 1)),
                      width: size.width,
                      height: size.height / 2,
                      child: FullScreenWidget(
                          child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(widget.report.latitude,
                                  widget.report.longitude),
                              interactiveFlags: InteractiveFlag.none,
                              plugins: [
                                // <-- add plugin here
                              ],
                              zoom: 15.0,
                            ),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate:
                                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: ['a', 'b', 'c']),
                              new MarkerLayerOptions(markers: [
                                Marker(
                                    point: LatLng(widget.report.latitude,
                                        widget.report.longitude),
                                    builder: (context) => GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.location_on_sharp,
                                            color: Colors.red,
                                            size: 30.0,
                                          ),
                                        ))
                              ]
                                  // markers:
                                  // nearByReports(reportsprovider.reports.data.reports)
                                  ),
                              // LocationMarkerLayerOptions(),
                            ],
                            children: []),
                      )),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
