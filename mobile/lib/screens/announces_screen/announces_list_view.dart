import 'package:balighni/main.dart';
import 'package:balighni/models/Announces.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnnouncesListView extends StatelessWidget {
  const AnnouncesListView(
      {Key? key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Announce? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#ffffff"), HexColor("#f0f5fb")],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            /*  AspectRatio(
                              aspectRatio: 2,

                                child: Image.network(
                                  hotelData?.file??"https://picsum.photos/200/300",
                                  fit: BoxFit.cover,
                                )
                             // child: Image.asset(
                           //     hotelData!.imagePath,
                             //   fit: BoxFit.cover,
                            //  ),
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          hotelData!.title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: HexColor("#304a77")
                                              // color: Colors.grey
                                              ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              hotelData?.authoritie?.name ??
                                                  "No Information Provided",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: HexColor("#3f81e2")
                                                      .withOpacity(0.8)),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                //  '${hotelData!.dist.toStringAsFixed(1)} km to city',
                                                "", //  ((hotelData!.createdAt.day.toString()+"/"+hotelData!.createdAt.month.toString()+"/"+hotelData!.createdAt.year.toString())+" "+hotelData!.createdAt.hour.toString()+":"+hotelData!.createdAt.minute.toString())??"no info",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                ((hotelData!.createdAt.day
                                                            .toString() +
                                                        "/" +
                                                        hotelData!
                                                            .createdAt.month
                                                            .toString() +
                                                        "/" +
                                                        hotelData!
                                                            .createdAt.year
                                                            .toString()) +
                                                    " " +
                                                    hotelData!.createdAt.hour
                                                        .toString() +
                                                    ":" +
                                                    hotelData!.createdAt.minute
                                                        .toString()),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 8, right: 16, top: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          hotelData!.authoritie!.logo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                //gradient: LinearGradient(colors:[HexColor("#ffffff"),HexColor("#f0f5fb")] ,begin:Alignment.centerLeft ,end:Alignment.centerRight ) ,
                                border: Border(
                                  bottom: BorderSide(
                                    //                   <--- left side
                                    color: HexColor("#1074a8"),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Divider(
                                    indent: 16,
                                    endIndent: 16,
                                    thickness: 0.70,
                                    color: Colors.grey[400],
                                    height: 4.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          child: Text(
                                            hotelData?.description ??
                                                "No Information Provided",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /*  Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: HotelAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )*/
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
