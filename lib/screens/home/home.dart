import 'package:communityapp/screens/home/booking_list.dart';
import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapShot>.value(
          value: DatabaseService().User,//he used brew in stead of user
          child: Scaffold(
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
          body: BookingList(),
      ),
    );
  }
}