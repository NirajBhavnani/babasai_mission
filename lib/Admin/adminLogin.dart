import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babasai_mission/Authentication/authentication.dart';
import 'package:babasai_mission/Widgets/customTextField.dart';
import 'package:babasai_mission/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:babasai_mission/Admin/adminHome.dart';



class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Babasai Mission',
            style: TextStyle(fontSize: 40.0, color: Colors.white)
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIDController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/admin.png',
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                style: TextStyle(color: Colors.purple, fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _adminIDController,
                    data: Icons.person,
                    hintText: "ID",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passController,
                    data: Icons.lock,
                    hintText: "Password",
                    isObsecure: true, //if true then text will not appear
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0,),
            RaisedButton(
              onPressed: (){
                _adminIDController.text.isNotEmpty
                    && _passController.text.isNotEmpty
                    ? loginAdmin()
                    : showDialog(
                    context: context,
                    builder: (c){
                      return ErrorAlertDialog(message: "Please write email and password",);
                    }
                );
              },
              color: Colors.purple,
              child: Text("Login", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 50.0,),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.purple,
            ),
            SizedBox(height: 20.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthenticScreen()));
              },
              icon: (Icon(Icons.supervised_user_circle, color: Colors.purple,)),
              label: Text("I am not an Admin", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 50.0,),
          ],
        ),
      ),
    );
  }

  loginAdmin(){
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["id"] != _adminIDController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('No Admin found with this ID'),));
        }
        else if(result.data["password"] != _passController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Your Password is not correct'),));
        }
        else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Welcome Dear Admin, '+ result.data["name"]),));

          setState(() {
            _adminIDController.text= '';
            _passController.text= '';
          });

          Route route = MaterialPageRoute(builder: (c)=> AdminHome());
          Navigator.pushReplacement(context, route);

        }
      });
    });
  }

}