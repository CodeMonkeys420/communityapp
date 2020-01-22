import 'package:communityapp/shared/bottom_navy_bar.dart';
import 'package:communityapp/screens/wrapper.dart';
import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:communityapp/shared/nav.dart';

import 'models/user.dart';

void main() => runApp(MyApp());


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

class MyApp extends StatefulWidget {


  
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,//checks user stream provider
          child: MaterialApp(
        home: Wrapper(),
      ),
    );

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
        ];
      
    
    }
}
