import 'package:communityapp/models/booking.dart';
import 'package:communityapp/screens/home/booking_list.dart';
import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/shared/bottom_navy_bar.dart';
import 'package:communityapp/shared/nav.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  
      Map<int, Color> color =
{
  50:Color.fromRGBO(217,180,111, .1),
  100:Color.fromRGBO(217,180,111, .2),
  200:Color.fromRGBO(217,180,111, .3),
  300:Color.fromRGBO(217,180,111, .4),
  400:Color.fromRGBO(217,180,111, 1),//change .5 na 1 vir die login button fix
  500:Color.fromRGBO(217,180,111, .6),
  600:Color.fromRGBO(217,180,111, .7),
  700:Color.fromRGBO(217,180,111, .8),
  800:Color.fromRGBO(217,180,111, .9),
  900:Color.fromRGBO(217,180,111, 1),
};
//waar die color func assign word
MaterialColor colorCustom = MaterialColor(0xFFd9b46f, color);
//color insert word
const PrimaryColorTwo = const Color(0xFFd9b46f);


  @override
  Widget build(BuildContext context) {
    // StreamProvider<QuerySnapShot>.value(       //he used brew in stead of user
    //       value: DatabaseService().Booking,    


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
          body: BookingList(),

//hier kom die nav bar
           int currentIndex = 0;
  int _currentIndex = 0;

     var colorCustom2 = colorCustom;
          bottomNavigationBar: BottomNavyBar(
             selectedIndex: _currentIndex,
             showElevation: true,
             itemCornerRadius: 8,
             onItemSelected: (index) {
               setState(() => 
               _currentIndex = index);
             } );
             items: [
               BottomNavyBarItem(
                 icon: Icon(Icons.home),
                 title: Text('Home'),
                 activeColor: colorCustom,
               ),
               BottomNavyBarItem(
                 icon: Icon(Icons.mail),
                 title: Text('Messages'),
                 activeColor: colorCustom,
               ),
               BottomNavyBarItem(
                 icon: Icon(Icons.person),
                 title: Text('Profile'),
                 activeColor: colorCustom,
               ),
               BottomNavyBarItem(
                 icon: Icon(Icons.report_problem),
                 title: Text('Report'),
                 activeColor: colorCustom,
               ),
               BottomNavyBarItem(
                 icon: Icon(Icons.local_activity),
                 title: Text('Facilities'),
                 activeColor: colorCustom2,
          ),
      );
  }
}