import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/areas_list.dart';
import 'package:my_personal_chef/Screens/Home/category_list.dart';
import 'package:my_personal_chef/Screens/Home/drawer.dart';
import 'package:my_personal_chef/Screens/Home/randomrecipecard.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/Screens/Home/searchabledropdown.dart';
import 'package:my_personal_chef/shared/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:my_personal_chef/shared/loading.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../services/auth.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'dart:math';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchDropDown(),
              RandomRecipeCard(),
              InkWell(
                onTap: ()async{
                  var tempCat = Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
                  http.Response response = await http.get(tempCat);
                  Map data = jsonDecode(response.body);
                  print(data);
                  List categories = [];
                  List categoryicon =[];
                  for(var i =0; i<14 ; i++){
                    // print(data['categories'][i]['strCategory']);
                    categories.add(data['categories'][i]['strCategory']);
                    categoryicon.add(data['categories'][i]['strCategoryThumb']);
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (c) => CategoryList(categories: categories,categoryIcon: categoryicon,)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Check out Recipes by Category'),
                        subtitle: Text('Seafood, Vegetarian ,Chicken..'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
                ),
                ),
              InkWell(
                onTap: ()async{
                  var tempCat = Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?a=list');
                  http.Response response = await http.get(tempCat);
                  Map data = jsonDecode(response.body);
                  int count = data['meals'].length;
                  print(data);
                  List areas = [];
                  for(var i =0; i<count ; i++){
                    // print(data['categories'][i]['strCategory']);
                    areas.add(data['meals'][i]['strArea']);
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (c) => AreaList(areasList: areas,)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Check out Recipes by Areas'),
                        subtitle: Text('Indian, Canadian, Chinese..'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
                ),
              ),

      ],
      ),
        ),
    )
    );
  }
}
