//Model Class for accessing cloud firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class FormModel {

  String name = '';
  int age;
  int std;
  double percentage;
  String medium = '';
  String FG = '';
  String address = '';
  int contact;
  String school = '';
  int total;
  Timestamp publishedDate;
  String reportUrl;
  String aadharUrl;
  String subjects;
  bool approval;
  String email;
  String other;
  var searchKeywords = [];

  FormModel(
      {this.name,
        this.age,
        this.std,
        this.percentage,
        this.medium,
        this.FG,
        this.address,
        this.contact,
        this.school,
        this.publishedDate,
        this.reportUrl,
        this.aadharUrl,
        this.subjects,
        this.total,
        this.approval,
        this.email,
        this.other,
        this.searchKeywords
      });

  FormModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    std = json['std'];
    percentage = json['percentage'];
    medium = json['medium'];
    FG = json['FG'];
    address = json['address'];
    contact = json['contact'];
    school = json['school'];
    publishedDate = json['publishedDate'];
    reportUrl = json['reportUrl'];
    aadharUrl = json['aadharUrl'];
    subjects = json['subjects'];
    total = json['total'];
    approval = json['approval'];
    email = json['email'];
    other = json['other'];
    searchKeywords = json['searchKeywords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['std'] = this.std;
    data['percentage'] = this.percentage;
    data['medium'] = this.medium;
    data['FG'] = this.FG;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['school'] = this.school;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['reportUrl'] = this.reportUrl;
    data['aadharUrl'] = this.aadharUrl;
    data['subjects'] = this.subjects;
    data['total'] = this.total;
    data['approval'] = this.approval;
    data['email'] = this.email;
    data['other'] = this.other;
    data['searchKeywords'] = this.searchKeywords;
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