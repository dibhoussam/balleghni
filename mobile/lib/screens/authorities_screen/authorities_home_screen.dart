import 'dart:developer';

import 'package:balighni/main.dart';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:balighni/screens/detailsScreen/authoritie_details_screen.dart';
import 'package:balighni/models/Authorities.dart';
import 'package:balighni/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'MiniCard.dart';
import 'authorities_app_theme.dart';

class AuthoritiesHomeScreen extends StatefulWidget {
  late Authorities authorities;
  AuthoritiesHomeScreen(this.authorities);
  @override
  _AuthoritiesHomeScreenState createState() => _AuthoritiesHomeScreenState();
}

class _AuthoritiesHomeScreenState extends State<AuthoritiesHomeScreen>
    with TickerProviderStateMixin {
  bool isfinish = false;
  AnimationController? animationController;
  final ScrollController _scrollController = ScrollController();
  // late Authorities widget.authorities;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    // widget.authorities = widget.authorities;

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
                                await rep.fetchAuthorities(context);
                                setState(() {
                                  isfinish = false;
                                });
                                // showing snackbar
                              },
                            );
                          },
                          child: LoadMore(
                            isFinish: isfinish,
                            textBuilder: (status) {
                              if (status == LoadMoreStatus.nomore) {
                                return "";
                              }
                              return DefaultLoadMoreTextBuilder.english(status);
                            },
                            onLoadMore: _loadMore,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 100),
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  widget.authorities.data.authoritie.length,
                              itemBuilder: (BuildContext context, int index) {
                                final int count = widget.authorities.data
                                            .authoritie.length >
                                        10
                                    ? 10
                                    : widget.authorities.data.authoritie.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                animationController?.forward();
                                return MiniNewsCard(
                                    animation: animation,
                                    animationController: animationController,
                                    callback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthoritieDetailsScreen(
                                                    authoritie: widget
                                                        .authorities
                                                        .data
                                                        .authoritie[index])),
                                      );
                                    },
                                    authoritieData: widget
                                        .authorities.data.authoritie[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10.0,
                                );
                              },
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            if (widget.authorities.data.authoritie.isEmpty)
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
                          await rep.fetchAuthorities(context);
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
                            const Text('ﻻيوجد معلومات  \nمتوفرة حاليا  ',
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
            getAppBarUI(),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      height: AppBar().preferredSize.height + 30,
      decoration: BoxDecoration(
        //color: HexColor("#06ade2"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'دلـيل المؤسسـات',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontFamily: 'Wessam',
                      // fontFamily: 'Wessam',
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
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

  Future<bool> _loadMore() async {
    String? s = widget.authorities.data.nextPageUrl;
    //String? s = widget.authorities.data ;
    log("message:$s");
    if (s != null) {
      try {
        ///Recuperation des postes
        Repository rep = Repository();
        await rep.fetchMoreAuthorities(context, s);
        return true;
      } catch (err) {
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
