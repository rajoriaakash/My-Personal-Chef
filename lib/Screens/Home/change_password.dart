import 'package:flutter/material.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePassword extends StatefulWidget {
  static String id = 'change-password';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  String userId = AuthService().getUserbyId();

  final AuthService _auth = AuthService();

  String email;

  String emailOg;

  String message ='';


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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          var userDocument = snapshot.data;
          emailOg = userDocument['Email'];

          return Scaffold(
            appBar: AppBar(
              title: Text('Change Password'),
              centerTitle: true,
            ),
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
                        onChanged: (val) {
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
                        onPressed: () async {
                          if(email==emailOg){
                            await _auth.passwordReset(email);
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (c) => ConfirmEmail(message: message,)));
                            setState(() {
                              message = 'A reset password link has just been sent to your email';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          else{
                            setState(() {
                              message = 'Please provide the correct email !';
                            });
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                      ),
                      SizedBox(height: 30.0,),
                      // Text(
                      //     error,
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //     color: Colors.red,
                      //
                      //   )
                      // ),
                      // SnackBar(content: Text(error)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

