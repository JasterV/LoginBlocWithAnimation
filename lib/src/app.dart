import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'blocs/Provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cat animation',
        home: Home(),
      ),
    );
  }
}
