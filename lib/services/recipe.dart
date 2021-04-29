import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

class Recipe{
  String MealName;

  Recipe({this.MealName});
  Future<void> getRecipe(MealName) async{
   var tempRec =  Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$MealName');
   http.Response response = await http.get(tempRec);
   Map data = jsonDecode(response.body);
   print(data);
  }
}
