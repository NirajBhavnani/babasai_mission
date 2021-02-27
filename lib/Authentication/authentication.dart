import 'dart:ui';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:babasai_mission/Config/config.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Babasai Mission',
              style: TextStyle(fontSize: 45.0, color: Colors.white)
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.login, color: Colors.white),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person_add_alt_1, color: Colors.white),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}