import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/services/auth.dart';

class DatabaseService{

  RecipeModel recipeModel = RecipeModel();
  String userId;

  DatabaseService({this.recipeModel,this.userId});

  final CollectionReference recipeCollection =FirebaseFirestore.instance.collection('recipes');

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> getUserbyId() async{
    final User user = auth.currentUser;
    final uid = user.uid;

  }

}