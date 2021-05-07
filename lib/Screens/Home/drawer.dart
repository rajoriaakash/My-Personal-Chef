import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/Screens/Authenticate/register.dart';
import 'package:my_personal_chef/Screens/Home/contactus.dart';
import 'package:my_personal_chef/Screens/Home/fav_list.dart';
import 'package:my_personal_chef/Screens/Home/home.dart';
import 'package:my_personal_chef/services/database.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
    return Drawer(
      key: _drawerkey,
      child: InkWell(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(Userc().Name??'Loading Name..'
                  ),
                  accountEmail:Text(Userc().Email?? 'Loading Email..'
                  )),
              Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(c)=> Home()));
                    },
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    title: Text('Home'),
                  ),
                  ListTile(
                    title: Text('My Account'),
                  ),
                  ListTile(
                    title: Text('Favourites'),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>FavList()));
                    },
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(c)=> ContactUs()));
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
  }
}
