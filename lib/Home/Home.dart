import 'package:babasai_mission/Authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:babasai_mission/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import 'package:babasai_mission/Forms/class_list.dart';

String selectedCategory = "Your Approvals";
double width;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = ["Your Approvals","Pending Approvals"];
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
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return CategorieTile(
                      text: categories[index],
                      isSelected: selectedCategory == categories[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

}

class CategorieTile extends StatefulWidget {

  final String text;
  final bool isSelected;
  CategorieTile({this.text, this.isSelected});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){

        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 12),
              child: Text(widget.text, style: TextStyle(
                  color: widget.isSelected ? Colors.black87 : Colors.grey,
                  fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: widget.isSelected ? 20 : 15
              ),),
            ),
            SizedBox(height: 3,),
            widget.isSelected ? Container(
              height: 5,
              width: 16,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12)
              ),
            ) : Container()
          ],
        )
    );
  }
}
