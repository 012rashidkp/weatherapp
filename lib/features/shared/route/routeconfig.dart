

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/features/home/presentation/homescreen.dart';
import 'package:weatherapp/features/search/presentation/searchscreen.dart';
import 'package:weatherapp/features/shared/route/routename.dart';
import 'package:weatherapp/features/splash/presentation/splashscreen.dart';

final router = GoRouter(
    initialLocation: splashroute,
    navigatorKey: GlobalKey<NavigatorState>(), // Add a GlobalKey for the navigator
    routes:[
      GoRoute(
        name: 'splash', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: splashroute,
        builder: (context, state) =>const Splashscreen(),
      ),
      GoRoute(
        name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: homeroute,
        builder: (context, state) =>const Homescreen(),
      ),
      GoRoute(
        name: 'search', // Optional, add name to your routes. Allows you navigate by name instead of path
        path: searchroute,
        builder: (context, state) =>const Searchscreen(),
      ),


    ]

);