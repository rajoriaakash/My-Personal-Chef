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
  List ingredients;
  List measures;

  final RecipeModel recipeModel ;
  Meal({this.recipeModel,this.MealName,this.Recipe,this.Type,this.imgUrl,this.Name,this.Area,this.vidUrl,this.recId,this.ingredients,this.measures});

  Future<void> getRecipe(MealName) async{
    List ingredientsLocal = [];
    List measureLocal =[];
   var tempRec =  Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$MealName');
   http.Response response = await http.get(tempRec);
   // print(response);
   Map data = jsonDecode(response.body);
   // print(data);
   Map meals= data['meals'][0];
   List<String> allKeys = meals.keys.toList();

   for(String key in allKeys){
     if(key.startsWith("strIngredient")){
       var ingredient = meals[key];
       ingredientsLocal.add(ingredient);
     }
     if(key.startsWith("strMeasure")){
       var measure = meals[key];
       measureLocal.add(measure);
     }
   }
   Name = data['meals'][0]['strMeal'];
   Type = data['meals'][0]['strCategory'];
   ingredients = ingredientsLocal;
   measures = measureLocal;
   Recipe = data['meals'][0]['strInstructions'];
   imgUrl = data['meals'][0]['strMealThumb'];
   Area = data['meals'][0]['strArea'];
   vidUrl =data['meals'][0]['strYoutube'];
   recId =data['meals'][0]['idMeal'];


  }

  Future<void> getRandomRecipe() async{
    List ingredientsLocal = [];
    List measureLocal =[];
    var tempRec = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');
    http.Response response = await http.get(tempRec);
    Map data = jsonDecode(response.body);

    Map meals= data['meals'][0];
    List<String> allKeys = meals.keys.toList();

    for(String key in allKeys){
      if(key.startsWith("strIngredient")){
        var ingredient = meals[key];
        ingredientsLocal.add(ingredient);
      }
      if(key.startsWith("strMeasure")){
        var measure = meals[key];
        measureLocal.add(measure);
      }
    }
    // print(ingredients);
    Name = data['meals'][0]['strMeal'];
    Type = data['meals'][0]['strCategory'];
    ingredients = ingredientsLocal;
    measures = measureLocal;
    Recipe = data['meals'][0]['strInstructions'];
    imgUrl = data['meals'][0]['strMealThumb'];
    Area = data['meals'][0]['strArea'];
    vidUrl =data['meals'][0]['strYoutube'];
    recId =data['meals'][0]['idMeal'];

}
  void setIntoModel(RecipeModel recipeModel, Meal meal) {
    recipeModel.Name = meal.Name;
    recipeModel.Type = meal.Type;
    recipeModel.Area = meal.Area;
    recipeModel.imgUrl = meal.imgUrl;
    recipeModel.Recipe = meal.Recipe;
    recipeModel.vidUrl = meal.vidUrl;
    recipeModel.id = meal.recId;
    recipeModel.ingredients = meal.ingredients;
    recipeModel.measures = meal.measures;
  }
}
