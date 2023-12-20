

import 'package:eyecataract/about.dart';
import 'package:eyecataract/changepassword.dart';
import 'package:eyecataract/first.dart';
import 'package:eyecataract/home.dart';
import 'package:eyecataract/login.dart';
import 'package:eyecataract/reports.dart';
import 'package:eyecataract/second.dart';
import 'package:eyecataract/signup.dart';
import 'package:eyecataract/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eyecataract/account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      'first': (context) => First(),
      'login': (context) => MyLogin(),
      'home': (context) => Home(),
      'signup': (context) => MySignUp(),
      'second': (context) => Second(),
      'account': (context) => MyAccount(),
      //'name':(context)=>Name(),
      'reports': (context) => ReportPage(),
      'changepassword': (context) => ChangePassword(),
      'about': (context)=> AboutUs(),
    },
  ));
}
