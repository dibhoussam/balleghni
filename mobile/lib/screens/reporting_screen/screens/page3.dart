import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:balighni/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Page3 extends StatelessWidget {
  final Function(dynamic) callbackdeleteimage;
  final Function(dynamic) callbackimage;
  final ImagePicker _picker = ImagePicker();
  List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(0, 0),
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /*  TProgress(
              hintText: "Proféssion",
              prefix: Icon(Icons.work),
            ),*/
            /* if (imgList.isNotEmpty)
              Container(
                  height: 200,
                  width: 1000,
                  child: ComplicatedImageDemo(imgList, callbackdeleteimage)),
            SizedBox(
              height: 15,
            ),*/
            DottedBorder(
              color: Colors.grey,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              dashPattern: [16, 8],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                height: 250,
                width: 250,
                //decoration: imgbackground1,
                child: Center(
                  child: getImgUploadInput(1),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (imgList.length > 0)
              DottedBorder(
                color: Colors.grey,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                dashPattern: [8, 4],
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  height: 250,
                  width: 250,
                  //decoration: imgbackground1,
                  child: Center(
                    child: getImgUploadInput(2),
                  ),
                ),
              ),
            if (imgList.length > 0)
              const SizedBox(
                height: 15,
              ),
            if (imgList.length > 1)
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                dashPattern: [8, 4],
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  height: 250,
                  width: 250,
                  //decoration: imgbackground1,
                  child: Center(
                    child: getImgUploadInput(3),
                  ),
                ),
              ),
            if (imgList.length > 1)
              const SizedBox(
                height: 15,
              ),
          ],
        ),
      ),
    );
  }

  Widget getImgUploadInput(int position) {
    if (imgList.length > position - 1) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 0),
              blurRadius: 3,
            ),
          ],
        ),
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.file(File(imgList[position - 1]),
                    fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        callbackdeleteimage(imgList[position - 1]);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(Icons.delete,
                                color: Colors.black)), //hna 1
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    } else {
      // imgbackground1 = BoxDecoration(
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          NeumorphicButton(
              margin: const EdgeInsets.only(top: 12),
              onPressed: () async {
                var myimage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (myimage != null) callbackimage(myimage);
              },
              style: NeumorphicStyle(
                color: HexColor("#06ade2"),
                shadowDarkColor: const Color(0xff06ade2),
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                "   إختر من الهاتف   ",
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 15,
          ),
          NeumorphicButton(
              margin: const EdgeInsets.only(top: 12),
              onPressed: () async {
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  // We didn't ask for permission yet or the permission has been denied before but not permanently.

                  if (await Permission.camera.request().isGranted) {
                    // Either the permission was already granted before or the user just granted it.

                    var myimage = await _picker.pickImage(
                        imageQuality: 90,
                        maxHeight: 1600,
                        maxWidth: 900,
                        preferredCameraDevice: CameraDevice.rear,
                        source: ImageSource.camera);
                    if (myimage != null) callbackimage(myimage);
                  } else {
                    Fluttertoast.showToast(
                        msg: "تصريح الة تصوير ناقص    ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  var myimage = await _picker.pickImage(
                      imageQuality: 90,
                      maxHeight: 1600,
                      maxWidth: 900,
                      preferredCameraDevice: CameraDevice.rear,
                      source: ImageSource.camera);
                  if (myimage != null) callbackimage(myimage);
                }
              },
              style: NeumorphicStyle(
                color: HexColor("#06ade2"),
                shadowDarkColor: const Color(0xff06ade2),
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                "   إلتقط صورة   ",
                style: TextStyle(color: Colors.white),
              ))
        ],
      );

      //   borderRadius: BorderRadius.circular(16), color: Colors.grey.shade100);
    }
  }

  Page3(this.callbackimage, this.imgList, this.callbackdeleteimage);
}

class ComplicatedImageDemo extends StatelessWidget {
  Function(dynamic) callbackdeleteimage;
  List<String> imgList;
  ComplicatedImageDemo(this.imgList, this.callbackdeleteimage);

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      // Image.file(file),
                      Image.file(File(item), fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              callbackdeleteimage(item);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Icon(Icons.delete,
                                      color: Colors.white)), //hna two
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ))
        .toList();
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imageSliders,
      ),
    );
  }
}
