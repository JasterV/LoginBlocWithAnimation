import 'package:flutter/material.dart';

class Flap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 60.0,
      height: 10.0,
    );
  }
}
