import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/features/shared/resources/colors.dart';

import 'features/shared/route/routeconfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: tealcolor, // navigation bar color
    statusBarColor: tealcolor, // status bar color
  ));


  runApp( MaterialApp.router(
    routerConfig: router,
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(
      useMaterial3: true,
    ).copyWith(),
  )

  );
}

