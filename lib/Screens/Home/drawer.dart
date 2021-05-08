import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/Screens/Authenticate/register.dart';
import 'package:my_personal_chef/Screens/Home/update_user.dart';
import 'package:my_personal_chef/Screens/Home/contactus.dart';
import 'package:my_personal_chef/Screens/Home/fav_list.dart';
import 'package:my_personal_chef/Screens/Home/home.dart';
import 'package:my_personal_chef/services/auth.dart';
import 'package:my_personal_chef/services/database.dart';
import 'package:provider/provider.dart';

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
            return Text("Loading");
          }
          var userDocument = snapshot.data;
          String Name = userDocument["Name"];
          String Email = userDocument["Email"];
          return Drawer(
            key: _drawerkey,
            child: InkWell(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Name.isEmpty? Text(' Anonymous User ') : Text(
                          Name,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      accountEmail: Email.isEmpty? Text('') : Text(Email),
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.home_rounded),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => Home()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          title: Text('Home'),
                        ),
                        ListTile(
                          leading: Icon(Icons.person_rounded),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => UpdateUser()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          title: Text('My Account'),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite_outlined),
                          title: Text('Favourites'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => FavList()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        ListTile(
                          leading: Icon(Icons.contact_support_rounded),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => ContactUs()));
                          },
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
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
