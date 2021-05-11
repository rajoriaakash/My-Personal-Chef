import 'dart:convert';

import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;
import 'package:my_personal_chef/Screens/Home/recipes_by_ingredients.dart';

import 'package:my_personal_chef/shared/earch_widget.dart';


class IngredientsList extends StatefulWidget {
  final List ingredientsList;
  const IngredientsList({Key key, this.ingredientsList}) : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  String query = ' ';
  List ingredients;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ingredients = widget.ingredientsList;
  }
  @override
  Widget build(BuildContext context) {
    void searchIngredient(String query ){
      final ingredients = widget.ingredientsList.where((ingredient) {
        final ingredientLower = ingredient.toLowerCase();
        final searchLower = query.toLowerCase();

        return ingredientLower.contains(searchLower);
      }).toList();

      setState(() {
        this.query = query;
        this.ingredients = ingredients;
      });
    }
    Widget buildSearch() => SearchWidget(
      text: query,
      hintText: 'Search here ',
      onChanged: searchIngredient,
    );
    return Scaffold(
      backgroundColor: Colors.cyanAccent[100].withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0,
        title: Text('Ingredients'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
                    child: Card(
                      child: InkWell(
                        onTap: ()async{
                          var tempIngredientRec = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?i=${ingredients[index]}");
                          http.Response response = await http.get(tempIngredientRec);
                          Map data = jsonDecode(response.body);
                          int count =data['meals'].length;
                          // print(count);
                          List ingredientRecipes = [];
                          List recipeIcon = [];
                          for(var i =0; i<count ; i++){
                            ingredientRecipes.add(data['meals'][i]['strMeal']);
                            recipeIcon.add(data['meals'][i]['strMealThumb']);
                          }
                          // print(categoryRecipes);
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>RecipesByIngredient(ingredientRecipes: ingredientRecipes,recipeIcon: recipeIcon,)));
                        },
                        child: ListTile(
                          tileColor: Colors.blue[200].withOpacity(0.3),
                          selectedTileColor: Colors.black,
                          title: Text(
                            ingredients[index],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );

  }
}
