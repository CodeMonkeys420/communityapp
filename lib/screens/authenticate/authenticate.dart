import 'package:communityapp/screens/authenticate/sign_in.dart';
import 'package:communityapp/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class Authenticate extends StatefulWidget {


  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleView(){
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return SignIn(toggleView: toggleView);//navigation if
    }else{
      return Register(toggleView: toggleView);
    }
  }
}