import 'package:communityapp/services/auth.dart';
import 'package:communityapp/shared/constance.dart';
import 'package:communityapp/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(backgroundColor: Colors.blue[400],
      elevation: 1.0,
      title: Text('Sign in to Community Portal'),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Register'),
          onPressed: () {
            widget.toggleView();
          },
        ),
      
      ],
      ),
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email',),
              validator: (val) => val.isEmpty ? 'Enter a email' : null,
              onChanged: (val) {
                
                setState(() => email = val);
              }
              ),
            SizedBox(height: 20.0,),
            TextFormField(
             obscureText: true,
             decoration: textInputDecoration.copyWith(hintText: 'Password',),
             validator: (val) => val.length <6 ? 'Enter a password' : null,
             onChanged: (val) {
                setState(() => password = val);
              }
              ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.red[500],
              child: Text(
                'Sign in',
                style: TextStyle(color: Colors.white)
              ),
              onPressed: () async{
                if(_formkey.currentState.validate()){
                  setState(() => loading = true) ;
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                   if(result == null){
                     setState(() {
                       setState(() => loading = false) ;
                       error = 'Could not sign in with those credentials';
                     } );
                   }
                 }
              },
            ),
                        SizedBox(height: 20),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize:14),),
          ],
        ),
      ),
    ),
    );

  }
}