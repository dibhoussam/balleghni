import 'package:flutter/material.dart';

class Picker extends StatelessWidget {


  Picker();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("Gallery");
      },
      child: Container(
        width: 260,
        height: 70,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 13, right: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(15)),
        child: Text(" Pick From Gallery "),
      ),
    );
  }
}
