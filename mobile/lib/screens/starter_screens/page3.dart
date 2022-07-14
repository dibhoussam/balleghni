import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as s;

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
          body: s.SvgPicture.asset(
            "assets/welcome_screen_page3_2.svg",
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          )),
    );
  }
}
