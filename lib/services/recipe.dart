import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';

class Meal{
  String MealName;

  String Name;
  String Recipe;
  String Type;
  String Area;
  String imgUrl;
  String vidUrl;
  String recId;
  final RecipeModel recipeModel ;
  Meal({this.recipeModel,this.MealName,this.Recipe,this.Type,this.imgUrl,this.Name,this.Area,this.vidUrl,this.recId});

  Future<void> getRecipe(MealName) async{
   var tempRec =  Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$MealName');
   http.Response response = await http.get(tempRec);
   // print(response);
   Map data = jsonDecode(response.body);
   print(data);
   Name = data['meals'][0]['strMeal'];
   Type = data['meals'][0]['strCategory'];
   Recipe = data['meals'][0]['strInstructions'];
   imgUrl = data['meals'][0]['strMealThumb'];
   Area = data['meals'][0]['strArea'];
   vidUrl =data['meals'][0]['strYoutube'];
   recId =data['meals'][0]['strId'];


  }

  Future<void> getRandomRecipe() async{
    var tempRec = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');
    http.Response response = await http.get(tempRec);
    Map data = jsonDecode(response.body);
    Name = data['meals'][0]['strMeal'];
    Type = data['meals'][0]['strCategory'];
    Recipe = data['meals'][0]['strInstructions'];
    imgUrl = data['meals'][0]['strMealThumb'];
    Area = data['meals'][0]['strArea'];
    vidUrl =data['meals'][0]['strYoutube'];
    recId =data['meals'][0]['strId'];

}
}
