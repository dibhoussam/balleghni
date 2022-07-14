import 'package:balighni/models/Authorities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class MiniNewsCard extends StatelessWidget {
  final VoidCallback? callback;
  final Authoritie? authoritieData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  MiniNewsCard(
      {this.callback,
      this.authoritieData,
      this.animation,
      this.animationController});
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
              child: InkWell(
                onTap: () {
                  callback!();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: const BorderSide(
                              //                   <--- left side
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            right: const BorderSide(
                              //                   <--- Right side
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            top: const BorderSide(
                              //                   <--- Top side
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            bottom: BorderSide(
                              //                   <--- Bottom side
                              color: HexColor("#1074a8"),
                              width: 5.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 125, //ScreenUtil().setHeight(125.0),
                              width: 125, //ScreenUtil().setWidth(125.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(233, 233, 233, 1),
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
                                      authoritieData!.logo,
                                    )),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    authoritieData!.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                                    authoritieData!.description,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
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
              ),
            ),
          );
        });
  }
}
