// import 'package:flutter/material.dart';
// import 'package:my_personal_chef/Models/recipemodel.dart';
// import 'package:my_personal_chef/Screens/Home/fav_tile.dart';
// import 'package:provider/provider.dart';
//
// class Fav_List extends StatefulWidget {
//   @override
//   _Fav_ListState createState() => _Fav_ListState();
// }
//
// class _Fav_ListState extends State<Fav_List> {
//   @override
//   Widget build(BuildContext context) {
//
//     final Favs = Provider.of<List<RecipeModel>>(context) ?? [];
//     Favs.forEach((Fav) {
//       print(Fav.id);
//       print(Fav.Name);
//     });
//     return ListView.builder(
//       itemCount: Favs.length,
//       itemBuilder: (context,index){
//         return Fav_Tile(recipeModel: Favs[index],);
//       },
//     );
//   }
// }
