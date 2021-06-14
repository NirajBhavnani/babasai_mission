import 'dart:async';
import 'dart:ui';
import 'package:babasai_mission/Config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authentication.dart';
import 'package:babasai_mission/Home/Home.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Babasai.auth = FirebaseAuth.instance;
  Babasai.sharedPreferences = await SharedPreferences.getInstance();
  Babasai.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Babasai Mission',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash(){
    Timer(Duration(seconds: 5), () async {
      if(await Babasai.auth.currentUser() != null){
        Route route = MaterialPageRoute(builder: (_)=> Home());
        Navigator.pushReplacement(context, route);
      }
      else{
        Route route = MaterialPageRoute(builder: (_)=> AuthenticScreen());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/Baba.jpg"),
              SizedBox(height: 20.0,),
              Text(
                  "Hari Om Babasai",
                style: TextStyle(color: Colors.purple, fontSize: 20.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}