import 'package:flutter/material.dart';

class TProgress extends StatelessWidget {
  String hintText;
  Widget prefix;
  TProgress({required this.hintText, required this.prefix});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: prefix,
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
