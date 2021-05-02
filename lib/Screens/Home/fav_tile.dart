import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';

class Fav_Tile extends StatelessWidget {
  final RecipeModel recipeModel;
  Fav_Tile({this.recipeModel});
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
