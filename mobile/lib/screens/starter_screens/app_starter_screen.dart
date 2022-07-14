import 'package:balighni/app_home_screen.dart';
import 'package:balighni/main.dart';

import 'package:balighni/models/tabIcon_data.dart';

import 'package:balighni/screens/starter_screens/page1.dart';
import 'package:balighni/screens/starter_screens/page2.dart';
import 'package:balighni/screens/starter_screens/page3.dart';
import 'package:balighni/screens/starter_screens/page4.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppStarterScreen extends StatefulWidget {
  @override
  _AppStarterScreenState createState() => _AppStarterScreenState();
}

class _AppStarterScreenState extends State<AppStarterScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  AnimationController? animationController;
  final controller = PageController(
    initialPage: 0,
  );
  final _totalDots = 4;
  double _currentPosition = 0.0;
  //int currentIndexPage = 0;

  void repeatOnce() async {
    await _controller.forward();
  }

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                    padEnds: false,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _currentPosition = value.toDouble();
                      });
                      if (_currentPosition == 3) {
                        repeatOnce();
                      } else {
                        _controller.reverse();
                      }
                    },
                    children: [Page1(), Page2(), Page3(), Page4()],
                    controller: controller,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Center(
                      child: DotsIndicator(
                        dotsCount: 4,
                        position: _currentPosition,
                      ),
                    ),
                  ),
                  if (_currentPosition == 3.0)
                    Positioned(
                      bottom: 60,
                      left: 0.0,
                      right: 0.0,
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: Center(
                          child: FadeTransition(
                            opacity: _controller,
                            child: NeumorphicButton(
                                margin: const EdgeInsets.only(top: 12),
                                onPressed: () async {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      CupertinoPageRoute(
                                          builder: (_) => AppHomeScreen()),
                                      (Route<dynamic> route) => false);
                                },
                                style: NeumorphicStyle(
                                  border: const NeumorphicBorder(
                                      color: Colors.blue,
                                      isEnabled: true,
                                      width: 2),
                                  color: Colors.white,
                                  //shadowDarkColor: Color(0xff06ade2),
                                  lightSource: LightSource.right,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "     ابدأ     ",
                                  style: TextStyle(
                                      fontFamily: "Wessam",
                                      fontSize: 38,
                                      color: HexColor("#064663")),
                                )),
                          ),
                        ),
                      ),
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    //await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
