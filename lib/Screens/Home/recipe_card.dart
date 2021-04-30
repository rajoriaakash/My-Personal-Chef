import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecipeCard extends StatelessWidget {
  final String Name;
  final String Category;
  final String imgUrl;
  final String Recipe;

  const RecipeCard({Key key, this.Name, this.Category, this.imgUrl, this.Recipe}) : super(key: key);

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
                    Name,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(height: 20.0,),
                  Text(
                      "Category:  $Category",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(
                          imgUrl,
                      ),
                    ),
                  ),
                  Divider(height: 10.0,),
                  SizedBox(height: 5.0,),
                  Text(
                      Recipe,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
