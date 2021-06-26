import 'dart:ui';

import 'package:babasai_mission/Forms/Form11_12.dart';
import 'package:babasai_mission/Forms/Form1_10.dart';
import 'package:babasai_mission/Forms/FormFY.dart';
import 'package:babasai_mission/Forms/FormSY.dart';
import 'package:babasai_mission/Forms/FormTY.dart';
import 'package:flutter/material.dart';

class ClassList extends StatefulWidget {
  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Your Class/Standard',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: getList(),
    );
  }

  Widget getList(){
    var listView = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.arrow_forward, color: Colors.purple,),
          title: Text(
              '1-10',
            style: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18.0
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Form1_10()));
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward, color: Colors.purple,),
          title: Text(
            '11-12',
            style: TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18.0
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Form11_12()));
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward, color: Colors.purple,),
          title: Text(
            'FY',
            style: TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18.0
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FormFy()));
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward, color: Colors.purple,),
          title: Text(
            'SY',
            style: TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18.0
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FormSy()));
          },
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward, color: Colors.purple,),
          title: Text(
            'TY',
            style: TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18.0
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FormTy()));
          },
        ),
      ],
    );
    return listView;
  }

}
