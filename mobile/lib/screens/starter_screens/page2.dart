import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as s;

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      right: true,
      top: true,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: s.SvgPicture.asset(
                "assets/welcome_screen_page2_2.svg",
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ))),
    );
  }
}
