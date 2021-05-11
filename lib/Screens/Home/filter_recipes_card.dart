import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:my_personal_chef/Screens/Home/areas_list.dart';
import 'package:my_personal_chef/Screens/Home/category_list.dart';
import 'package:my_personal_chef/Screens/Home/ingredients_list.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';


class FilterRecipes extends StatefulWidget {
  const FilterRecipes({Key key}) : super(key: key);

  @override
  _FilterRecipesState createState() => _FilterRecipesState();
}

class _FilterRecipesState extends State<FilterRecipes> {
  Map data={};

  RecipeModel recipeModel = RecipeModel();
  @override
  Widget build(BuildContext context){
  Meal object= Meal();
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              child: ListTile(
                leading: Icon(Icons.filter_alt_rounded),
                title: Text('Filter Recipes'),
                subtitle: Text('By Category, Cuisines, Ingredients'),
                trailing: Icon(Icons.keyboard_arrow_up),
              ),
              // icon: Icon(Icons.filter_alt_rounded),
              // label: Text("Filter Recipes "),
              onTap : ()async{
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: ()async{
                                var tempCat = Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
                                http.Response response = await http.get(tempCat);
                                Map data = jsonDecode(response.body);
                                print(data);
                                List categories = [];
                                List categoryicon =[];
                                for(var i =0; i<14 ; i++){
                                  // print(data['categories'][i]['strCategory']);
                                  categories.add(data['categories'][i]['strCategory']);
                                  categoryicon.add(data['categories'][i]['strCategoryThumb']);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (c) => CategoryList(categories: categories,categoryIcon: categoryicon,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.lightBlueAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text('Check out Recipes by Category'),
                                      subtitle: Text('Seafood, Vegetarian ,Chicken..'),
                                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: ()async{
                                var tempCat = Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?a=list');
                                http.Response response = await http.get(tempCat);
                                Map data = jsonDecode(response.body);
                                int count = data['meals'].length;
                                print(data);
                                List areas = [];
                                for(var i =0; i<count ; i++){
                                  // print(data['categories'][i]['strCategory']);
                                  areas.add(data['meals'][i]['strArea']);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (c) => AreaList(areasList: areas,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.lightBlueAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text('Check out Recipes by Cuisines'),
                                      subtitle: Text('Indian, Canadian, Chinese..'),
                                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: ()async{
                                var tempCat = Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?i=list');
                                http.Response response = await http.get(tempCat);
                                Map data = jsonDecode(response.body);
                                int count = data['meals'].length;
                                print(data);
                                List ingredients = [];
                                for(var i =0; i<count ; i++){
                                  // print(data['categories'][i]['strCategory']);
                                  ingredients.add(data['meals'][i]['strIngredient']);
                                }
                                Navigator.push(context, MaterialPageRoute(builder: (c) => IngredientsList(ingredientsList: ingredients,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.lightBlueAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text('Check out Recipes by Ingredients'),
                                      subtitle: Text('Eggs, Chicken, French Lentils'),
                                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                );
              }
          ),
        ),
      ),
    );
  }
}
