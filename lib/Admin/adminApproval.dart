import 'package:babasai_mission/Admin/FormView.dart';
import 'package:babasai_mission/Models/form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminApproval extends StatefulWidget {
  @override
  _AdminApprovalState createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        color: Colors.purpleAccent.shade50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: Firestore.instance.collection("forms").where("approval", isEqualTo: true).orderBy("publishedDate", descending: true).snapshots(),
                builder: (context, snapshot){

                  if(snapshot.data == null) return CircularProgressIndicator();
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      DocumentSnapshot form = snapshot.data.documents[index];
                      FormModel modelRef = FormModel.fromJson(snapshot.data.documents[index].data);
                      var docId = form.documentID;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: ListTile(
                            title: Text(form["name"], style: TextStyle(color: Colors.black, fontSize: 18.0),),
                            subtitle: Text(form["std"].toString(), style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                            leading: CircleAvatar(
                              child: Icon(Icons.assignment),
                              foregroundColor: Colors.deepPurple,
                              backgroundColor: Colors.grey[300],
                            ),

                            onTap: ()
                            {
                              Route route = MaterialPageRoute(builder: (c)=> FormView(formModel: modelRef, doc_id: docId));
                              Navigator.push(context, route);
                            },
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
      ),
    );
  }
}
