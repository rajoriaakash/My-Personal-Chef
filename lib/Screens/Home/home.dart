import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/drawer.dart';
import 'package:my_personal_chef/Screens/Home/randomrecipecard.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/Screens/Home/searchabledropdown.dart';
import 'package:my_personal_chef/shared/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:my_personal_chef/shared/loading.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../services/auth.dart';
import 'package:my_personal_chef/Models/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};

  RecipeModel recipeModel = RecipeModel();

  final _key = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    return  SafeArea(
      child: Scaffold(
        key: _key,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
          'My Personal Chef',
          style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'NewTegomin',
          fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton.icon(
                onPressed: ()async{
                  await _auth.signout();
                },
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.black,),
                label: Text(
                    'Logout',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            SearchDropDown(),
            RandomRecipeCard(),
      ],
      ),
    )
    );
  }
}
