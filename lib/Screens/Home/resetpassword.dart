import 'package:flutter/material.dart';
import 'package:my_personal_chef/Screens/Authenticate/confirmEmail.dart';
import 'package:my_personal_chef/services/auth.dart';

class ForgotPassword extends StatelessWidget {
  static String id = 'forgot-password';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email;
  String message= 'A reset password link has just been sent to your email';

  @override
  Widget build(BuildContext context) {
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
                RaisedButton(
                  child: Text('Send Email'),
                  onPressed: () async{
                    await _auth.passwordReset(email);
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>ConfirmEmail(message: message,)));

                  },
                ),
                FlatButton(
                  child: Text('Sign In'),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}