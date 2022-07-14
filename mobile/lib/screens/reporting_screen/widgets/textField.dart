import 'package:flutter/material.dart';

import '../../../main.dart';

class TProgress extends StatelessWidget {
  String hintText;
  Widget prefix;
  final Function(dynamic) callback;

  TProgress(
      {required this.hintText, required this.prefix, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      //height:MediaQuery.of(context). ,
      decoration: BoxDecoration(
          border: Border.all(color: HexColor("#06ade2")),
          color: Colors.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        onChanged: callback,
        onSaved: callback,
        decoration: InputDecoration(
            prefixIcon: prefix,
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
