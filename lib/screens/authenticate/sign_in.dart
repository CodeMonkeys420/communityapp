import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(backgroundColor: Colors.blue[400],
      elevation: 1.0,
      title: Text('Sign in to Community Portal'),),
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
      child: RaisedButton(child: Text('Sign in Anon'),
      onPressed: () async{
        dynamic result = await _auth.signInAnon();
        if(result == null){
          print('error signing in');
        }else{
          print('Signed in');
          print(result);
        }
      },
      ),
    ),
    );

  }
}