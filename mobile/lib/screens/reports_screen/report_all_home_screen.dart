import 'dart:developer';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:balighni/screens/detailsScreen/report_details_screen.dart';
import 'package:balighni/models/Reports.dart';
import 'package:balighni/repo/repository.dart';
import 'package:balighni/screens/reports_screen/reports_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:provider/provider.dart';
import '../../main.dart';
import 'report_app_theme.dart';
import 'package:loadmore/loadmore.dart';

class ReportsAllHomeScreen extends StatefulWidget {
  ReportsAllHomeScreen(this.rep);

  late Reports rep;

  @override
  _ReportsAllHomeScreenState createState() => _ReportsAllHomeScreenState();
}

class _ReportsAllHomeScreenState extends State<ReportsAllHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  /// At the beginning, we fetch the first 20 posts
  bool isfinish = false;

  DateTime startDate = DateTime.now();
  String? token;

  late final ScrollController _scrollController;
  //late Reports widget.rep ;
  final _storage = FlutterSecureStorage();

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scrollController = ScrollController(); //..addListener(_loadMore);
    widget.rep = widget.rep;
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget getAppBarUI() {
    return Container(
      height: AppBar().preferredSize.height + 30,
      decoration: BoxDecoration(
        image: DecorationImage(
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
            const Expanded(
              child: Center(
                child: Text(
                  'التبليغات',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
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
                    child: IconButton(
                      icon: const ImageIcon(
                        AssetImage("assets/bell.gif"),
                        //FontAwesomeIcons.solidBell,
                        size: 150,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consumer<AnnouncesProvider>(
                                      builder: (_,
                                          AnnouncesProvider announcesprovider,
                                          __) {
                                    return AnnouncesHomeScreen(
                                        announcesprovider.announces);
                                  }))),
                      color: HexColor("#fbdc67"),
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

  Future<bool> _loadToken() async {
    _storage.read(key: "token").then((value) => setState(() {
          token = value;
        }));
    return true;
  }

  Future<bool> _loadMore() async {
    log(widget.rep.data.nextPageUrl ?? "nothing ");

    if (widget.rep.data.nextPageUrl != null && isfinish == false) {
      try {
        Repository rep = Repository();
        await rep.fetchMoreAllReports(context, widget.rep.data.nextPageUrl);

        return true;
      } catch (err) {
        // print('Something went wrong!');
      }
    } else {
      setState(() {
        isfinish = true;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: HexColor("#ffffff"),
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  if (widget.rep.data.reports.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        edgeOffset: 100,
                        color: HexColor("#1074a8"),
                        onRefresh: () {
                          return Future.delayed(
                            Duration(seconds: 1),
                            () async {
                              /// adding elements in list after [1 seconds] delay
                              /// to mimic network call
                              ///
                              /// Remember: [setState] is necessary so that
                              /// build method will run again otherwise
                              /// list will not show all elements
                              Repository rep = Repository();
                              await rep.fetchAllReports(context);
                              setState(() {
                                isfinish = false;
                              });
                              // showing snackbar
                            },
                          );
                        },
                        child: LoadMore(
                            whenEmptyLoad: false,
                            isFinish: isfinish,
                            textBuilder: (status) {
                              if (status == LoadMoreStatus.nomore) {
                                return "";
                              }
                              return DefaultLoadMoreTextBuilder.english(status);
                            },
                            //delegate: DefaultLoadMoreDelegate(),
                            onLoadMore: _loadMore,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: widget.rep.data.reports.length,
                              padding: const EdgeInsets.only(top: 100),
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    widget.rep.data.reports.length > 10
                                        ? 10
                                        : widget.rep.data.reports.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return ReportListView(
                                  callback: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportDetailsScreen(
                                                report: widget
                                                    .rep.data.reports[index],
                                              )),
                                    );
                                  },
                                  animation: animation,
                                  animationController: animationController!,
                                  rep: widget.rep.data.reports[index],
                                );
                              },
                            )),
                      ),
                    ),
                ],
              ),
            ),
            if (widget.rep.data.reports.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RefreshIndicator(
                    edgeOffset: 100,
                    color: HexColor("#1074a8"),
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () async {
                          /// adding elements in list after [1 seconds] delay
                          /// to mimic network call
                          ///
                          /// Remember: [setState] is necessary so that
                          /// build method will run again otherwise
                          /// list will not show all elements
                          Repository rep = Repository();
                          await rep.fetchAllReports(context);
                          setState(() {
                            isfinish = false;
                          });
                          // showing snackbar
                        },
                      );
                    },
                    child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: 400,
                              height: 420,
                              alignment: Alignment.center,
                              child: Opacity(
                                opacity: 0.4,
                                child: Image.asset(
                                  "assets/noreports.png",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            const Text('ﻻيوجد معلومات \nمتوفرة حاليا  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 5.0,
                                        color: Color(0xff03045E)),
                                  ],
                                  fontFamily: 'Wessam',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36,
                                  color: Colors.white,
                                ) //),
                                ),
                          ],
                        )),
                  ),
                ],
              ),
            getAppBarUI(),
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }
}
