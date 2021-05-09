import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
 String id = 'confirm-email';

class ConfirmEmail extends StatelessWidget {
   final String message;
  const ConfirmEmail({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}