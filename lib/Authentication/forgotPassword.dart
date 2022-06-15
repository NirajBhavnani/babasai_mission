import 'package:babasai_mission/Widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reset Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Builder(
          builder: (context) =>
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Receive an email to\nreset your password .",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: emailController,
                          data: Icons.email,
                          hintText: "Email",
                          isObsecure: false)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    color: Colors.purple,
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => resetPassword(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future resetPassword(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      _showDialog(context, 'Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print(e);
      _showDialog(context, e);
      Navigator.of(context).pop();
    }
  }
}
