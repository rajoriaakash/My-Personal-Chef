import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/services/recipe.dart';

class RecipesByCategory extends StatefulWidget {
  final List categoryRecipes;
  final List recipeIcon;
  const RecipesByCategory({Key key,this.categoryRecipes, this.recipeIcon}) : super(key: key);

  @override
  _RecipesByCategoryState createState() => _RecipesByCategoryState();
}

class _RecipesByCategoryState extends State<RecipesByCategory> {
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
            itemCount: widget.categoryRecipes.length,
            itemBuilder: (context,index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 5.0),
                child: Card(
                  child: InkWell(
                    onTap: ()async{
                      await object.getRecipe(widget.categoryRecipes[index]);
                      object.setIntoModel(recipeModel, object);
                      Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,)));

                    },
                    child: ListTile(
                      tileColor: Colors.orange[100].withOpacity(0.2),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.recipeIcon[index]),
                           ),
                      title: Text(widget.categoryRecipes[index]),
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
