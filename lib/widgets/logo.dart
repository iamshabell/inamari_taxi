import 'package:flutter/material.dart';

Widget logo() {
  return RichText(
    textAlign: TextAlign.center,
    // ignore: prefer_const_constructors
    text: TextSpan(
      style: TextStyle(fontSize: 80),
      children: const <TextSpan>[
        TextSpan(
            text: "Ina",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
        TextSpan(
            text: 'Mari',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue)),
      ],
    ),
  );
}
