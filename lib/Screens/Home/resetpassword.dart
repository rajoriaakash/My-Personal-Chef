import 'package:flutter/material.dart';

import 'package:my_personal_chef/Screens/Authenticate/signin.dart';
import 'package:my_personal_chef/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  String email;

  String message= '';

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,

        ),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),

    );
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Email',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                TextFormField(
                  onChanged: (val){
                    email = val;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Send Email'),
                  onPressed: () async{
                    if(email.contains("@"+".") ){
                      await _auth.passwordReset(email);
                      setState(() {
                        message = 'A reset password link has just been sent to your email';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                      setState(() {
                        message = 'Please provide a valid email';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                    // Navigator.push(context, MaterialPageRoute(builder: (c)=>ConfirmEmail(message: message,)));

                  },
                ),
                TextButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>SignIn()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}