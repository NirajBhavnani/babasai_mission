import 'package:babasai_mission/Admin/FormView.dart';
import 'package:babasai_mission/Models/form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:babasai_mission/DialogBox/errorDialog.dart';
import 'package:babasai_mission/Models/controller.dart';
import 'package:babasai_mission/Models/googleForm.dart';

class AdminApproval extends StatefulWidget {
  @override
  _AdminApprovalState createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  TextEditingController _searchController = TextEditingController();

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Babasai Mission',
              style: TextStyle(color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'A mission for humanity through education',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.purpleAccent.shade50,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 5,),

              Text('Approved Forms:', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14, color: Colors.black,
              ),),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: (searchText != "" && searchText != null)
                      ? Firestore.instance
                      .collection('forms')
                      .where("searchKeywords", arrayContains: searchText).where("approval", isEqualTo: true)
                      .snapshots()
                      : Firestore.instance.collection("forms").where(
                      "approval", isEqualTo: true).orderBy(
                      "publishedDate", descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return CircularProgressIndicator();
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot form = snapshot.data.documents[index];
                        FormModel modelRef = FormModel.fromJson(snapshot.data
                            .documents[index].data);
                        var docId = form.documentID;

                        _displayDialog(String msg){
                          showDialog(
                              context: context,
                              builder: (c){
                                return ErrorAlertDialog(message: msg,);
                              }
                          );
                        }

                        void exportData(){
                          GoogleFormModel googleForm = GoogleFormModel(
                              modelRef.name,
                              modelRef.age,
                              modelRef.std,
                              modelRef.percentage,
                              modelRef.medium,
                              modelRef.FG,
                              modelRef.address,
                              modelRef.contact,
                              modelRef.school,
                              modelRef.publishedDate.toDate().toString(),
                              modelRef.email,
                              modelRef.subjects,
                              modelRef.total,
                              modelRef.other,
                              modelRef.aadharUrl,
                              modelRef.reportUrl
                          );
                          FormController formController = FormController(
                                  (String response){
                                print(response);
                                if(response == FormController.STATUS_SUCCESS){
                                  _displayDialog("Exported successfully");
                                }
                                else{
                                  _displayDialog("Export failure");
                                }
                              }
                          );
                          formController.exportForm(googleForm);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),
                            ),

                            child: ListTile(
                              title: Text("Name: " + form["name"] + " Std: " + form["std"].toString(), style: TextStyle(color: Colors.black, fontSize: 18.0),),
                              subtitle: Text("Form submitted: " +DateFormat.yMMMd().add_jm().format(form["publishedDate"].toDate()), style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                              leading: CircleAvatar(
                                child: Icon(Icons.assignment),
                                foregroundColor: Colors.deepPurple,
                                backgroundColor: Colors.grey[300],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.backup, color: Colors.deepPurple),
                                tooltip: 'Export record data',
                                onPressed: (){
                                  exportData();
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal:
                              10.0),
                              dense:true,

                              onTap: () {
                                Route route = MaterialPageRoute(builder: (c) =>
                                    FormView(formModel: modelRef, doc_id: docId));
                                Navigator.push(context, route);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
