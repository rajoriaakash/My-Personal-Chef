import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Screens/Authenticate/confirmEmail.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:my_personal_chef/services/database.dart';
import 'signin.dart';

class Register extends StatefulWidget {
  final Function Toggle;
  Register({this.Toggle});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  String name = '';
  bool _hasbeenpressed = false;
  bool hidePass = true;
  String message = 'An account confirmation email has just been sent to your email';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Register",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.brown[300],
          elevation: 0,
          leading: Icon(Icons.person_add_alt_1,color: Colors.black,),
          actions: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  widget.Toggle();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.black,
                  ),
                ))
          ],
        ),
        body:Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        'Welcome to \nMy Personal Chef',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'NewTegomin',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: new BorderRadius.circular(10.0)
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your Name',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          } ,
                          validator: (val) =>
                          val.isEmpty ? 'Enter a name' : null,
                          textAlignVertical: TextAlignVertical.center,
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
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your Email ID',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          } ,
                          validator: (val) =>
                          val.isEmpty ? 'Enter an email' : null,
                          textAlignVertical: TextAlignVertical.center,
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
                          contentPadding: EdgeInsets.all(8),
                          title: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              prefixIcon: Icon(Icons.vpn_key_rounded),
                            ),
                            validator: (val) => val.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: hidePass,
                            // net ninja
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          trailing: IconButton(
                              focusColor: Colors.red,
                              icon: Icon(Icons.remove_red_eye,
                                color: _hasbeenpressed? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePass = !hidePass;
                                  _hasbeenpressed = !_hasbeenpressed;
                                });
                              },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: new BorderRadius.circular(10.0)
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Confirm your password',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              prefixIcon: Icon(Icons.vpn_key_sharp),
                            ),
                            validator: (val) => val == password ? null : 'Passwords not matching',
                            textAlignVertical: TextAlignVertical.center,
                            obscureText: true,
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white30,
                            elevation: 0.5,
                          ),
                          onPressed: ()async{
                            if(_formkey.currentState.validate()){
                              dynamic result = await _auth.SignUp(email, password, name);
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>ConfirmEmail(message: message ,)));
                              if(result==null){
                                setState(() {
                                  error = 'Could not Register \n Please supply a valid email';
                                });

                              }
                            }
                          },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),

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
            ),
          ),
        )
    );
  }
}

