import 'package:animation/src/styles/decorations.dart';
import 'package:flutter/material.dart';

class CatBox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      height: 95.0,
      width: 95.0,
    );
  }
}