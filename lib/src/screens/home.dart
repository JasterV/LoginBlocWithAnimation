import 'dart:async';

import 'package:animation/src/blocs/Provider.dart';
import 'package:animation/src/blocs/bloc.dart';
import 'package:animation/src/styles/decorations.dart';
import 'package:animation/src/widgets/box.dart';
import 'package:animation/src/widgets/cat.dart';
import 'package:animation/src/widgets/flap.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    catAnimation = Tween(begin: -18.0, end: -38.5).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );

    boxAnimation.addStatusListener(
      (status){
        if(status == AnimationStatus.completed){
          boxController.reverse();
        }else if(status == AnimationStatus.dismissed){
          boxController.forward();
        }
      }
    );

    catAnimation.addStatusListener(
      (status){
        if(status == AnimationStatus.completed){
          catController.reverse();
        }else if(status == AnimationStatus.dismissed){
          catController.forward();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 700,
          decoration: backgroundDecoration,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0),
                  animatedCatBox(bloc),
                  SizedBox(height: 50.0),
                  emailField(bloc),
                  SizedBox(height: 30.0),
                  passwordField(bloc),
                  SizedBox(height: 40.0),
                  submitButton(bloc)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'you@email.com',
            errorText: snapshot.error,
            labelStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Password',
              errorText: snapshot.error,
              labelStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70)),
          onChanged: bloc.changePassword,
          obscureText: true,
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: (snapshot.hasData) ? bloc.submit : null,
          child: Text('Login'),
          color: Colors.indigo,
          splashColor: Colors.indigoAccent,
        );
      },
    );
  }

  Widget animatedCatBox(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        if (snapshot.hasData) animateBox();
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            buildCatAnimation(),
            CatBox(),
            buildLeftFlapAnimation(),
            buildRightFlapAnimation(),
          ],
        );
      },
    );
  }

  void animateBox() {
    catController.forward();
    boxController.forward();
    Timer(const Duration(seconds: 2), () {
      catController.stop();
      boxController.stop();
    });
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildLeftFlapAnimation() {
    return AnimatedBuilder(
      animation: boxAnimation,
      builder: (context, child) {
        return Positioned(
          left: 8.0,
          top: 5.0,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          ),
        );
      },
      child: Flap(),
    );
  }

  Widget buildRightFlapAnimation() {
    return AnimatedBuilder(
      animation: boxAnimation,
      builder: (context, child) {
        return Positioned(
          right: 8.0,
          top: 5.0,
          child: Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          ),
        );
      },
      child: Flap(),
    );
  }
}
