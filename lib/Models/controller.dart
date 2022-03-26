import 'package:babasai_mission/Models/googleForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbwrdGwZPDQ7GX_Wt0ficnb-6A8mjWyHPAW4tU4Y5F0SRI-Nf2JYMoXIfdcq999GWl5rsw/exec";

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