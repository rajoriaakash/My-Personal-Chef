class RecipeModel {

  String id;
  String Recipe;
  String Name;
  String Type;
  String Area;
  String imgUrl;
  String vidUrl;
  List ingredients;
  List measures;

  RecipeModel({this.Recipe,this.Area, this.imgUrl,this.Name,this.Type,this.vidUrl,this.id,this.measures,this.ingredients});


}