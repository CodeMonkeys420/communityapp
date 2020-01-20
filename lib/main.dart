import 'package:communityapp/screens/wrapper.dart';
import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,//checks user stream provider
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
     
  }
}
