import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/wrapper.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userc>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}