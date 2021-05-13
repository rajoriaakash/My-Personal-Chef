import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Screens/Home/update_user.dart';
import 'package:my_personal_chef/Screens/Home/contactus.dart';
import 'package:my_personal_chef/Screens/Home/fav_list.dart';
import 'package:my_personal_chef/Screens/Home/home.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:my_personal_chef/shared/loading.dart';

class AppDrawer extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
    String userId = authService.getUserbyId();
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          var userDocument = snapshot.data;
          String Name = userDocument["Name"];
          String Email = userDocument["Email"];
          String profileImage = userDocument["Profile Picture"];
          return Drawer(
            key: _drawerkey,
            child: InkWell(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(profileImage)),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // accountName: Name.isEmpty? Text(' Anonymous User ') : Text(
                      //     Name,
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //   ),
                      // ),
                      // accountEmail: Email.isEmpty? Text('') : Text(Email),
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Name==null? Text(' Anonymous User ') : Text(
                            Name,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Email==null? Text('') : Text(Email),
                        ),
                        ListTile(
                          leading: Icon(Icons.home_rounded,color:Colors.grey[900]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded,color:Colors.grey[900]),
                          title: Text('Home'),
                        ),
                        Email==null? ListTile(
                          leading: Icon(
                              Icons.person_rounded,
                            color: Colors.grey,
                          ),
                          onTap: () {
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color:Colors.grey[400]
                          ),
                          title: Text('My Account',
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                        ) :  ListTile(
                          leading: Icon(Icons.person_rounded,color:Colors.grey[900]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => UpdateUser()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded,color:Colors.grey[900]),
                          title: Text('My Account'),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite_outlined,color:Colors.grey[900]),
                          title: Text('Favourites'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => FavList()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded,color:Colors.grey[900]),
                        ),
                        ListTile(
                          leading: Icon(Icons.contact_support_rounded,color:Colors.grey[900]),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => ContactUs()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded,color:Colors.grey[900]),
                          title: Text('Contact Us'),
                        ),

                      ],
                    ),
                  ],
                )
            ),
          );
        },
    );
  }
}
