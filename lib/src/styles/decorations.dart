import 'package:flutter/material.dart';

final BoxDecoration backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Colors.deepPurple[200],
        Colors.deepPurple[300],
        Colors.deepPurple[400],
      ]),
);

final BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8.0),
  gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.indigo[800],
        Colors.indigo[700],
        Colors.indigo[600],
        Colors.indigo[400],
      ]),
);
