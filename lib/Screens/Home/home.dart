import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/recipe_card.dart';
import 'package:my_personal_chef/services/lists.dart';
import 'package:my_personal_chef/services/recipe.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../services/auth.dart';
import 'package:my_personal_chef/Models/user.dart';

class Home extends StatelessWidget {
  Map data={};
  RecipeModel recipeModel = RecipeModel();
  // Map rdata={};
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    Meal object= Meal();
    Lists lists = Lists();
    // var random = randomChoice(lists.MealNames);
    // print(random);

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
                        title: Text('Home'),
                      ),
                      ListTile(
                        title: Text('My Account'),
                      ),
                      ListTile(
                        title: Text('Favourites'),
                      ),
                      ListTile(
                        title: Text('Contact Us'),
                      ),

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
            Padding(
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
                      await object.getRecipe(val);
                        // data = {
                        //   'Name': object.Name,
                        //   'Type': object.Type,
                        //   'imgUrl': object.imgUrl,
                        //   'Recipe': object.Recipe,
                        // };
                        recipeModel.Name = object.Name;
                        recipeModel.Type = object.Type;
                        recipeModel.imgUrl = object.imgUrl;
                        recipeModel.Recipe = object.Recipe;
                        recipeModel.vidUrl = object.vidUrl;

                        Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,
                            // Name: data['Name'],
                            // Category: data['Type'],
                            // imgUrl: data['imgUrl'],
                            // Recipe: data['Recipe']
                        )
                        )
                        );
                    }
                  ),
                  trailing: Icon(Icons.search),
                ),
              ),
            ),
            // Card(
            //   child: InkWell(
            //     onTap: ()async{
            //       await object.getRecipe(random);
            //       rdata = {
            //         'Name': object.Name,
            //         'Type': object.Type,
            //         'imgUrl': object.imgUrl,
            //         'Recipe': object.Recipe,
            //       };
            //       Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(
            //           Name: rdata['Name'],
            //           Category: rdata['Type'],
            //           imgUrl: rdata['imgUrl'],
            //           Recipe: rdata['Recipe']
            //       )
            //       )
            //       );
            //     },
            //     child: Image.network('www.themealdb.com/api/json/v1/1/search.php?s=$random'),
            //   ),
            // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5.0),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: NetworkImage('https://thefederal.com/file/2020/04/different-types-of-food-on-rustic-wooden-table-picture-id861188910.jpg')
                // ),
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
              await object.getRandomRecipe();
              recipeModel.Name = object.Name;
              recipeModel.Type = object.Type;
              recipeModel.imgUrl = object.imgUrl;
              recipeModel.Recipe = object.Recipe;
              recipeModel.vidUrl = object.vidUrl;

              Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(recipeModel: recipeModel,)));
              // data = {
              //   'Name': object.Name,
              //   'Type': object.Type,
              //   'imgUrl': object.imgUrl,
              //   'Recipe': object.Recipe,
              // };
              //
              // Navigator.push(context,MaterialPageRoute(builder: (c)=> RecipeCard(
              //     Name: data['Name'],
              //     Category: data['Type'],
              //     imgUrl: data['imgUrl'],
              //     Recipe: data['Recipe']
              // )
              // )
            },
          ),
        ),
      ],
      ),
    )
    );
  }
}
