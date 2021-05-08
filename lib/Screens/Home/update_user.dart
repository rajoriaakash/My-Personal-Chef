import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  String name = '';
  String mobNo ='';
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
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
                      initialValue: '',
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      } ,
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
                      decoration: InputDecoration(
                        hintText: 'Enter your Mobile No.',
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (val) {
                        setState(() {
                          mobNo = val;
                        });
                      } ,
                      validator: (val) =>
                      val.isEmpty ? 'Enter a Mobile No.' : null,
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
                        onPressed: (){}
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
                        onPressed: (){}
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
