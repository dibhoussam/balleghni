import 'package:balighni/app_home_screen.dart';
import 'package:balighni/main.dart';
import 'package:balighni/models/Authorities.dart';
import 'package:balighni/models/Branchs.dart';
import 'package:balighni/provider/AnnouncesProvider.dart';
import 'package:balighni/screens/announces_screen/announces_home_screen.dart';
import 'package:balighni/screens/authorities_screen/MiniCard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//listOfDownloadedFile.where((element) => element.Url == "your URL link")
class AuthoritieDetailsScreen extends StatefulWidget {
  final Authoritie authoritie;

  /*= Authoritie(
      description: "je sais que c'est longtemps mais j'essye d'étre tres patient good luck",
      id: 45,
      logo: "logo",
      name: 'name',
      branchs: [Branch(id: 77), Branch(id: 55),Branch(id: 55)]);
*/
  const AuthoritieDetailsScreen({Key? key, required this.authoritie})
      : super(key: key);

  @override
  _AuthoritieDetailsScreen createState() => _AuthoritieDetailsScreen();
}

class _AuthoritieDetailsScreen extends State<AuthoritieDetailsScreen> {
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
                  'دلـيل المؤسسـات',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
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
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Consumer<AnnouncesProvider>(
                                      builder: (_,
                                          AnnouncesProvider announcesprovider,
                                          __) {
                                    return AnnouncesHomeScreen(
                                        announcesprovider.announces);
                                  }))),
                      child: const ImageIcon(
                        AssetImage("assets/bell.gif"),
                        //FontAwesomeIcons.solidBell,
                        color: Colors.yellow,
                        size: 30,
                      ),
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
    return Scaffold(
      //backgroundColor: const Color(0xFF363646),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getAppBarUI(),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3F4F9),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 125, //ScreenUtil().setHeight(125.0),
                                width: 125, //ScreenUtil().setWidth(125.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(233, 233, 233, 1),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(0, 0),
                                      blurRadius: 1,
                                    ),
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: CachedNetworkImageProvider(
                                        widget.authoritie!.logo,
                                      )),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      widget.authoritie!.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Divider(
                                      indent: 0,
                                      endIndent: 0,
                                      thickness: 0.3,
                                      color: Colors.grey[400],
                                      height: 10.0,
                                    ),
                                    Text(
                                      widget.authoritie!.description,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(139, 144, 165, 1),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                indent: 40,
                // empty space to the leading edge of divider.
                endIndent: 40,
                thickness: 1.0,
                color: const Color(0xFFFFFFFF).withOpacity(0.3),
                height: 32.0,
              ),
              if (widget.authoritie.branchs!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFFF3F4F9),
                      //color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "الوكالات التجارية",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF23233C),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: (widget.authoritie.branchs?.length ?? 0),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              makeCard(widget.authoritie.branchs![index]),
                              const SizedBox(
                                height: 5.0,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ]),
      ),
    );
  }

  Card makeCard(Branch lesson) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black,
        //color: const Color(0xFF363646),
        color: Colors.blueAccent,
        elevation: 16.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              //  color: const Color(0xFFF3F4F9),
              color: Colors.white,
              border: Border.all(color: Colors.white)),
          child: makeListTile(lesson),
        ),
      );

  ListTile makeListTile(Branch lesson) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),

        title: Column(
          children: [
            Text(
              (lesson.location?.commune?.name ?? "unknown"),
              textAlign: TextAlign.center,
              //lesson.location.wilaya ?? "no localisation ",
              style: const TextStyle(
                  color: Color(0xFF23233C), fontWeight: FontWeight.bold),
            ),
            Text(
              (lesson.location?.daira?.name ?? "unknown"),
              //lesson.location.wilaya ?? "no localisation ",
              style: const TextStyle(
                  color: Color(0xFF23233C), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Column(
          children: <Widget>[
            const SizedBox(
              height: 5.0,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (lesson.phones?.length ?? 0),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Image.asset('assets/Icon/call.png'),
                        //   "Phone : "+lesson.phones[0].phone??"No Description Provided",
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: lesson.phones![index].phone))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("تم نسخ رقم الهاتف")));
                          });
                        },
                      ),
                    ),
                    const Text("   :الهاتف",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Mulish-SemiBold"))
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/Icon/Email.png'),
                  //   "Phone : "+lesson.phones[0].phone??"No Description Provided",
                  onPressed: () {
                    Clipboard.setData(
                            ClipboardData(text: lesson.email ?? "No Mail"))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("تم نسخ موقع البريد الالكتروني")));
                    });
                  },
                ),
                const Text("   :البريد الالكتروني",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Mulish-SemiBold"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assets/Icon/Localisation.png'),
                  //   "Phone : "+lesson.phones[0].phone??"No Description Provided",
                  onPressed: () {
                    Clipboard.setData(
                            ClipboardData(text: lesson.mapLink ?? "No MapLink"))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("تم نسخ موقع الموقع الجغرافي")));
                    });
                  },
                ),
                const Text("   :الموقع على الخريطة ",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Mulish-SemiBold"))
              ],
            )
          ],
        ),
      );
}
