
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/features/home/controller/homecontroller.dart';
import 'package:weatherapp/features/shared/components/textcomponent.dart';
import 'package:weatherapp/features/shared/resources/colors.dart';
import 'package:weatherapp/features/shared/resources/dimens.dart';
import 'package:weatherapp/features/shared/route/routename.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    homecontroller.getCurrentLocation();




    Timer(Duration(seconds: 3), () {




      context.go(homeroute);
    });
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: getwidth(context: context),
        height: getheight(context: context),
        margin: EdgeInsets.symmetric(horizontal: 16),
        color:white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                height: 200,
                width: 200,
                'assets/icons/cloudy.png'
            ),
            SizedBox(
              height: 10,
            ),
            Textcomponent(
              text: 'Weather App',
              fontsize: 25.0,
              fontWeight: FontWeight.w800,
              color: tealcolor,
            )

          ],
        ),
      ),
    );
  }
}
