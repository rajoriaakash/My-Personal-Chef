import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_chef/Models/recipemodel.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/services/auth.dart';

class DatabaseService{

  String userId;
  DatabaseService({this.userId});

  final CollectionReference userCollection =FirebaseFirestore.instance.collection('users');

  // AuthService authService = AuthService();

  //
  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // Future<String> getUserbyId() async{
  //   final User user = await auth.currentUser;
  //    return userId = user.uid;
  // }

  Future addUser( Userc userc ) async{
    return await userCollection.doc(userId).set({
      'Name' : userc.Name,
      'Email' : userc.Email,
      'FavList' : [],
    });
  }

  // Future addFav (String userId, List favList) async{
  //   return await userCollection.doc(userId).set({
  //     'FavList' : favList,
  //   });
  // }
  // DocumentReference doc_ref= userCollection.document();
  //
  // Future<String> get_data(DocumentReference doc_ref) async {
  //   DocumentSnapshot docSnap = await doc_ref.get();
  //   var doc_id2 = docSnap.reference.documentID;
  //   return doc_id2;
  // }

// //To retrieve the string
//   String documentID = await get_data();

  Future addToFav({String userId, String recipeName}) async {
    return await userCollection.doc(userId).update({
      'FavList' : FieldValue.arrayUnion([recipeName])
    });
  }

  Future removeFromFav({String userId, String recipeName}) async {
    return await userCollection.doc(userId ).update({
      'FavList' : FieldValue.arrayRemove([recipeName])
    });
  }


  //get stream from firestore
  // Stream<QuerySnapshot> get users{
  //   return userCollection.snapshots();
  // }
  //Get stream of Favourite List
  Stream<DocumentSnapshot> get FavList{
    return userCollection.doc(userId).snapshots();
  }

}