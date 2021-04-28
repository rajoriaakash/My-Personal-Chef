import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //creating a user object from firebase user
  Userc _userfromFirebaseUser (User user) {
   return user!=null ? Userc(uid: user.uid) : null;
  }
  //auth change user stream
  Stream <Userc> get user{
    return _auth.authStateChanges()
        .map((User user) => _userfromFirebaseUser(user));
  }
  //anonymous sign in
  Future signinanon() async{
    try{UserCredential result =  await _auth.signInAnonymously();
    final User user = result.user;
    print(user.uid);
    print(user);
    } catch(e){
      print(e.toString());

    }

  }
  //sign in with email and password
  //register with email and password
  //Sign out
Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }

}
}