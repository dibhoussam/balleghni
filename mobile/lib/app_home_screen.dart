import 'package:balighni/provider/WilayasProvider.dart';
import 'package:balighni/screens/authorities_screen/authorities_home_screen.dart';
import 'package:balighni/models/tabIcon_data.dart';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/provider/AuthoritiesProvider.dart';
import 'package:balighni/provider/ReportsProvider.dart';
import 'package:balighni/screens/map_screen/simple_map.dart';
import 'package:balighni/screens/reporting_screen/screens/horisantalstepper.dart';
import 'package:balighni/screens/reports_screen/report_all_home_screen.dart';
import 'package:balighni/screens/reports_screen/reports_home_screen.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'app_theme.dart';
import 'main.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  final controller = PageController(initialPage: 0);

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    //tabBody = MyDiaryScreen(animationController: animationController);
    tabBody = Consumer<ReportsProvider>(
        builder: (_, ReportsProvider reportsprovider, __) {
      return ReportsHomeScreen(reportsprovider.reports);
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    PageView(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          for (var tab in tabIconsList) {
                            tab.isSelected = false;
                          }
                          tabIconsList[value].isSelected = true;
                        });
                      },
                      children: [
                        Consumer<ReportsProvider>(
                            builder: (_, ReportsProvider reportsprovider, __) {
                          return ReportsHomeScreen(reportsprovider.reports);
                        }),
                        Consumer<ReportsProvider>(
                            builder: (_, ReportsProvider reportsprovider, __) {
                          return ReportsAllHomeScreen(
                              reportsprovider.reports_all);
                        })
                        /*Consumer<AnnouncesProvider>(builder:
                            (_, AnnouncesProvider announcesprovider, __) {
                          return AnnouncesHomeScreen(
                              announcesprovider.announces);
                        })*/
                        ,
                        WillPopScope(
                            onWillPop: () {
                              //trigger leaving and use own data
                              // Navigator.pop(context, false);

                              //we need to return a future
                              return Future.value(false);
                            },
                            child: Nearby()),
                        Consumer<AuthoritiesProvider>(builder:
                            (_, AuthoritiesProvider authoritiesprovider, __) {
                          return WillPopScope(
                            onWillPop: () {
                              //trigger leaving and use own data
                              // Navigator.pop(context, false);

                              //we need to return a future
                              return Future.value(false);
                            },
                            child: AuthoritiesHomeScreen(
                                authoritiesprovider.authorities),
                          );
                        })
                      ],
                      controller: controller,
                    ),
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () async {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (_) => Consumer<WilayasmenuProvider>(
                        builder: (_, WilayasmenuProvider provider, __) {
                      return WillPopScope(
                          onWillPop: () {
                            //trigger leaving and use own data

                            //we need to return a future
                            return Future.value(true);
                          },
                          child: LoginPage(provider.wilayas));
                    })));
          },
          changeIndex: (int index) {
            switch (index) {
              case 0:
                {
                  controller.jumpToPage(0);
                }
                break;
              case 1:
                {
                  controller.jumpToPage(1);
                }
                break;
              case 2:
                {
                  controller.jumpToPage(2);
                }
                break;
              case 3:
                {
                  controller.jumpToPage(3);
                }
                break;

              default:
                {
                  //statements;
                }
                break;
            }
          },
        ),
      ],
    );
  }

  Widget getAppBarUI(String s) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.fill,
                //image: Svg("assets/Icon/95300.svg", source: SvgSource.asset)),
                image: AssetImage("assets/Icon/Artboard1.png")),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(0), bottom: Radius.circular(25.0)),
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
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      s,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                          fontFamily: 'Wessam',
                          fontWeight: FontWeight.normal,
                          fontSize: 38,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppBar().preferredSize.height + 40,
                  height: AppBar().preferredSize.height,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          FontAwesomeIcons.solidBell,
                          size: 30,
                          color: HexColor("#fbdc67"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
