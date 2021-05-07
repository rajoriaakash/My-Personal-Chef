import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_personal_chef/Screens/Home/recipes_by_area.dart';
import 'package:my_personal_chef/Screens/Home/recipes_by_category.dart';

class AreaList extends StatefulWidget {
  final List areasList;
  const AreaList({Key key, this.areasList}) : super(key: key);

  @override
  _AreaListState createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent[100].withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0,
        title: Text('Areas'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.areasList.length,
          itemBuilder: (context,index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
              child: Card(
                child: InkWell(
                  onTap: ()async{
                    var tempAreaRec = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?a=${widget.areasList[index]}");
                    http.Response response = await http.get(tempAreaRec);
                    Map data = jsonDecode(response.body);
                    int count =data['meals'].length;
                    // print(count);
                    List areaRecipes = [];
                    List recipeIcon = [];
                    for(var i =0; i<count ; i++){
                      areaRecipes.add(data['meals'][i]['strMeal']);
                      recipeIcon.add(data['meals'][i]['strMealThumb']);
                    }
                    // print(categoryRecipes);
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>RecipesByArea(areaRecipes: areaRecipes,recipeIcon: recipeIcon,)));
                  },
                  child: ListTile(
                    tileColor: Colors.blue[200].withOpacity(0.3),
                    selectedTileColor: Colors.black,
                    title: Text(
                      widget.areasList[index],
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
