import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/services/recipe.dart';

class Fav_Tile extends StatelessWidget {

  final String recipeName;
  RecipeModel recipeModel = RecipeModel();
  Meal object = Meal();
  Fav_Tile({this.recipeName}) {
    // await object.getRecipe(recipeName);
    // await object.setIntoModel(recipeModel, object);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(recipeModel.imgUrl),
          ),
          title: Text(recipeModel.Name),
          subtitle: Column(
            children: [
              Text(recipeModel.Type),
              Text(recipeModel.Area)
            ],
          )
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>RecipeCard(recipeModel: recipeModel)));
      },
    );
  }
}
