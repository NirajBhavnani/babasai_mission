import 'dart:io';
import 'dart:ui';
import 'package:babasai_mission/Widgets/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:babasai_mission/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class Form11_12 extends StatefulWidget
{
  @override
  _Form11_12State createState() => _Form11_12State();
}

class _Form11_12State extends State<Form11_12> with AutomaticKeepAliveClientMixin<Form11_12>
{
  bool get wantKeepAlive => true;

  File file;
  String formId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  TextEditingController _nameControl = TextEditingController();
  TextEditingController _ageControl = TextEditingController();
  TextEditingController _stdControl = TextEditingController();
  TextEditingController _mediumControl = TextEditingController();
  TextEditingController _fgControl = TextEditingController();
  TextEditingController _addressControl = TextEditingController();
  TextEditingController _contactControl = TextEditingController();
  TextEditingController _schoolControl = TextEditingController();
  TextEditingController _totalControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '11-12',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: getForm(),
    );
  }
  getForm(){
    return ListView(
      children: [
        uploading ? circularProgress() : Text(""),
        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Name', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _nameControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Age', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _ageControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Std', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _stdControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Med', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _mediumControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Father', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _fgControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Add', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _addressControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Contact', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _contactControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'School', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _schoolControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        ListTile(
          title: Container(
            width: 250.0,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Total', hintStyle: TextStyle(color: Colors.purple), border: InputBorder.none),
              controller: _totalControl,
            ),
          ),
        ),
        Divider(color: Colors.purpleAccent,),

        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
            child: Text('Upload Ration Card', style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),),
            color: Colors.purple,
            onPressed: () {
              takeImage(context);
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0,),
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
            child: Text('Save', style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),),
            color: Colors.purple,
            onPressed: uploading ? null : () => _uploadForm(),
          ),
        ),
      ],
    );
  }

  _uploadForm() async{
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadImageFile(file);

    saveFormInfo(imageDownloadUrl);
  }

  Future<String> uploadImageFile(myFile) async{
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("Forms");
    StorageUploadTask uploadTask = storageReference.child("Form_$formId.jpg").putFile(myFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveFormInfo(String downloadUrl){
    final formsRef = Firestore.instance.collection("forms");
    formsRef.document(formId).setData({
      "name" : _nameControl.text.trim(),
      "age" : _ageControl.text.trim(),
      "std" : _stdControl.text.trim(),
      "medium" : _mediumControl.text.trim(),
      "FG" : _fgControl.text.trim(),
      "address" : _addressControl.text.trim(),
      "contact" : _contactControl.text.trim(),
      "school" : _schoolControl.text.trim(),
      "total" : _totalControl.text.trim(),
      "rationUrl" : downloadUrl,
      "publishedDate" : DateTime.now(),
    });

    setState(() {
      file = null;
      uploading = false;
      formId = DateTime.now().millisecondsSinceEpoch.toString();
      _nameControl.clear();
      _ageControl.clear();
      _stdControl.clear();
      _mediumControl.clear();
      _fgControl.clear();
      _addressControl.clear();
      _contactControl.clear();
      _schoolControl.clear();
      _totalControl.clear();
    });
  }

  takeImage(mContext){
    return showDialog(
        context: mContext,
        builder: (con){
          return SimpleDialog(
            title: Text('Upload Ration Card', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text('Capture with Camera', style: TextStyle(color: Colors.purple,),),
                onPressed: capturePhotoCam,
              ),
              SimpleDialogOption(
                child: Text('Select from Gallery', style: TextStyle(color: Colors.purple,),),
                onPressed: selectPhoto,
              ),
              SimpleDialogOption(
                child: Text('Cancel', style: TextStyle(color: Colors.purple,),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  capturePhotoCam() async{
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = imageFile;
    });
  }
  selectPhoto() async{
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
    setState(() {
      file = imageFile;
    });
  }

}