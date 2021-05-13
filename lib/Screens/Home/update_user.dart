import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/Screens/Home/change_password.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:my_personal_chef/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:convert';

import 'package:my_personal_chef/shared/loading.dart';


class UpdateUser extends StatefulWidget {

  const UpdateUser({Key key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  String name;
  String mobNo ;
  String userId = AuthService().getUserbyId();
  final _formkey = GlobalKey<FormState>();
  File image;
  final picker = ImagePicker();
  String profileString1;
  String profileString2;

  Future getImageByGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        Uint8List bytes = image.readAsBytesSync();
        profileString1 = base64Encode(bytes);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageByCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        Uint8List bytes = image.readAsBytesSync();
        profileString1 = base64Encode(bytes);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .snapshots(),
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Loading();
      }
      var userDocument = snapshot.data;
      name = userDocument["Name"];
      mobNo = userDocument["Mobile Number"];
      profileString2 = userDocument["Profile Picture"];


      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'NewTegomin',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black26,
                        backgroundImage: image==null ? MemoryImage(base64Decode(profileString2)) : FileImage(File(image.path)),
                        // backgroundImage: AssetImage('assets/category.jpg'),
                        radius: 70.0,
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
                          initialValue: name,
                          decoration: InputDecoration(
                            hintText: 'Enter your Name',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (val) {
                              name = val;
                          },
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
                          initialValue: mobNo,
                          decoration: InputDecoration(
                            hintText: 'Enter your Mobile No.',
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (val) {
                              mobNo = val;
                          },
                          validator: (val) =>
                           val.length!=10 ? 'Enter a Valid Mobile No.' : null,
                          textAlignVertical: TextAlignVertical.center,
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.6),
                            borderRadius: new BorderRadius.circular(10.0)
                        ),
                        child: TextButton.icon(
                            label: Text(
                              ' Change your password ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            icon: Icon(
                              Icons.lock_open_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>ChangePassword()));
                            }
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.6),
                            borderRadius: new BorderRadius.circular(10.0)
                        ),
                        child: TextButton.icon(
                            label: Text(
                              ' Update ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            icon: Icon(
                              Icons.person_pin_circle_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              if(_formkey.currentState.validate()){
                                print(name);
                                print(mobNo);
                                await DatabaseService(userId: userId).updateUser(
                                    Userc(Name: name, MobNo: mobNo,ImageString: profileString1));
                                Navigator.pop(context);
                              }
                            }
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImageByGallery,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      );
    }
    );
  }
}
