import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_personal_chef/Screens/Home/recipes_by_category.dart';
class CategoryList extends StatefulWidget {
  final List categories;
  final List categoryIcon;
  const CategoryList({Key key, this.categories, this.categoryIcon}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent[100].withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0,
        title: Text('Categories'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.categories.length,
          itemBuilder: (context,index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
              child: Card(
                child: InkWell(
                  onTap: ()async{
                    var tempCatRec = Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categories[index]}");
                    http.Response response = await http.get(tempCatRec);
                    Map data = jsonDecode(response.body);
                    int count =data['meals'].length;
                    // print(count);
                    List categoryRecipes = [];
                    List recipeIcon = [];
                    for(var i =0; i<count ; i++){
                      categoryRecipes.add(data['meals'][i]['strMeal']);
                      recipeIcon.add(data['meals'][i]['strMealThumb']);
                    }
                    // print(categoryRecipes);
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>RecipesByCategory(categoryRecipes: categoryRecipes,recipeIcon: recipeIcon,)));
                  },
                  child: ListTile(
                    leading: Image(image: NetworkImage(widget.categoryIcon[index]),),
                    tileColor: Colors.blue[200].withOpacity(0.3),
                    selectedTileColor: Colors.black,
                    title: Text(
                      widget.categories[index],
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
