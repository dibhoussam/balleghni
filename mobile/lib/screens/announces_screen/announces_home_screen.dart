import 'dart:ui';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/detailsScreen/announce_details_screen.dart';
import 'package:balighni/models/Announces.dart';
import 'package:balighni/screens/announces_screen/announces_list_view.dart';
import 'package:balighni/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'announces_app_theme.dart';
import 'announces_list_view.dart';

class AnnouncesHomeScreen extends StatefulWidget {
  late Announces announces;
  AnnouncesHomeScreen(this.announces);
  @override
  _AnnouncesHomeScreenState createState() => _AnnouncesHomeScreenState();
}

class _AnnouncesHomeScreenState extends State<AnnouncesHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  //late Announces widget.announces;
  bool isfinish = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    //  widget.announces = widget.announces;

    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        backgroundColor: HexColor("#ffffff"),
        body: Stack(
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
                  Expanded(
                      child: Container(
                    color: AppTheme.buildLightTheme().backgroundColor,
                    child: RefreshIndicator(
                        edgeOffset: 100,
                        color: HexColor("#1074a8"),
                        onRefresh: () {
                          return Future.delayed(
                            const Duration(seconds: 1),
                            () async {
                              /// adding elements in list after [1 seconds] delay
                              /// to mimic network call
                              ///
                              /// Remember: [setState] is necessary so that
                              /// build method will run again otherwise
                              /// list will not show all elements
                              Repository rep = Repository();
                              await rep.fetchAnnounces(context);
                              setState(() {
                                isfinish = true;
                              });
                              // showing snackbar
                            },
                          );
                        },
                        child: LoadMore(
                            whenEmptyLoad: false,
                            isFinish: isfinish,
                            onLoadMore: _loadMore,
                            textBuilder: (status) {
                              if (status == LoadMoreStatus.nomore) {
                                return "";
                              }
                              return DefaultLoadMoreTextBuilder.english(status);
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              //   physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.announces.data.announces.length,
                              padding: const EdgeInsets.only(top: 100),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final int count =
                                    widget.announces.data.announces.length > 10
                                        ? 10
                                        : widget
                                            .announces.data.announces.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();

                                return AnnouncesListView(
                                  callback: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnnounceDetailsScreen(
                                                annonce: widget.announces.data
                                                    .announces[index]),
                                      ),
                                    );
                                  },
                                  hotelData:
                                      widget.announces.data.announces[index],
                                  animation: animation,
                                  animationController: animationController!,
                                );
                              },
                            ))),
                  )),
                ],
              ),
            ),
            if (widget.announces.data.announces.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RefreshIndicator(
                    edgeOffset: 100,
                    color: HexColor("#1074a8"),
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 1),
                        () async {
                          /// adding elements in list after [1 seconds] delay
                          /// to mimic network call
                          ///
                          /// Remember: [setState] is necessary so that
                          /// build method will run again otherwise
                          /// list will not show all elements
                          Repository rep = Repository();
                          await rep.fetchAnnounces(context);
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
                                opacity: 0.3,
                                child: Image.asset(
                                  "assets/noreports.png",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            const Text('ﻻيوجد معلومات \n متوفرة حاليا  ',
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
                                )),
                          ],
                        )),
                  ),
                ],
              ),
            Align(alignment: Alignment.topCenter, child: getAppBarUI()),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      height: AppBar().preferredSize.height + 30,
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.fill,
            //image: Svg("assets/Icon/95300.svg", source: SvgSource.asset)),
            image: AssetImage("assets/Icon/Artboard1.png")),
        //color: HexColor("#06ade2"),
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
                  'إعـلانـات',
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
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.solidBell,
                        size: 30,
                      ),
                      onPressed: () => {},
                      /*,Consumer<AnnouncesProvider>(builder:
                            (_, AnnouncesProvider announcesprovider, __) {
                          return AnnouncesHomeScreen(
                              announcesprovider.announces);
                        }),*/
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

  Future<bool> _loadMore() async {
    //String? s = widget.announces.data.nextPageUrl;
    String? s = null;
    if (s != null) {
      try {
        ///Recuperation des postes
        Repository rep = Repository();
        await rep.fetchMoreAnnounces(context, s);
        print("apres ");
        return true;
      } catch (err) {
        print('Something went wrong!');
        return false;
      }
    } else {
      setState(() {
        isfinish = true;
      });
    }
    return false;
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
