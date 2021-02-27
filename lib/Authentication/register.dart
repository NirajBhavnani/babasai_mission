import 'dart:io';
import 'package:babasai_mission/Widgets/customTextField.dart';
import 'package:babasai_mission/DialogBox/errorDialog.dart';
import 'package:babasai_mission/DialogBox/loadingDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:babasai_mission/Home/Home.dart';
import 'package:babasai_mission/Config/config.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>
{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height; //it's done so that widget size adapt with different device screen size
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10.0,),
            InkWell(
              onTap: ()=> _selectAndPickImage(),
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage: _imageFile==null ? null : FileImage(_imageFile),
                child: _imageFile == null
                ?Icon(Icons.add_a_photo, size: _screenWidth * 0.15, color: Colors.grey,)
                :null,
              ),
            ),
            SizedBox(height: 8.0,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
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
                  CustomTextField(
                    controller: _cpassController,
                    data: Icons.lock,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: (){
                _uploadAndSaveImage();
              },
              color: Colors.purple,
              child: Text("Sign Up", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 30.0,),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.purple,
            ),
            SizedBox(height: 15.0,),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> _uploadAndSaveImage() async {
    if(_imageFile==null){
      showDialog(
        context: context,
        builder: (c){
          return ErrorAlertDialog(message: 'Please select your profile picture',);
        }
      );
    }
    else{
      _passController.text == _cpassController.text
          ? _emailController.text.isNotEmpty &&
          _passController.text.isNotEmpty &&
          _cpassController.text.isNotEmpty &&
          _nameController.text.isNotEmpty
          ? _uploadToStorage()
          : _displayDialog("Please fill up the entire form")
          : _displayDialog("Passwords do not match");
    }
  }

  _displayDialog(String msg){
    showDialog(
      context: context,
      builder: (c){
        return ErrorAlertDialog(message: msg,);
      }
    );
  }

  _uploadToStorage() async {
    showDialog(
        context: context,
      builder: (c){
          return LoadingAlertDialog(message: 'Registering, Please wait.....',);
      }
    );

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage){
      userImageUrl = urlImage;

      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {

    FirebaseUser firebaseUser;

    await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
    ).then((auth){
      firebaseUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog
        (
          context: context,
          builder: (c){
            return ErrorAlertDialog(message: error.message.toString(),);
          }
      );
    });

    if(firebaseUser !=null){
      saveUserInfoToFirestore(firebaseUser).then((value){
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c)=> Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future<void> saveUserInfoToFirestore(FirebaseUser fUser) async{
    Firestore.instance.collection('users').document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameController.text.trim(),
      "url": userImageUrl,
    });

    await Babasai.sharedPreferences.setString("uid", fUser.uid);
    await Babasai.sharedPreferences.setString(Babasai.userEmail, fUser.email);
    await Babasai.sharedPreferences.setString(Babasai.userName, _nameController.text);
    await Babasai.sharedPreferences.setString(Babasai.userAvatarUrl, userImageUrl);
    //await Babasai.sharedPreferences.setString("uid", fUser.uid);
  }
}


