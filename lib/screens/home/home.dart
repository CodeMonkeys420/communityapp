
import 'package:communityapp/screens/bookings/page.dart';
import 'package:communityapp/screens/home/Report.dart';
import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/shared/bottom_navy_bar.dart';
import 'post_page.dart';
import 'package:communityapp/screens/bookings/Gridview.dart';
import 'package:communityapp/screens/bookings/page.dart';

var UserID ;
final AuthService _auth = AuthService();
const PrimaryColor = const Color(0xFF151026);
bool FlagLoc = false;
final databaseReference = Firestore.instance;

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'community app',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: MyHomePage(),
    );
  }
}

var lat ;
var Lng ;



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {
  int currentIndex = 0;
 
  int _currentIndex = 0;

 Position _currentPosition;
  final List<Widget> _children = [
    NewsPG(),
     MyHomePageProfile(),
     ReportPg(),
     Facilities(),

  ];

static const platform = const MethodChannel('sendSms');

  Future<Null> sendSms()async {
    print("SendSMS");
    try {
      final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"0849871438","msg":"Hello! I'm sent programatically."}); //Replace a 'X' with 10 digit phone number
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context)  {
   getDataF();
   getData();
    _getCurrentLocation();


    if(_currentPosition != null)
    {

      lat="LAT: ${_currentPosition.latitude}" ;
      Lng= "LNG: ${_currentPosition.longitude}";
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
 FlatButton.icon(
                padding: const EdgeInsets.only(right: 60.0),
                 label: Text(''),
                icon: Icon(Icons.exit_to_app),
                //  label: Text('Log Out'),
                // icon: Icon(Icons.person),

                onPressed: ()async {
                   await _auth.signOut();
                },
             ),

            Image.asset(
              'Assets/vLogo.png',
              fit: BoxFit.contain,
              height: 20,
              scale: 1,
              alignment: Alignment.topCenter,
            ),
  
          ],
            
        ),
          actions: <Widget>[
      // action button

 


      IconButton(
      icon: Icon(Icons.error_outline),
      padding: const EdgeInsets.only(left: 50.0,right: 20.0),
      onPressed: () {
        _Alert(context);
           _getCurrentLocation();
          if (_currentPosition != null)
            {
              lat="LAT: ${_currentPosition.latitude}" ;
              Lng= "LNG: ${_currentPosition.longitude}";
              print("panic!!!@!@!@!");
              sendSms();
            }
      },
    ),]
      ),


      body:  _children[_currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Bookings'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.report_problem),
            title: Text('Report'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.local_activity),
            title: Text('Facilities'),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}








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

Future<void> _Alert(BuildContext context) {




  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Panic Alert'),
        content: const Text('This will send out a location to emergency contacts. Are you sure you you want to proceed?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
               Navigator.of(context).pop();
               if ( lat!= null)
                 {
                   print(lat +' '+Lng);
                  databaseReference.collection('Panic').document()
                  .setData({ 'Date': Timestamp.now(),'Location':
                  lat.toString()+' '+Lng.toString(),
                  'UserID':UserID});
                 }



            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();


            },
          )
        ],
      );
    },
  );
}




 class userId {

userId(var id ){

UserID = id;
}

}