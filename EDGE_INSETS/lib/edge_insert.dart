import 'package:flutter/material.dart';

Widget edgeInsetsBox(
  String text,
  EdgeInsets padding,
  Color color, {
  Color textColor = Colors.white,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: 12,
      ),
    ),
  );
}
