import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Screens/Home/youtubeplayer.dart';
import 'dart:math';

class RecipeCard extends StatefulWidget {
  // final String Name;
  // final String Category;
  // final String imgUrl;
  // final String Recipe;
  final RecipeModel recipeModel ;

   RecipeCard({Key key, this.recipeModel,}) : super(key: key);

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool _hasbeenpressed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category: "+ widget.recipeModel.Type,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Text('|',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                      Text(
                        "Area: "+ widget.recipeModel.Area,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10.0),
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
                        icon: Icon(Icons.bookmark),
                        iconSize: 50.0,
                        color: _hasbeenpressed? Colors.red : Colors.red.withOpacity(0.5),
                        onPressed: () {
                          setState(() {
                            _hasbeenpressed = !_hasbeenpressed;
                            print(_hasbeenpressed);
                            if(_hasbeenpressed==true){
                              print("add to favourite");
                            }
                            else{
                              print("Remove from favourites");
                            }
                          });

                        },
                      ),
                    ],
                  ),
                  Divider(height: 10.0,),
                  SizedBox(height: 5.0,),
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((c)=>Player(url: widget.recipeModel.vidUrl,))));
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
    );
  }
}
