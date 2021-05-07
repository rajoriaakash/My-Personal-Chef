import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/services/recipe.dart';

class RecipesByArea extends StatefulWidget {
  final List areaRecipes;
  final List recipeIcon;
  const RecipesByArea({Key key, this.areaRecipes, this.recipeIcon}) : super(key: key);

  @override
  _RecipesByAreaState createState() => _RecipesByAreaState();
}

class _RecipesByAreaState extends State<RecipesByArea> {
  RecipeModel recipeModel = RecipeModel();
  @override
  Widget build(BuildContext context) {
    Meal object= Meal();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFF85D36).withOpacity(0.8),
        title: Text('Recipes'),
        centerTitle: true,
      ),
      backgroundColor: Color(0XffFFFFBD71),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
            itemCount: widget.areaRecipes.length,
            itemBuilder: (context,index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 5.0),
                child: Card(
                  child: InkWell(
                    onTap: ()async{
                      await object.getRecipe(widget.areaRecipes[index]);
                      object.setIntoModel(recipeModel, object);
                      Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,)));

                    },
                    child: ListTile(
                      tileColor: Colors.orange[100].withOpacity(0.2),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.recipeIcon[index]),
                      ),
                      title: Text(widget.areaRecipes[index]),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
