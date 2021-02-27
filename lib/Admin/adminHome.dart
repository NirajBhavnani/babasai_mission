import 'dart:ui';
import 'package:babasai_mission/Admin/adminApproval.dart';
import 'package:babasai_mission/main.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Babasai Mission',
            style: TextStyle(fontSize: 30.0, color: Colors.white)
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.border_color, color: Colors.white,),
          onPressed: (){
            Route route = MaterialPageRoute(builder: (c)=> AdminApproval());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          IconButton(
            //child: Text('Log out', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
            icon: Icon(Icons.logout, color: Colors.white,),
            onPressed: (){
              Route route = MaterialPageRoute(builder: (c)=> SplashScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
      body: getAdminHomeBody(),
    );
  }

  getAdminHomeBody(){
    return Container(
      color: Colors.purpleAccent.shade50,
    );
  }

}
