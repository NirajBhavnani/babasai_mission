import 'dart:ui';
import 'package:babasai_mission/Admin/FormView.dart';
import 'package:babasai_mission/Admin/adminApproval.dart';
import 'package:babasai_mission/Home/Home.dart';
import 'package:babasai_mission/Models/form.dart';
import 'package:babasai_mission/Widgets/loadingWidget.dart';
import 'package:babasai_mission/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'adminLogin.dart';

class AdminHome extends StatefulWidget {

  final String user;
  AdminHome({ Key key, this.user }): super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Babasai Mission',
                style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'A mission for humanity through education',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              )
            ],
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.check_circle_outline, color: Colors.white,),
            onPressed: (){
              Route route = MaterialPageRoute(builder: (c)=> AdminApproval());
              Navigator.push(context, route);
            },
          ),
          actions: [
            IconButton(
              //child: Text('Log out', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
              icon: Icon(Icons.logout, color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
        body: getAdminHomeBody(),
      ),
    );
  }

  getAdminHomeBody(){
    return Container(
      color: Colors.purpleAccent.shade50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 25,),

            Text('Welcome Admin: '+ widget.user +" 😃", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20, color: Colors.purple,
            ),),
            SizedBox(height: 15,),

            Text('Pending Forms:', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, color: Colors.black,
            ),),

            SizedBox(height: 5,),

            StreamBuilder(
              stream: Firestore.instance.collection("forms").where("approval", isEqualTo: false).orderBy("publishedDate", descending: true).snapshots(),
              builder: (context, snapshot){

                if(snapshot.data == null) return CircularProgressIndicator();
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    DocumentSnapshot form = snapshot.data.documents[index];
                    FormModel modelRef = FormModel.fromJson(snapshot.data.documents[index].data);
                    var docId = form.documentID;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),

                        child: ListTile(
                          title: Text("Name: " + form["name"] + " Std: " + form["std"].toString(), style: TextStyle(color: Colors.black, fontSize: 18.0),),
                          subtitle: Text("Form submitted: " +form["publishedDate"].toDate().toString(), style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                          leading: CircleAvatar(
                            child: Icon(Icons.assignment),
                            foregroundColor: Colors.deepPurple,
                            backgroundColor: Colors.grey[300],
                          ),

                          onTap: ()
                          {
                            Route route = MaterialPageRoute(builder: (c)=> FormView(formModel: modelRef, doc_id: docId));
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,

      builder: (context) => new AlertDialog(
        title: new Text('Logout'),
        content: new Text('Confirm logout?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
            textColor: Colors.purple,
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
            textColor: Colors.purple,
          ),
        ],
      ),
    ) ?? false;
  }

}
