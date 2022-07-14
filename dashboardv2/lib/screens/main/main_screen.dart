import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/Announces.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:admin/repo/repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/authoritie_details.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/dashboard_reports_screen.dart';
import 'package:admin/screens/dashboard/details_report_screen.dart';
import 'package:admin/screens/dashboard/loading%20screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();

  late Function(Widget) change;
  late Function(Announce) show;
}

class _MainScreenState extends State<MainScreen> {
  Widget dashboardScreen = GetIt.instance.get<DashboardScreen>();
  ScrollController scroll_controller = ScrollController();
  late Widget present;
  final box = GetStorage();
  _change(Widget w) {
    setState(() {
      present = w;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    present = Consumer<AuthoritiesProvider>(
        builder: (_, AuthoritiesProvider reportsprovider, __) {
      String authoritie = box.read("authoritie");
      return AuthoritieDetails(
          rep: reportsprovider.authorities.data
              .firstWhere((element) => element.id == int.parse(authoritie)));
    });
    widget.change = _change;

    widget.show = showAlert;
  }

  Future<bool> initialisation() async {
    Repository repo = Repository();

    try {
      repo.fetchReports(context);
      await repo.fetchAuthorities(context);
      await repo.fetchIncidents(context);
      await repo.fetchAnnounces(context);
      await repo.fetchUsers(context);
      return true;
    } catch (e) {
      return false;
    }
  }

  showAlert(
    Announce r,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Detail du communiquée "),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(r.createdAt.toIso8601String().split("T").first),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      //ImageIcon(NetworkImage(data.authoritie[index].logo)),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          r.authoritie!.logo,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(r.authoritie!.name),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(r.title),
                  SizedBox(height: 10),
                  Text(r.description),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(
          change: _change,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(change: _change),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: FutureBuilder<bool>(
                    future: initialisation(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return LoadingScreen();
                        //return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return SafeArea(
                              child: SingleChildScrollView(
                                controller: scroll_controller,
                                padding: EdgeInsets.all(defaultPadding),
                                child: Column(
                                  children: [
                                    Header(),
                                    SizedBox(height: defaultPadding),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            children: [
                                              // MyFiles(),
                                              SizedBox(height: defaultPadding),
                                              present

                                              //RecentFiles(),
                                              /*  if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),*/
                                            ],
                                          ),
                                        ),
                                        /*if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),*/
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                        //return Text('Result: ${snapshot.data}');
                      }
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
