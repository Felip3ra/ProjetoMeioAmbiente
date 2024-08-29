import 'package:flutter/material.dart';
import 'package:hidro_tech/pages/loginPage.dart';
import 'package:hidro_tech/pages/signUpPage.dart';
import 'package:hidro_tech/pages/passwordPage.dart';
import 'package:hidro_tech/pages/codePage.dart';
import 'package:hidro_tech/pages/newPasswordPage.dart';
import 'package:hidro_tech/pages/homePage.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}