import 'package:babasai_mission/Authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:babasai_mission/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import 'package:babasai_mission/Forms/class_list.dart';
import 'package:babasai_mission/Models/form.dart';

double width;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _getEmail = Babasai.sharedPreferences.getString(Babasai.userEmail);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Babasai Mission',
                style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(
                  'A mission for humanity through education',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )
            ],
          ),

          leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
          backgroundImage: NetworkImage(
          Babasai.sharedPreferences.getString(Babasai.userAvatarUrl)
          ),
          ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white,),
                  onPressed: (){
                    Babasai.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                  tooltip: 'Log Out',
                ),
              ],
            ),
          ],
        ),
        body: getBody(),
      ),
    );
  }

  getBody(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.purpleAccent.shade50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Text("Welcome, " + Babasai.sharedPreferences.getString(Babasai.userName)+" 😃", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, color: Colors.purple,
            ),),
            SizedBox(height: 15,),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/bts.png',
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text('Apply', style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),),
                color: Colors.purple,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassList()));
                },
              ),
            ),
            SizedBox(height: 15,),

             Container(
               color: Colors.purpleAccent.shade50,
               width: MediaQuery.of(context).size.width,
               child: Column(
                 children: [
                   Text('Form Status:', style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 14, color: Colors.black,
                   ),),

                   SizedBox(height: 15,),

                   StreamBuilder(
                     stream: Firestore.instance.collection("forms").where("email", isEqualTo: _getEmail.toString()).orderBy("publishedDate", descending: true).snapshots(),
                     builder: (context, snapshot){

                       if(snapshot.data == null) return CircularProgressIndicator();
                       return ListView.builder(
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                         itemCount: snapshot.data.documents.length,
                         itemBuilder: (context, index){
                           DocumentSnapshot form = snapshot.data.documents[index];

                           return Padding(
                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                             child: Container(
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.grey),
                                 borderRadius: BorderRadius.circular(5.0),
                               ),

                               child: ListTile(
                                 title: Text("Name: " + form["name"] + " Std: " + form["std"].toString(), style: TextStyle(color: Colors.black, fontSize: 16.0),),
                                 subtitle: getStatus(form["approval"].toString()),
                                 leading: CircleAvatar(
                                   child: Icon(Icons.assignment),
                                   foregroundColor: Colors.deepPurple,
                                   backgroundColor: Colors.grey[300],
                                 ),

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
          ],
        ),
      ),
    );
  }
  getStatus(String approve){
    if(approve == 'true'){
      return Text('Your form is approved. Kindly collect your books within 1-2 days', style: TextStyle(color: Colors.green, fontSize: 14.0),);
    }
    if(approve == 'false'){
      return Text('Verification pending', style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14.0),);
    }
  }
}
