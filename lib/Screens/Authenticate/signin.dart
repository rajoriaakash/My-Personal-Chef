import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'register.dart';

class SignIn extends StatefulWidget {

  final Function Toggle;
  SignIn({this.Toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  bool hidePass = true;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          title: Text('Sign In'),
          actions: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  widget.Toggle();
                  },
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                label: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 30,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    'My Personal Chef',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'NewTegomin',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Email ID',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue)),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue)),
                          prefixIcon: Icon(Icons.vpn_key_rounded),
                        ),
                        validator: (val) => val.length < 6 ? 'Enter a password of more than 6 characters' : null,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: hidePass,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      trailing: IconButton(
                          focusColor: Colors.red,
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: ()async{
                        if(_formkey.currentState.validate()){
                          dynamic result = await _auth.signinwithemailandpassword(email, password);
                          if(result==null){
                            setState(() {
                              error = 'Could not Sign In \n Please supply a valid email';
                            });

                          }
                        }
                      },
                      child: Text(
                          'Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                      )
                  ),
                  SizedBox(height: 30.0,),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
