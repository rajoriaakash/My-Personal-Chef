import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;


  //creating a user object from firebase user
  Userc _userfromFirebaseUser (User user) {
    print(user.uid);
   return user !=null ? Userc(uid: user.uid, Email: user.email) : null;

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

    uid = user.uid;
    print(uid);
    await DatabaseService(userId: uid).addUser(_userfromFirebaseUser(user));

    return _userfromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }

  }
  //sign in with email and password
  Future signinwithemailandpassword (String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user;

      return _userfromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future SignUp(String email, String password,String name) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final User user = result.user;
      await user.sendEmailVerification();

      uid = user.uid;
      print(uid);
      await DatabaseService(userId: uid).addUser(Userc(uid: uid,Email: email,Name: name));
      // if(user.emailVerified){
      //   Navigator.push(context, MaterialPageRoute(builder: (c)=>ConfirmEmail()));
      // }
      return _userfromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  // Future registerwithemailandpassword(String email, String password)async{
  //
  // }

  String getUserbyId() {
    return  _auth.currentUser.uid;

  }

  //Sign out
  Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future passwordReset(String email)async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}