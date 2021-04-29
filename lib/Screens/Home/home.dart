import 'package:flutter/material.dart';
import 'package:my_personal_chef/services/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../services/auth.dart';
import 'package:my_personal_chef/Models/user.dart';

class Home extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  List<String> MealNames = ['Fish fofos','Flamiche','Carrot Cake'];
  @override
  Widget build(BuildContext context) {
    Recipe object= Recipe();
    Lists lists = Lists();

    GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
    final AuthService _auth = AuthService();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: InkWell(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(accountName: Text('User'), accountEmail:Text('Email')),
                  Column(
                    children: [
                      ListTile(
                        title: Text('Profile'),
                      )
                    ],
                  ),
                ],
              )
          ),
        ),
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
            SearchableDropdown(
              items: lists.MealNames.map((MealName){
                return DropdownMenuItem(
                  value: MealName,
                  child: Text("$MealName"),
                );
              }).toList(),
              onChanged: (val)async {
                  await object.getRecipe(val);
              },
            )
          ]
        ),
      ),
    );
  }
}
