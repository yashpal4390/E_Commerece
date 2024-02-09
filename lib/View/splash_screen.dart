// ignore_for_file: annotate_overrides, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        },
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/images/exam.jpg",
            height: MediaQuery.sizeOf(context).height * 1,
          ),
        ],
      ),
    );
  }
}
