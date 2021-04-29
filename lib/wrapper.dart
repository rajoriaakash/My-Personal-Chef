import 'package:flutter/material.dart';
import 'package:my_personal_chef/Models/user.dart';
import 'package:my_personal_chef/Screens/Authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'Screens/Authenticate/authenticate.dart';
import 'Screens/Home/home.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userc>(context);
    print(user);

    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
