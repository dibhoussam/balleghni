import 'dart:io';
import 'dart:math';

import 'package:admin/models/Announces.dart';
import 'package:admin/models/Authorities.dart';
import 'package:admin/models/Branchs.dart';
import 'package:admin/models/User.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/ReportsProvider.dart';
import 'package:admin/provider/UsersProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/screens/dashboard/components/announces_list.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:admin/models/Reports.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:webviewx/webviewx.dart';
import '../../../constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:admin/responsive.dart';

class AuthoritieDetails extends StatefulWidget {
  Authoritie rep;

  AuthoritieDetails({
    Key? key,
    required this.rep,
  }) : super(key: key);

  @override
  State<AuthoritieDetails> createState() => _AuthoritieDetailsState();
}

enum Options { waiting, refused, workingon, done }

class _AuthoritieDetailsState extends State<AuthoritieDetails> {
  late int _rowsPerPage = 5;
  late int _rowsPerPage2 = 5;
  late Announces ann;
  final darkColor = Color(0xFF49535C);

  var montserrat = TextStyle(
    fontSize: 12,
  );
  /*late int newGlobalstate;
  late String commentaire;*/
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  List<Widget> images = [];
  final box = GetStorage();
  late String authoritie;
  late bool add_authorization;
  late WebViewXController webviewController;

  @override
  void initState() {
    if (widget.rep.announces!.length < _rowsPerPage2)
      _rowsPerPage2 = widget.rep.announces!.length;
    else
      _rowsPerPage2 = 5;

    //newGlobalstate = widget.rep.globalStatus;
    //commentaire = "";

    super.initState();

    authoritie = box.read("authoritie");
    add_authorization = (int.parse(authoritie) == widget.rep.id);

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
                      padding: EdgeInsets.all(15),
                      child: Images(),
                    ),
                  ),
                  ResponsiveGridCol(
                      xs: 12,
                      sm: 12,
                      md: 12,
                      lg: 12,
                      xl: 12,
                      child: Container(
                        height: 530,
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
                              "Communiqués",
                              style: TextStyle(fontSize: 30),
                            ),
                            Consumer<AnnouncesProvider>(
                                builder: (_, AnnouncesProvider provider, __) {
                              if (widget.rep.announces!.isNotEmpty)
                                return SizedBox(
                                  width: double.infinity,
                                  child: PaginatedDataTable(
                                      header: Row(),
                                      actions: [
                                        if (add_authorization)
                                          TextButton(
                                            child: const Icon(
                                              // Icons.create,
                                              Icons.add_sharp,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              late XFile? image = null;
                                              String titre = "";
                                              String des = "";
                                              String des_fr = "";
                                              Future<bool> update() async {
                                                if (image == null)
                                                  return false;
                                                else
                                                  return await Repository()
                                                      .addAnnounces(
                                                    context,
                                                    des,
                                                    des_fr,
                                                    titre,
                                                    image!,
                                                    int.parse(authoritie),
                                                  );
                                              }

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          elevation: 0,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            padding: EdgeInsets.all(
                                                                defaultPadding),
                                                            decoration:
                                                                BoxDecoration(
                                                                    //color: secondaryColor,
                                                                    color:
                                                                        secondaryColor,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10))),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: Responsive.isMobile(
                                                                              context) ||
                                                                          Responsive.isTablet(
                                                                              context)
                                                                      ? 0.0
                                                                      : 30),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      "Titre du communiqué"),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child:
                                                                        TextFormField(
                                                                      onChanged:
                                                                          (value) =>
                                                                              setState(() {
                                                                        titre =
                                                                            value;
                                                                      }),
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Titre",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      validator:
                                                                          (val) {
                                                                        if (val!.length ==
                                                                            0) {
                                                                          return "";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      maxLines:
                                                                          null,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                      "Contenu en arabe"),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child:
                                                                        TextFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            "الموضوع",
                                                                        floatingLabelAlignment:
                                                                            FloatingLabelAlignment.start,
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      onChanged:
                                                                          (value) =>
                                                                              setState(() {
                                                                        des =
                                                                            value;
                                                                      }),
                                                                      validator:
                                                                          (val) {
                                                                        if (val!.length ==
                                                                            0) {
                                                                          return "";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      maxLines:
                                                                          null,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                      "Contenu en français"),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    child:
                                                                        TextFormField(
                                                                      onChanged:
                                                                          (value) =>
                                                                              setState(() {
                                                                        des_fr =
                                                                            value;
                                                                      }),
                                                                      decoration:
                                                                          new InputDecoration(
                                                                        labelText:
                                                                            "Description FR",
                                                                        fillColor:
                                                                            Colors.white,
                                                                        border:
                                                                            new OutlineInputBorder(
                                                                          borderRadius:
                                                                              new BorderRadius.circular(25.0),
                                                                          borderSide:
                                                                              new BorderSide(),
                                                                        ),
                                                                        //fillColor: Colors.green
                                                                      ),
                                                                      validator:
                                                                          (val) {
                                                                        if (val!.length ==
                                                                            0) {
                                                                          return "";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      maxLines:
                                                                          null,
                                                                      style:
                                                                          new TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text('Logo'),
                                                                  DottedBorder(
                                                                    borderType:
                                                                        BorderType
                                                                            .RRect,
                                                                    radius:
                                                                        const Radius.circular(
                                                                            12),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(6),
                                                                    dashPattern: [
                                                                      8,
                                                                      4
                                                                    ],
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(16.0)),
                                                                      ),
                                                                      height:
                                                                          130,
                                                                      width:
                                                                          130,
                                                                      //decoration: imgbackground1,
                                                                      child: (image ==
                                                                              null)
                                                                          ? Center(
                                                                              child: TextButton(
                                                                                  onPressed: () async {
                                                                                    // final  _picker = imp.ImagePickerPlugin();
                                                                                    final _picker = ImagePicker();
                                                                                    var myimage = await _picker.pickImage(source: ImageSource.gallery);
                                                                                    //await _picker.pickImage(source: ImageSource.gallery);
                                                                                    if (myimage != null) {
                                                                                      setState(() {
                                                                                        image = myimage;
                                                                                      });
                                                                                      print(image ?? "no path ");
                                                                                    }
                                                                                  },
                                                                                  child: const Text(
                                                                                    "Upload",
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  )),
                                                                            )
                                                                          : Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                                                                boxShadow: <BoxShadow>[
                                                                                  BoxShadow(
                                                                                    color: Colors.black.withOpacity(0.6),
                                                                                    offset: const Offset(0, 0),
                                                                                    blurRadius: 3,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              margin: const EdgeInsets.all(5.0),
                                                                              child: ClipRRect(
                                                                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                                                  child: Stack(
                                                                                    children: <Widget>[
                                                                                      Image.network(
                                                                                        image!.path,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                      Positioned(
                                                                                        top: 8,
                                                                                        right: 8,
                                                                                        child: Material(
                                                                                          color: Colors.transparent,
                                                                                          child: InkWell(
                                                                                            borderRadius: const BorderRadius.all(
                                                                                              Radius.circular(32.0),
                                                                                            ),
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                image = null;
                                                                                              });
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(8.0),
                                                                                              child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Icon(Icons.delete, color: Colors.black)), //hna 1
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  RoundedLoadingButton(
                                                                    width: 200,
                                                                    child: Text(
                                                                        'Ajouter',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    controller:
                                                                        _btnController,
                                                                    onPressed:
                                                                        () async {
                                                                      _btnController
                                                                          .start();
                                                                      if (await update()) {
                                                                        _btnController
                                                                            .success();
                                                                        Navigator.pop(
                                                                            context);
                                                                      } else
                                                                        _btnController
                                                                            .error();

                                                                      _btnController
                                                                          .reset();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  });
                                            },
                                          ),
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          icon: const Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Repository r = Repository();
                                            r.fetchAnnounces(context);
                                          },
                                        ),
                                      ],
                                      onPageChanged: (value) async {
                                        setState(() {
                                          if (value != null) {
                                            /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
                                            if (widget.rep.announces!.length -
                                                    value <
                                                _rowsPerPage2)
                                              _rowsPerPage2 =
                                                  widget.rep.announces!.length -
                                                      value;

                                            /// else, restore default rowsPerPage value
                                            else
                                              _rowsPerPage2 = PaginatedDataTable
                                                  .defaultRowsPerPage;
                                          } else
                                            _rowsPerPage2 = 0;
                                        });
                                      },
                                      rowsPerPage: _rowsPerPage2,
                                      arrowHeadColor: Colors.white,
                                      showFirstLastButtons: true,
                                      columnSpacing: defaultPadding,
                                      columns: [
                                        DataColumn(
                                          label: Text("Titre"),
                                        ),
                                        DataColumn(
                                          label: Text("Authorité"),
                                        ),
                                        DataColumn(
                                          label: Text("Date de creation"),
                                        ),
                                        DataColumn(
                                          label: Text("Actions"),
                                        ),
                                      ],
                                      source: Announces(
                                          data: provider.announces.data
                                              .where((element) =>
                                                  element.authoritie!.id ==
                                                  widget.rep.id)
                                              .toList())
                                      //   Announces(data: widget.rep.announces ?? [])
                                      /*List.generate(
                  rep.data.reports.length,
                  (index) => ReportDataRow(rep.data.reports[index]),
                ),*/
                                      ),
                                );
                              else
                                return Padding(
                                  padding: const EdgeInsets.only(top: 215),
                                  child: Text("Données non disponible"),
                                );
                            })
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
                        height: 530,
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
                              "Agences",
                              style: TextStyle(fontSize: 30),
                            ),
                            widget.rep.branchs!.isNotEmpty
                                ? SizedBox(
                                    width: double.infinity,
                                    child: PaginatedDataTable(
                                        header: Row(),
                                        actions: [
                                          if (add_authorization)
                                            TextButton(
                                              child: const Icon(
                                                // Icons.create,
                                                Icons.add_sharp,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                /* Repository r = Repository();
                                          r.fetchAuthorities(context);*/
                                              },
                                            ),
                                          IconButton(
                                            splashColor: Colors.transparent,
                                            icon: const Icon(
                                              Icons.refresh,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              /* Repository r = Repository();
                                        r.fetchAuthorities(context);*/
                                            },
                                          ),
                                        ],
                                        onPageChanged: (value) async {
                                          //localisation ,

                                          setState(() {
                                            if (value != null) {
                                              /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
                                              if (widget.rep.branchs!.length -
                                                      value <
                                                  _rowsPerPage)
                                                _rowsPerPage =
                                                    widget.rep.branchs!.length -
                                                        value;

                                              /// else, restore default rowsPerPage value
                                              else
                                                _rowsPerPage = 5;
                                            } else
                                              _rowsPerPage = 0;
                                          });
                                        },
                                        rowsPerPage: _rowsPerPage,
                                        arrowHeadColor: Colors.white,
                                        showFirstLastButtons: true,
                                        columnSpacing: defaultPadding,
                                        columns: [
                                          DataColumn(
                                            label: Text("Wilaya"),
                                          ),
                                          DataColumn(
                                            label: Text("Daira "),
                                          ),
                                          DataColumn(
                                            label: Text("Commune"),
                                          ),
                                          DataColumn(
                                            label: Text("Mail"),
                                          ),
                                          DataColumn(
                                            label: Text("Phone"),
                                          ),
                                          DataColumn(
                                            label: Text("Action"),
                                          ),
                                        ],
                                        source: Branchs(
                                            branch: widget.rep.branchs ?? [])
                                        /*List.generate(
                  rep.data.reports.length,
                  (index) => ReportDataRow(rep.data.reports[index]),
                ),*/
                                        ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 215),
                                    child: Text("Données non disponible"),
                                  )
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
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Utilisateurs",
                                style: TextStyle(fontSize: 30),
                              ),
                              Consumer<UsersProvider>(
                                builder: (_, UsersProvider provider, __) {
                                  return PaginatedDataTable(
                                      header: Row(),
                                      actions: [
                                        if (add_authorization)
                                          TextButton(
                                            child: const Icon(
                                              // Icons.create,
                                              Icons.add_sharp,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              /*  Repository r = Repository();
                                              r.fetchUsers(context);*/
                                            },
                                          ),
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          icon: const Icon(
                                            Icons.refresh,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Repository r = Repository();
                                            r.fetchUsers(context);
                                          },
                                        ),
                                      ],
                                      onPageChanged: (value) async {},
                                      rowsPerPage: _rowsPerPage,
                                      arrowHeadColor: Colors.white,
                                      showFirstLastButtons: true,
                                      columnSpacing: defaultPadding,
                                      columns: [
                                        DataColumn(
                                          label: Text("Nom"),
                                        ),
                                        DataColumn(
                                          label: Text("Prenom "),
                                        ),
                                        DataColumn(
                                          label: Text("autorité"),
                                        ),
                                        DataColumn(
                                          label: Text("Email"),
                                        ),
                                        DataColumn(
                                          label: Text("Nom d'utlisateur"),
                                        ),
                                        DataColumn(
                                          label: Text("Action"),
                                        ),
                                      ],
                                      source: Users(
                                          user: provider.users.user
                                              .where((element) =>
                                                  element.wilayaId ==
                                                  authoritie)
                                              .toList())
                                      /*List.generate(
                                                rep.data.reports.length,
                                                (index) => ReportDataRow(rep.data.reports[index]),
                                              ),*/
                                      );
                                },
                              ),
                            ],
                          ))),
                  if (int.parse(authoritie) == widget.rep.id)
                    ResponsiveGridCol(
                        xs: 12,
                        sm: 12,
                        md: 12,
                        lg: 12,
                        xl: 12,
                        child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Statistique ",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: WebViewX(
                                    initialSourceType: SourceType.url,
                                    initialContent:
                                        "http://41.111.148.170:9085/superset/dashboard/${widget.rep.slug}/",
                                    width: 1500,
                                    height: 1500,
                                    key: const ValueKey('webviewx'),
                                    onWebViewCreated: (controller) =>
                                        webviewController = controller,
                                    onPageStarted: (src) => debugPrint(
                                        'A new page has started loading: $src\n'),
                                    onPageFinished: (src) => debugPrint(
                                        'The page has finished loading: $src\n'),
                                    webSpecificParams: const WebSpecificParams(
                                      printDebugInfo: true,
                                    ),
                                    mobileSpecificParams:
                                        const MobileSpecificParams(
                                      androidEnableHybridComposition: true,
                                    ),
                                    navigationDelegate: (navigation) {
                                      debugPrint(navigation.content.sourceType
                                          .toString());
                                      return NavigationDecision.navigate;
                                    },
                                  ))
                              /*WebViewX(
            initialSourceType: SourceType.url,
            initialContent:
                "http://41.111.148.170:9085/superset/dashboard/alger/",
            width: 1000,
            height: 1000,
            key: const ValueKey('webviewx'),
            onWebViewCreated: (controller) => webviewController = controller,
            onPageStarted: (src) =>
                debugPrint('A new page has started loading: $src\n'),
            onPageFinished: (src) =>
                debugPrint('The page has finished loading: $src\n'),
            webSpecificParams: const WebSpecificParams(
              printDebugInfo: true,
            ),
            mobileSpecificParams: const MobileSpecificParams(
              androidEnableHybridComposition: true,
            ),
            navigationDelegate: (navigation) {
              debugPrint(navigation.content.sourceType.toString());
              return NavigationDecision.navigate;
            },
          ),*/
                            ],
                          ),
                        ))
                ],
              )),
        ],
      ),
    );
  }

  Container Images() {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent, width: 0.5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                ClipPath(
                  clipper: AvatarClipper(),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: darkColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 11,
                  bottom: Responsive.isMobile(context) ? 100 : 50,
                  child: TextButton(
                      onPressed: () {
                        late XFile? image = null;
                        String des = "";
                        String nom = "";
                        Future<bool> update() async {
                          return await Repository().UpdateAutoritie(
                              context,
                              des,
                              nom,
                              (image != null) ? image : null,
                              widget.rep.id);
                        }

                        showDialog(
                            context: context,
                            builder: ((context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                      padding: EdgeInsets.all(defaultPadding),
                                      decoration: BoxDecoration(
                                        //color: secondaryColor,
                                        color: secondaryColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Nouveau Nom "),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: TextFormField(
                                              onChanged: (value) =>
                                                  setState(() {
                                                nom = value;
                                              }),
                                              decoration: new InputDecoration(
                                                labelText: "nom",
                                                fillColor: Colors.white,
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: new BorderSide(),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if (val!.length == 0) {
                                                  return "";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              style: new TextStyle(
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Nouvelle Description "),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: TextFormField(
                                              onChanged: (value) =>
                                                  setState(() {
                                                des = value;
                                              }),
                                              decoration: new InputDecoration(
                                                labelText: "Description",
                                                fillColor: Colors.white,
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          25.0),
                                                  borderSide: new BorderSide(),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if (val!.length == 0) {
                                                  return "";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              style: new TextStyle(
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('logo'),
                                          DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(12),
                                            padding: const EdgeInsets.all(6),
                                            dashPattern: [8, 4],
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16.0)),
                                              ),
                                              height: 250,
                                              width: 250,
                                              //decoration: imgbackground1,
                                              child: (image == null)
                                                  ? Center(
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            // final  _picker = imp.ImagePickerPlugin();
                                                            final _picker =
                                                                ImagePicker();
                                                            var myimage = await _picker
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                            //await _picker.pickImage(source: ImageSource.gallery);
                                                            if (myimage !=
                                                                null) {
                                                              setState(() {
                                                                image = myimage;
                                                              });
                                                              print(image ??
                                                                  "no path ");
                                                            }
                                                          },
                                                          child: const Text(
                                                            "upload",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    16.0)),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                            offset:
                                                                const Offset(
                                                                    0, 0),
                                                            blurRadius: 3,
                                                          ),
                                                        ],
                                                      ),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Image.network(
                                                                image!.path,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              Positioned(
                                                                top: 8,
                                                                right: 8,
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      InkWell(
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          32.0),
                                                                    ),
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        image =
                                                                            null;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape
                                                                                  .circle,
                                                                              color: Colors
                                                                                  .white),
                                                                          child: Icon(
                                                                              Icons.delete,
                                                                              color: Colors.black)), //hna 1
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.5 /
                                                3,
                                            child: RoundedLoadingButton(
                                              width: 200,
                                              child: Text('Tap me!',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              controller: _btnController,
                                              onPressed: () async {
                                                _btnController.start();
                                                if (await update()) {
                                                  _btnController.success();
                                                } else
                                                  _btnController.error();

                                                Future.delayed(
                                                    Duration(seconds: 20));
                                                _btnController.reset();
                                              },
                                            ),
                                          )
                                        ],
                                      )),
                                );
                                ;
                              });
                            }));
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                Positioned(
                  left: 11,
                  top: 50,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.rep!.logo
                            //"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg"
                            ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Text(
                              widget.rep.name,
                              style: TextStyle(
                                fontSize: 28,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 8),
                          Text(
                            widget.rep.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: darkColor,
                            ),
                          ),
                          const SizedBox(height: 8)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 30,
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*
                      Text(
                        "Twitter Account: \n GitHub Account: ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Official Start: \n Occupation: ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),*/
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                      Text("@flutter_exp",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      Text("md-weber",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      const SizedBox(height: 16),
                      Text("28.01.2020",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      Text("Sn. Software Engineer",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),*/
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.rep.announces!.length.toString(), //"6280",
                      style: buildMontserrat(
                        const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Nombre d'annonce",
                      style: buildMontserrat(darkColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: const VerticalDivider(
                    color: Color(0xFF9A9A9A),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.rep.branchs!.length.toString(),
                      style: buildMontserrat(
                        const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Agences",
                      style: buildMontserrat(darkColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: const VerticalDivider(
                    color: Color(0xFF9A9A9A),
                  ),
                ),
                Column(
                  children: [
                    Consumer<ReportsProvider>(
                        builder: (_, ReportsProvider reportsprovider, __) {
                      return Text(
                        reportsprovider.reports.data
                            .where((element) =>
                                element.incidentTypes.first.authoritie!.id ==
                                widget.rep.id)
                            .toList()
                            .length
                            .toString(),
                        style: buildMontserrat(
                          const Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    Text(
                      "Rapports",
                      style: buildMontserrat(darkColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 15,
      color: color,
      fontWeight: fontWeight,
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
      DataCell(Text(fileInfo.id!.toString())),
      DataCell(Text(fileInfo.createdAt.toIso8601String().split("T").first!)),
      DataCell(Text(fileInfo.description!)),
      DataCell(Text(fileInfo.location!.commune!.name!)),
      DataCell(Text(fileInfo.location!.daira!.name!)),
      DataCell(Text(fileInfo.location!.wilaya!.name!)),
      DataCell(Text(fileInfo.incidentTypes.first.title)),
      DataCell(Text("nothing")),
    ],
  );
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
