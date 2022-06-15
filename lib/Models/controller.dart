import 'package:babasai_mission/Models/googleForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbx4NrJKvEjYhayX3dWz8JN_hdU4aQrl1mJaozms3OkDE7P_bYkwcSUS7PUmOXJ-hmiIaQ/exec";

  static const STATUS_SUCCESS = "Success";

  FormController(this.callback);

  void exportForm(GoogleFormModel googleForm) async{
    try{
      await http.get(
        URL + googleForm.toParams()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });
    }
    catch(e){
      print(e);
    }
  }
}