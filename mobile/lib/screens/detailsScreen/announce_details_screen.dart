import 'package:balighni/app_home_screen.dart';
import 'package:balighni/main.dart';
import 'package:balighni/models/Announces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

//listOfDownloadedFile.where((element) => element.Url == "your URL link")
class AnnounceDetailsScreen extends StatefulWidget {
  final Announce annonce;
  const AnnounceDetailsScreen({Key? key, required this.annonce})
      : super(key: key);

  @override
  _AnnounceDetailsScreen createState() => _AnnounceDetailsScreen();
}

class _AnnounceDetailsScreen extends State<AnnounceDetailsScreen> {
  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            //image: Svg("assets/Icon/95300.svg", source: SvgSource.asset)),
            image: AssetImage("assets/Icon/Artboard1.png")),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(10.0)),
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
                  /*  onTap: () => Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (_) => AppHomeScreen())),*/

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
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        bottom: false,
        top: false,
        left: false,
        right: false,
        child: Scaffold(
          backgroundColor: HexColor("#ffffff"),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getAppBarUI(),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 18, right: 18, bottom: 3),
                    child: FullScreenWidget(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: widget.annonce.file,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      LiquidLinearProgressIndicator(
                                value: progress.progress ??
                                    0.5, // Defaults to 0.5.
                                valueColor: const AlwaysStoppedAnimation(Colors
                                    .pink), // Defaults to the current Theme's accentColor.
                                backgroundColor: Colors
                                    .black, // Defaults to the current Theme's backgroundColor.
                                borderColor: Colors.red,
                                borderWidth: 5.0,
                                direction: Axis
                                    .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                center: const Text("جاري التحميل..."),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              height: 400.0,
                              fit: BoxFit.cover,
                              width: size.width,
                            ),

                            /* Image.network(
                              widget.annonce.file ,
                              height: 400.0,
                              width: size.width,
                              
                            ), */
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: size.width / 2,
                              child: Text(widget.annonce.title,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0x00000000),
                                      fontWeight: FontWeight.bold))),
                        ]),
                    Divider(
                      thickness: 1.0,
                      color: const Color(0x00000000).withOpacity(0.3),
                      height: 32.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.blueGrey,
                                offset: Offset(0, 0),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(widget.annonce.authoritie!.logo),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.annonce.authoritie?.name ??
                                "No Information Provided",
                            style: TextStyle(
                                fontSize: 13.0,
                                color: const Color(0x00000000).withOpacity(0.8),
                                fontFamily: "Mulish-SemiBold"),
                          ),
                        ),
                        Text(
                            widget.annonce.createdAt.day.toString() +
                                "/" +
                                widget.annonce.createdAt.month.toString() +
                                "/" +
                                widget.annonce.createdAt.year.toString(),
                            style: TextStyle(
                                fontSize: 13.0,
                                color: const Color(0x00000000).withOpacity(0.8),
                                fontFamily: "Mulish-SemiBold")),
                      ],
                    ),
                    Divider(
                      thickness: 1.0,
                      color: const Color(0x00000000).withOpacity(0.3),
                      height: 32.0,
                    ),
                    Text(
                      widget.annonce.description,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: const Color(0x00000000).withOpacity(0.8),
                        fontFamily: "Mulish-SemiBold",
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: const Color(0x00000000).withOpacity(0.3),
                      height: 32.0,
                    ),
                    Text(
                      widget.annonce.description_fr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: const Color(0x00000000).withOpacity(0.8),
                        fontFamily: "Mulish-SemiBold",
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
