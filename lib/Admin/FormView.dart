import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:babasai_mission/Models/form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';

class FormView extends StatefulWidget {
  final FormModel formModel;
  final doc_id;
  FormView({this.formModel, this.doc_id});
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {

  int noOfItems = 1;

  @override
  Widget build(BuildContext context) {

    bool isApprove = widget.formModel.approval;
    bool isVisible = !isApprove;
    bool _isVisible = isApprove;

    return SafeArea(
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
        ),
        body: Builder(
          builder: (context) =>
           ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: " + widget.formModel.name,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Age: " +widget.formModel.age.toString() +" years",
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Standard: " +widget.formModel.std.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Percentage: " +widget.formModel.percentage.toString() +"%",
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Medium: " +widget.formModel.medium.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Father/Guardian Name: " +widget.formModel.FG.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Address: " +widget.formModel.address.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Contact: " +widget.formModel.contact.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "School: " +widget.formModel.school.toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Form Submitted: " +widget.formModel.publishedDate.toDate().toString(),
                            style: largeTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Email: " +widget.formModel.email,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Required Books: " +widget.formModel.subjects.toString(),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            "Total Books: " +widget.formModel.total.toString(),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text('Aadhar Card:', style: boldTextStyle),

                          SizedBox(height: 5,),

                          Stack(
                            children: [
                              Center(
                                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: widget.formModel.aadharUrl),
                              ),
                              Container(
                                color: Colors.grey[300],
                                child: SizedBox(
                                  height: 1.0,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 5,),

                          Text('Report Card:', style: boldTextStyle),

                          SizedBox(height: 5,),

                          Stack(
                            children: [
                              Center(
                                child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: widget.formModel.reportUrl),
                              ),
                              Container(
                                color: Colors.grey[300],
                                child: SizedBox(
                                  height: 1.0,
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: InkWell(
                          onTap: ()=> print("Clicked"),
                          child: Container(
                            // color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width - 40.0,
                            height: 50.0,

                            child: Visibility(
                              visible: isVisible,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                                child: Text(
                                  'Approve! ✅',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                color: Colors.purple,
                                onPressed: (){

                                  Firestore.instance.collection('forms').document(widget.doc_id).updateData({
                                    'approval': true,
                                  });
                                  print(widget.doc_id);
                                  isVisible = !isVisible;
                                  _showDialog(context);
                                  Navigator.pop(context, true);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: InkWell(
                          onTap: ()=> print("Clicked"),
                          child: Container(
                            // color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width - 40.0,
                            height: 50.0,

                            child: Visibility(
                              visible: _isVisible,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                                child: Text(
                                  'Revoke! 🚫',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                color: Colors.purple,
                                onPressed: (){

                                  Firestore.instance.collection('forms').document(widget.doc_id).updateData({
                                    'approval': false,
                                  });
                                  print(widget.doc_id);
                                  _isVisible = !_isVisible;
                                  _showDialog(context);
                                  Navigator.pop(context, true);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: InkWell(
                          onTap: ()=> print("Clicked"),
                          child: Container(
                            // color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width - 40.0,
                            height: 50.0,

                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0)),
                              child: Text(
                                'Delete form!🗑',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              color: Colors.purple,
                              onPressed: (){

                                Firestore.instance.collection('forms').document(widget.doc_id).delete();
                                print(widget.doc_id);
                                _isVisible = !_isVisible;
                                _showDialog(context);
                                Navigator.pop(context, true);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Approved ✅')));
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);