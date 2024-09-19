import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidro_tech/pages/graphsPage.dart';
import 'package:hidro_tech/pages/loginPage.dart';
import 'package:hidro_tech/pages/profilePage.dart';
import 'package:hidro_tech/pages/signUpPage.dart';
import 'package:hidro_tech/pages/passwordPage.dart';
import 'package:hidro_tech/pages/codePage.dart';
import 'package:hidro_tech/pages/newPasswordPage.dart';
import 'package:hidro_tech/pages/homePage.dart';
import 'package:hidro_tech/pages/connectPage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Roter(),
    );
  }
}

class Roter extends StatelessWidget {
  const Roter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(),builder: (context, snapshot){
      if (snapshot.hasData) {
        return homePage();
      }
      else{
        return loginPage();
      }
    });
  }
}