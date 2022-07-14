import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as s;

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: s.SvgPicture.asset(
            "assets/screen12.svg",
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          )),
    );
  }
}
