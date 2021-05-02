import 'package:flutter/material.dart';
import 'package:my_personal_chef/Screens/Home/contactus.dart';
import 'package:my_personal_chef/Screens/Home/home.dart';

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
              UserAccountsDrawerHeader(accountName: Text('User'), accountEmail:Text('Email')),
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
