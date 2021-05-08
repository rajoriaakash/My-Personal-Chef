import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:my_personal_chef/Screens/Home/recipes_by_area.dart';
import 'package:my_personal_chef/Screens/Home/recipes_by_category.dart';
import 'package:my_personal_chef/shared/earch_widget.dart';

class AreaList extends StatefulWidget {
  final List areasList;
  const AreaList({Key key, this.areasList}) : super(key: key);

  @override
  _AreaListState createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  String query = '';

  List areas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    areas = widget.areasList;
  }
  @override
  Widget build(BuildContext context) {
    void searchArea(String query ){
        final areas = widget.areasList.where((area) {
        final areaLower = area.toLowerCase();
        final searchLower = query.toLowerCase();

        return areaLower.contains(searchLower);
      }).toList();

      setState(() {
        this.query = query;
        this.areas = areas;
      });
    }
    Widget buildSearch() => SearchWidget(
      text: query,
      hintText: 'Enter ',
      onChanged: searchArea,
    );


    return Scaffold(
      backgroundColor: Colors.cyanAccent[100].withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0,
        title: Text('Cuisines'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
                    child: Card(
                      child: InkWell(
                        onTap: ()async{
                          var tempAreaRec = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?a=${areas[index]}");
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
                            areas[index],
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
          ),
        ],
      ),
    );


  }
}
