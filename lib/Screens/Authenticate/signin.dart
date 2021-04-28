import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text('Sign in anonymously'),
          onPressed: () async{
            dynamic result = await _auth.signinanon();
            print(result);
            print('success');
            if(result==null){print('failure');}
            else{print(result);}


          },
        ),
      ),
    );
  }
}
