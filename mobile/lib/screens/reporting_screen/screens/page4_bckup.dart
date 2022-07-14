import 'package:balighni/models/Incidents.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Page4 extends StatelessWidget {
  final Function() callbackConfirm;
  String? addr;
  List<Incident> typeinc;
  String? description;
  int? nbrimages;
  Page4(this.callbackConfirm, this.addr, this.typeinc, this.description,
      this.nbrimages);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "addr!",
                        style: TextStyle(
                            fontFamily: 'Wessam',
                            fontWeight: FontWeight.normal,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                      Text(
                        'عنوان : ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Wessam',
                            fontWeight: FontWeight.normal,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        typeinc.map((e) => e.title).toList().join(','),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Wessam',
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
                        'نوع المشكل  : ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: 'Wessam',
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Text(
                    'عدد الصور المأخوذة  : ' + nbrimages.toString(),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Wessam',
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  Text(
                    'وصف المشكل   : ' + description!,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Wessam',
                        fontWeight: FontWeight.normal,
                        fontSize: 28,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          /*InkWell(
            onTap: () async {
              print("tapped on container");
              callbackConfirm();
            },
            child: Container(
              width: 260,
              height: 70,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 13, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15)),
              child: Text("إرسال التقرير"),
            ),
          ),
          NeumorphicButton(
              margin: EdgeInsets.only(top: 12),
              onPressed: () async {
                callbackConfirm();
                //  var myimage = await _picker.pickImage(
                //    source: ImageSource.gallery);

                //  if(myimage!=null) callbackimage(myimage);
              },
              style: NeumorphicStyle(
                color: HexColor("#06ade2"),
                shadowDarkColor: Color(0xff06ade2),
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "   إرسال التقرير   ",
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 15,
          ),*/
        ],
      ),
    );
  }
}
