//Model Class for accessing cloud firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class FormModel {

  String name = '';
  int age;
  int std;
  String medium = '';
  String FG = '';
  String address = '';
  int contact;
  String school = '';
  int total;
  Timestamp publishedDate;
  String rationUrl;
  //String subjects;
  bool approval;

  FormModel(
      {this.name,
        this.age,
        this.std,
        this.medium,
        this.FG,
        this.address,
        this.contact,
        this.school,
        this.publishedDate,
        this.rationUrl,
        //this.subjects,
        this.total,
        this.approval,
      });

  FormModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    std = json['std'];
    medium = json['medium'];
    FG = json['FG'];
    address = json['address'];
    contact = json['contact'];
    school = json['school'];
    publishedDate = json['publishedDate'];
    rationUrl = json['rationUrl'];
    //subjects = json['subjects'];
    total = json['total'];
    approval = json['approval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['std'] = this.std;
    data['medium'] = this.medium;
    data['FG'] = this.FG;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['school'] = this.school;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['rationUrl'] = this.rationUrl;
    //data['subjects'] = this.subjects;
    data['total'] = this.total;
    data['approval'] = this.approval;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}