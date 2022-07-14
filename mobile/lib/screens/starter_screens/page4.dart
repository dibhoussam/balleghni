import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as s;

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: s.SvgPicture.asset(
          "assets/page4.svg",
          allowDrawingOutsideViewBox: true,
          fit: BoxFit.fill,
        ));
  }
}
