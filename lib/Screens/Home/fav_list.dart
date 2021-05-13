import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/fav_tile.dart';
import 'package:my_personal_chef/services/recipe.dart';
import'package:my_personal_chef/services/auth.dart';


class FavList extends StatefulWidget {
  FavList({Key key}) : super(key: key);
  AuthService authService = AuthService();

  @override
  _FavListState createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  @override
  Widget build(BuildContext context) {
    Meal object= Meal();
    RecipeModel recipeModel = RecipeModel();
    String userId = widget.authService.getUserbyId();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          var userDocument = snapshot.data;
          List favList = userDocument["FavList"];
          favList.forEach((recipeName) {
            print(recipeName);
          });

          return Scaffold(
            appBar: AppBar(
              title: Text('Favourites'),
              centerTitle: true,
            ),
            body: favList.length==0 ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
              child: Center(child: Text('Oops!\nNo Favorite Recipes currently..',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              )),
            ) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: favList.length,
                  itemBuilder: (context,index) {
                    return Fav_Tile(recipeName: favList[index],);
                  }
              ),
            ),
          );
        }


    );
  }
}