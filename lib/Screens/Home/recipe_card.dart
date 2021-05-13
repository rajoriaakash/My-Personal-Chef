import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/youtubeplayer.dart';
import 'package:my_personal_chef/services/auth.dart';


import 'package:my_personal_chef/services/database.dart';
import 'package:my_personal_chef/shared/loading.dart';


class RecipeCard extends StatefulWidget {

  // final String Name;
  // final String Category;
  // final String imgUrl;
  // final String Recipe;


  final RecipeModel recipeModel ;
   DatabaseService databaseService ;
  AuthService authService = AuthService();


  // List FavouriteList =[];

   RecipeCard({Key key, this.recipeModel}) : super(key: key);

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool _hasbeenpressed;
  String userId = AuthService().getUserbyId();
  String message='';
  

  @override
  Widget build(BuildContext context) {

    // var screenSize = MediaQuery.of(context).size;
    // var width = screenSize.width;
    // var height = screenSize.height;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .snapshots(),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Loading();
      }
      var userDocument = snapshot.data;
      List FavList = userDocument["FavList"];
      if(FavList.contains(widget.recipeModel.Name)){
        _hasbeenpressed =true;
      }
      else{
        _hasbeenpressed =false;
      }
      return Scaffold(
        body: Scrollbar(
          isAlwaysShown: true,
          thickness: 13,
          radius: Radius.circular(10.0),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 10.0),
                child: Card(
                  color: Colors.redAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.recipeModel.Name,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(height: 20.0,),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Category: " + widget.recipeModel.Type + " ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Text('|',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              Text(
                                " Area: " + widget.recipeModel.Area,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 100.0,
                                backgroundImage: NetworkImage(
                                  widget.recipeModel.imgUrl,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_outlined),
                              iconSize: 50.0,
                              color: _hasbeenpressed ? Colors.red : Colors.red
                                  .withOpacity(0.5),
                              onPressed: () async {
                                setState(() {
                                  _hasbeenpressed = !_hasbeenpressed;
                                });
                                print(_hasbeenpressed);
                                if (_hasbeenpressed == true) {
                                  setState(() {
                                    message = "Added to Favourites";
                                  });

                                  await DatabaseService().addToFav(
                                      userId: widget.authService.getUserbyId(),
                                      recipeName: widget.recipeModel.Name);
                                  print("add to favourite");
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,

                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    behavior: SnackBarBehavior.floating,
                                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))),

                                  ));
                                }
                                else {
                                  setState(() {
                                    message = "Removed from Favourites";
                                  });

                                  await DatabaseService().removeFromFav(
                                      userId: widget.authService.getUserbyId(),
                                      recipeName: widget.recipeModel.Name);
                                  print("Remove from favourites");
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,

                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    behavior: SnackBarBehavior.floating,
                                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))),

                                  ));
                                }
                                // print(Lists().FavouriteRecipes);
                              },
                            ),
                          ],
                        ),
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 0.0),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.recipeModel.ingredients.length,
                              itemBuilder: (context, index) {
                                return widget.recipeModel.ingredients[index]
                                    .toString()
                                    .isEmpty ?
                                null :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.recipeModel.ingredients[index],
                                        style: TextStyle(
                                            fontSize: 18.0
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        widget.recipeModel.measures[index],
                                        style: TextStyle(
                                            fontSize: 18.0
                                        ),),
                                    )
                                  ],
                                );
                              }
                          ),
                        ),
                        Divider(height: 10.0,),
                        SizedBox(height: 5.0,),
                        Center(child: Text(
                          "Instructions",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.recipeModel.Recipe,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(height: 20.0,),
                        Text(
                          "Recipe Video",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: ((c) =>
                                    Player(url: widget.recipeModel.vidUrl,))));
                          },
                          icon: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Click here',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}
