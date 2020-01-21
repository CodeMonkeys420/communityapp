import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.blue[200],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('Log Out'),
              icon: Icon(Icons.person),
              onPressed: ()async {
                 await _auth.signOut();
              },
            )
          ],
        ),
    );
  }
}