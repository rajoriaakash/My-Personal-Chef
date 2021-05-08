import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:my_personal_chef/services/database.dart';
import 'package:my_personal_chef/services/recipe.dart';

class Fav_Tile extends StatelessWidget {

  final String recipeName;
  RecipeModel recipeModel = RecipeModel();
  Meal object = Meal();
  Fav_Tile({this.recipeName});
  String userId = AuthService().getUserbyId();
    // await object.getRecipe(recipeName);
    // await object.setIntoModel(recipeModel, object);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: InkWell(
          child: ListTile(
            // leading: CircleAvatar(
            //   backgroundImage: NetworkImage(recipeModel.imgUrl),
            // ),
            title: Text(recipeName),
            subtitle: Text('View Recipe'),
            // subtitle: Column(
            //   children: [
            //     Text(recipeModel.Type),
            //     Text(recipeModel.Area)
            //   ],
            // )
            trailing: Container(
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.3),
                border: Border.all(
                  color: Colors.redAccent.withOpacity(0.01),
                ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              child: IconButton(
                icon: Icon(
                    Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
                onPressed: ()async{
                  await DatabaseService().removeFromFav(userId: userId,recipeName: recipeName);
                },
              ),
            ),
          ),
          onTap: ()async{
            await object.getRecipe(recipeName);
            object.setIntoModel(recipeModel, object);
            Navigator.push(context, MaterialPageRoute(builder: (c)=>RecipeCard(recipeModel: recipeModel)));
          },
        ),
      ),
    );
  }
}
