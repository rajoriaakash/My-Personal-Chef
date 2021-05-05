import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/shared/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchDropDown extends StatefulWidget {
  @override
  _SearchDropDownState createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  Map data={};

  RecipeModel recipeModel = RecipeModel();

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    Meal object= Meal();
    Lists lists = Lists();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: ListTile(
          title: SearchableDropdown(
              hint: Text('Search here'),
              isExpanded: true,
              items: lists.MealNames.map((MealName){
                return DropdownMenuItem(
                  value: MealName,
                  child: Text("$MealName"),
                );
              }).toList(),
              onChanged: (val)async {
                setState(() {
                  loading = true;
                });
                await object.getRecipe(val);
                object.setIntoModel(recipeModel, object);
                // recipeModel.Name = object.Name;
                // recipeModel.Type = object.Type;
                // recipeModel.Area = object.Area;
                // recipeModel.imgUrl = object.imgUrl;
                // recipeModel.Recipe = object.Recipe;
                // recipeModel.vidUrl = object.vidUrl;
                // recipeModel.id = object.recId;

                Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,)));
              }
          ),
          trailing: Icon(Icons.search),
        ),
      ),
    );
  }
}

