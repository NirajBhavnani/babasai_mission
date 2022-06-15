import 'dart:ui';

import 'package:babasai_mission/Admin/adminLogin.dart';
import 'package:babasai_mission/Authentication/forgotPassword.dart';
import 'package:babasai_mission/Widgets/customTextField.dart';
import 'package:babasai_mission/DialogBox/errorDialog.dart';
import 'package:babasai_mission/DialogBox/loadingDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:babasai_mission/Home/Home.dart';
import 'package:babasai_mission/Config/config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/login.png',
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login to your Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    data: Icons.email,
                    hintText: "Email",
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
            RaisedButton(
              onPressed: () {
                _emailController.text.isNotEmpty &&
                        _passController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorAlertDialog(
                            message: "Please write email and password",
                          );
                        });
              },
              color: Colors.purple,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              child: Text('Forgot Password ? ', style: TextStyle(
                decoration : TextDecoration.underline,
                color : Colors.purple,
                fontSize : 15 ,
                fontWeight: FontWeight.bold
              )),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => ForgotPassword()
              )),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.purple,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminSignInPage()));
              },
              icon: (Icon(
                Icons.admin_panel_settings,
                color: Colors.purple,
              )),
              label: Text(
                "I am Admin",
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please Wait...",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      //FirebaseFirestore.instance.collection("users").document(fUser.uid).get().then((dataSnapshot) async {
      //FirebaseFirestore.getInstance().collection("Users").document(phoneno).get().addOnCompleteListener(new OnCompleteListener<DocumentSnapshot>() {

      await Babasai.sharedPreferences
          .setString("uid", dataSnapshot.data[Babasai.userUID]);

      await Babasai.sharedPreferences
          .setString(Babasai.userEmail, dataSnapshot.data[Babasai.userEmail]);

      await Babasai.sharedPreferences
          .setString(Babasai.userName, dataSnapshot.data[Babasai.userName]);

      await Babasai.sharedPreferences.setString(
          Babasai.userAvatarUrl, dataSnapshot.data[Babasai.userAvatarUrl]);
    });
  }
}
