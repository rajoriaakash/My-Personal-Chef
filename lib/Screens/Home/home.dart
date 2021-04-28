import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../services/auth.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton.icon(
              onPressed: ()async{
                await _auth.signout();

              },
              icon: Icon(Icons.person_outline_rounded,color: Colors.black,),
              label: Text('logout'))
        ],
      ),
    );
  }
}
