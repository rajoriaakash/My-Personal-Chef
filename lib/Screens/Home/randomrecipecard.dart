import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/shared/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';

class RandomRecipeCard extends StatefulWidget {
  @override
  _RandomRecipeCardState createState() => _RandomRecipeCardState();
}

class _RandomRecipeCardState extends State<RandomRecipeCard> {
  Map data={};

  RecipeModel recipeModel = RecipeModel();

  final _key = GlobalKey<ScaffoldState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Meal object= Meal();
    Lists lists = Lists();
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.lightBlueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.fastfood_rounded),
                    title: Text('Just for you!'),
                    subtitle: Text('Check out a random recipe'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/randomfood.jpg',
                      height: 200.0,
                    ),
                  )
                ]
            ),
          ),
        ),
        onTap: ()async{
          setState(() {
            loading = true;
          });
          await object.getRandomRecipe();
          recipeModel.Name = object.Name;
          recipeModel.Type = object.Type;
          recipeModel.Area = object.Area;
          recipeModel.imgUrl = object.imgUrl;
          recipeModel.Recipe = object.Recipe;
          recipeModel.vidUrl = object.vidUrl;
          recipeModel.id = object.recId;

          Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,)));
        },
      ),
    );
  }
}
