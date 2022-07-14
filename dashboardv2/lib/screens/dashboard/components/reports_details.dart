import 'package:admin/models/Authorities.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/screens/dashboard/components/authoritie_details.dart';
import 'package:admin/screens/dashboard/dashboard_autortie_screen.dart';
import 'package:admin/screens/dashboard/dashboard_reports_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:admin/models/Reports.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../../constants.dart';

class ReportDetails extends StatefulWidget {
  Report rep;

  ReportDetails({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

enum Options { waiting, refused, workingon, done }

class _ReportDetailsState extends State<ReportDetails> {
  late int newGlobalstate;
  late String commentaire;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final box = GetStorage();
  late int authoritie;

  List<Widget> images = [];

  @override
  void initState() {
    authoritie = int.parse(box.read("authoritie"));
    newGlobalstate = widget.rep.globalStatus;
    commentaire = "";
    widget.rep.images.forEach((element) {
      images.add(Image.network(
        element.image,
        height: 300,
        fit: BoxFit.contain,
      ));
      images.add(Image.network(
        element.image,
        height: 300,
        fit: BoxFit.contain,
      ));
      images.add(Image.network(
        element.image,
        height: 300,
        fit: BoxFit.contain,
      ));
    });
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        //color: secondaryColor,
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
              data: Theme.of(context).copyWith(
                  cardColor: secondaryColor, dividerColor: Colors.transparent),
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                      xs: 12,
                      sm: 12,
                      md: 12,
                      lg: 12,
                      xl: 12,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        //color: secondaryColor,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          // color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          "Detailles De Rapport",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )),
                  ResponsiveGridCol(
                    xs: 12,
                    sm: 12,
                    md: 12,
                    lg: 12,
                    xl: 12,
                    child: Images(),
                  ),
                  ResponsiveGridCol(
                      xs: 12,
                      sm: 12,
                      md: 12,
                      lg: 6,
                      xl: 6,
                      child: Container(
                        height: 535,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 0.5),
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Information Sur Le Rapport",
                              style: TextStyle(fontSize: 30),
                            ),
                            DataTable(
                              border: TableBorder(
                                  horizontalInside:
                                      BorderSide(color: Colors.white)),
                              columns: [
                                DataColumn(label: Text("")),
                                DataColumn(label: Text(""))
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text("Autorité Concerné ")),
                                  DataCell(
                                    Row(
                                      children: [
                                        //ImageIcon(NetworkImage(data.authoritie[index].logo)),
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Image.network(
                                            widget.rep.incidentTypes.first
                                                .authoritie!.logo,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          widget.rep.incidentTypes.first
                                              .authoritie!.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      GetIt.I
                                          .get<ReportsDashboardScreen>()
                                          .change(AuthoritieDetails(
                                              rep: widget.rep.incidentTypes
                                                  .first.authoritie!));
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Status de Le Rapport")),
                                  DataCell(
                                    Text(
                                      widget.rep.globalStatus.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.globalStatus
                                                  .toString(),
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Address")),
                                  DataCell(
                                    Text(
                                      widget.rep.location!.address ??
                                          "Non Fournis",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.location!.address ??
                                                  "Non Fournis",
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Commune")),
                                  DataCell(
                                    Text(
                                      widget.rep.location!.commune!.name ??
                                          "Non Fournis",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.location!.commune!
                                                      .name ??
                                                  "Non Fournis",
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Daira ")),
                                  DataCell(
                                    Text(
                                      widget.rep.location!.daira!.name ??
                                          "Non Fournis",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.location!.daira!
                                                      .name ??
                                                  "Non Fournis",
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Wilaya")),
                                  DataCell(
                                    Text(
                                      widget.rep.location!.wilaya!.name ??
                                          "Non Fournis",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.location!.wilaya!
                                                      .name ??
                                                  "Non Fournis",
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Type De Problemes")),
                                  DataCell(
                                    Text(
                                      widget.rep.incidentTypes.first.title ??
                                          "Non Fournis",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.incidentTypes.first
                                                      .title ??
                                                  "Non Fournis",
                                            ));
                                          });
                                    },
                                  ),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Description/Commentaire")),
                                  DataCell(
                                    Text(
                                      widget.rep.description ?? "Non Fournis",
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                content: Text(
                                              widget.rep.description ??
                                                  "Non Fournis",
                                              textAlign: TextAlign.right,
                                            ));
                                          });
                                    },
                                  )
                                ])
                              ],
                            )
                          ],
                        ),
                      )),
                  ResponsiveGridCol(
                      xs: 12,
                      sm: 12,
                      md: 12,
                      lg: 6,
                      xl: 6,
                      child: Container(
                        height: 535,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 0.5),
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Text(
                                "Management d'état",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  padding: EdgeInsets.all(3.5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 22, 68, 105),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: newGlobalstate == 0
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "En attente",
                                                    style: TextStyle(
                                                        color: newGlobalstate ==
                                                                0
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                68,
                                                                105)
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                newGlobalstate = 0;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: newGlobalstate == 1
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Rejeté",
                                                    style: TextStyle(
                                                        color: newGlobalstate ==
                                                                1
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                68,
                                                                105)
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                newGlobalstate = 1;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: newGlobalstate == 2
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "En cours de résoltion",
                                                    style: TextStyle(
                                                        color: newGlobalstate ==
                                                                2
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                68,
                                                                105)
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                newGlobalstate = 2;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: newGlobalstate == 3
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "En cours de résoltion",
                                                    style: TextStyle(
                                                        color: newGlobalstate ==
                                                                3
                                                            ? Color.fromARGB(
                                                                255,
                                                                22,
                                                                68,
                                                                105)
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                newGlobalstate = 3;
                                              });
                                            },
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                onChanged: (value) => setState(() {
                                  commentaire = value;
                                }),
                                readOnly: widget.rep.incidentTypes.first
                                        .authoritie?.id !=
                                    authoritie,
                                decoration: new InputDecoration(
                                  labelText: "Commentaire",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val!.length == 0) {
                                    return "Commentaire";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            if (widget.rep.incidentTypes.first.authoritie?.id ==
                                authoritie)
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 1.5 / 3,
                                child: RoundedLoadingButton(
                                  width: 200,
                                  child: Text('Tap me!',
                                      style: TextStyle(color: Colors.white)),
                                  controller: _btnController,
                                  onPressed: () async {
                                    _btnController.start();
                                    if (await _Update(commentaire,
                                        newGlobalstate, widget.rep.id)) {
                                      _btnController.success();
                                    } else
                                      _btnController.error();

                                    Future.delayed(Duration(seconds: 20));
                                    _btnController.reset();
                                  },
                                ),
                              ),
                          ],
                        ),
                      )),
                  ResponsiveGridCol(
                      xs: 12,
                      sm: 12,
                      md: 12,
                      lg: 12,
                      xl: 12,
                      child: Container(
                          height: 400,
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: FlutterMap(
                              options: MapOptions(
                                  center: LatLng(widget.rep.latitude,
                                      widget.rep.longitude),
                                  maxZoom: 18,
                                  interactiveFlags: InteractiveFlag.all,
                                  plugins: [],
                                  zoom: 16),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: ['a', 'b', 'c']),
                                //     LocationMarkerLayerOptions(),
                                MarkerLayerOptions(markers: [
                                  Marker(
                                    point: LatLng(widget.rep.latitude,
                                        widget.rep.longitude),
                                    builder: (context) => const Icon(
                                      Icons.location_on_sharp,
                                      color: Colors.red,
                                      size: 35.0,
                                    ),
                                  )
                                ]),
                              ],
                              children: [])))
                ],
              )),
        ],
      ),
    );
  }

  Container Images() {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Images Prises de Rapport",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ListView.separated(
                  itemCount: images.length,
                  separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  /*options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  enableInfiniteScroll: false),*/
                  itemBuilder: (context, i) => Container(
                        decoration: BoxDecoration(
                            //color: HexColor("#19374D"),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                // color: HexColor("#19374D"),
                                width: 1)),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: FullScreenWidget(child: images[i]),
                        ),
                      ))),

          /*Expanded(
            child: ListView(
              shrinkWrap: true,
              children: images,
            ),
          ),*/
        ],
      ),
    );
  }

  Future<bool> _Update(String? commentaire, int? st, int id) async {
    return await Repository().UpdateReports(context, commentaire, st, id);
  }
}

DataRow ReportDataRow(Report fileInfo) {
  return DataRow(
    cells: [
      /*DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),*/
      DataCell(Text(fileInfo.id.toString())),
      DataCell(Text(fileInfo.createdAt.toIso8601String().split("T").first)),
      DataCell(Text(fileInfo.description)),
      DataCell(Text(fileInfo.location!.commune!.name)),
      DataCell(Text(fileInfo.location!.daira!.name!)),
      DataCell(Text(fileInfo.location!.wilaya!.name!)),
      DataCell(Text(fileInfo.incidentTypes.first.title)),
      DataCell(Text("nothing")),
    ],
  );
}
