import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:babasai_mission/Widgets/loadingWidget.dart';
import 'package:babasai_mission/Forms/file_extensions.dart';
import 'package:babasai_mission/DialogBox/errorDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Form1_10 extends StatefulWidget {
  @override
  _Form1_10State createState() => _Form1_10State();
}

class _Form1_10State extends State<Form1_10> with AutomaticKeepAliveClientMixin<Form1_10>{

  bool get wantKeepAlive => true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameControl = TextEditingController();
  TextEditingController _ageControl = TextEditingController();
  TextEditingController _stdControl = TextEditingController();
  TextEditingController _mediumControl = TextEditingController();
  TextEditingController _fgControl = TextEditingController();
  TextEditingController _addressControl = TextEditingController();
  TextEditingController _contactControl = TextEditingController();
  TextEditingController _schoolControl = TextEditingController();
  TextEditingController _totalControl = TextEditingController();

  File file;
  String fileName='No file selected';
  String formId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  Map<String, bool> subjects = {
    'English': false,
    'Marathi': false,
    'Hindi': false,
    'Sindhi': false,
    'Algebra': false,
    'Geometry': false,
  };

  var subArray = [];

  bool approvalVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '1-10',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: getForm(),
    );
  }

  getForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                uploading ? circularProgress() : Text(""),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: _nameControl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name.';
                      }
                    },
                    ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    controller: _ageControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your age.';
                      }
                    },
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Standard'),
                    controller: _stdControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your standard.';
                      }
                    },
                    ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Medium'),
                    controller: _mediumControl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your medium.';
                      }
                    },
                    ),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Name of Father/Guardian'),
                    controller: _fgControl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the name.';
                      }
                    },
                    ),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Residential Address'),
                    controller: _addressControl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the address.';
                      }
                    },
                    ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Contact No'),
                    controller: _contactControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the number.';
                      }
                    },
                    ),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Name of the school'),
                    controller: _schoolControl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the name.';
                      }
                    },
                    ),
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
                Center(
                  child: Text(
                    fileName
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Subjects:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
          SizedBox(
            height: 200,
            child :
            ListView(
              shrinkWrap: true,
              children: subjects.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: subjects[key],
                  activeColor: Colors.purple,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      subjects[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Total No. of Books'),
                    controller: _totalControl,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the number.';
                      }
                    },
                    ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "NOTE: BOOKS SHOULD BE RETURNED AFTER ACADEMIC YEAR.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Colors.purple,
                      onPressed: uploading ? null : () {
                        final form = _formKey.currentState;
                        if(fileName =='No file selected'){
                          _displayDialog('Please upload Ration Card');
                        }
                        else if (form.validate() && fileName!='No file selected') {
                          form.save();
                          //getCheckboxItems;
                          uploadImageAndSaveInfo();
                          _showDialog(context);
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
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
      if(file!=null) {
        fileName = file.name;
      }
    });
  }
  selectPhoto() async{
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
    setState(() {
      file = imageFile;
      if(file!=null) {
        fileName = file.name;
      }
    });
  }

  _displayDialog(String msg){
    showDialog(
        context: context,
        builder: (c){
          return ErrorAlertDialog(message: msg,);
        }
    );
  }


  uploadImageAndSaveInfo() async{
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
      "age" : int.parse(_ageControl.text),
      "std" : int.parse(_stdControl.text),
      "medium" : _mediumControl.text.trim(),
      "FG" : _fgControl.text.trim(),
      "address" : _addressControl.text.trim(),
      "contact" : int.parse(_contactControl.text),
      "school" : _schoolControl.text.trim(),
      "total" : int.parse(_totalControl.text),
      "rationUrl" : downloadUrl,
      "publishedDate" : DateTime.now(),
      //"subjects" : subArray,
      "approval" : approvalVal,
    });

    setState(() {
      file = null;
      fileName = 'No file selected';
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
      approvalVal = false;
    });

    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });

  }

  getCheckboxItems() {
    subjects.forEach((key, value) {
      if (value == true) {
        subArray.add(key);
      }
    });
  }
}
