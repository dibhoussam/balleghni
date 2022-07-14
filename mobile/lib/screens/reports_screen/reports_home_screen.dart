import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:balighni/screens/detailsScreen/report_details_screen.dart';
import 'package:balighni/models/Reports.dart';
import 'package:balighni/repo/repository.dart';
import 'package:balighni/screens/reports_screen/reports_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'report_app_theme.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ReportsHomeScreen extends StatefulWidget {
  ReportsHomeScreen(this.rep);

  late Reports rep;

  @override
  _ReportsHomeScreenState createState() => _ReportsHomeScreenState();
}

class _ReportsHomeScreenState extends State<ReportsHomeScreen>
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
                  'تبلــيغـاتي',
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
    String? s = widget.rep.data.nextPageUrl;
    if (s != null && isfinish == false) {
      try {
        Repository rep = Repository();
        await rep.fetchMoreReports(context, s);
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
                      child: NestedScrollView(
                          // controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[],
                                  );
                                }, childCount: 1),
                              ),
                            ];
                          },
                          body: RefreshIndicator(
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
                                  await rep.fetchReports(context);
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
                                  return DefaultLoadMoreTextBuilder.english(
                                      status);
                                },
                                //delegate: DefaultLoadMoreDelegate(),
                                onLoadMore: _loadMore,
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: widget.rep.data.reports.length,
                                  padding: const EdgeInsets.only(top: 100),
                                  controller: _scrollController,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final int count =
                                        widget.rep.data.reports.length > 10
                                            ? 10
                                            : widget.rep.data.reports.length;
                                    final Animation<double> animation =
                                        Tween<double>(begin: 0.0, end: 1.0)
                                            .animate(CurvedAnimation(
                                                parent: animationController!,
                                                curve: Interval(
                                                    (1 / count) * index, 1.0,
                                                    curve:
                                                        Curves.fastOutSlowIn)));
                                    animationController?.forward();
                                    return Stack(
                                      children: [
                                        ReportListView(
                                          callback: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReportDetailsScreen(
                                                        report: widget.rep.data
                                                            .reports[index],
                                                      )),
                                            );
                                          },
                                          animation: animation,
                                          animationController:
                                              animationController!,
                                          rep: widget.rep.data.reports[index],
                                        ),
                                        AnimatedBuilder(
                                            animation: animationController!,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Positioned(
                                                top: 8,
                                                left: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(32.0),
                                                    ),
                                                    onTap: () async {
                                                      AwesomeDialog(
                                                        btnCancelText: "الغاء",
                                                        btnOkText: "تأكيد",
                                                        btnCancelColor:
                                                            Colors.grey,
                                                        showCloseIcon: true,
                                                        btnCancelOnPress: () {
                                                          Navigator.of(context,
                                                              rootNavigator:
                                                                  true);
                                                        },
                                                        context: context,
                                                        dialogType:
                                                            DialogType.ERROR,
                                                        animType:
                                                            AnimType.RIGHSLIDE,
                                                        headerAnimationLoop:
                                                            true,
                                                        title: 'حذف',
                                                        desc:
                                                            'يرجى تأكيد الحذف',
                                                        btnOkOnPress: () async {
                                                          Repository repo =
                                                              Repository();
                                                          await repo
                                                              .deleteReport(
                                                                  context,
                                                                  widget
                                                                      .rep
                                                                      .data
                                                                      .reports[
                                                                          index]
                                                                      .id);
                                                        },
                                                        btnOkIcon: Icons.cancel,
                                                        btnOkColor: Colors.red,
                                                      ).show();
                                                    },
                                                    child: FadeTransition(
                                                      opacity: animation!,
                                                      child: Transform(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                0.0,
                                                                50 *
                                                                    (1.0 -
                                                                        animation!
                                                                            .value),
                                                                0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                              child: const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .black)), //hna 1
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    );
                                  },
                                )),
                          )),
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
                          await rep.fetchReports(context);
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
