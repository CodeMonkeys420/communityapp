import 'package:communityapp/shared/constance.dart';
import 'package:communityapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
      decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("Assets/61htWk5w.jpg"),
        fit: BoxFit.fill,
      ),
    ),
          child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.blue[400],
      elevation: 1.0,
      title: Text('Sign Up to Community Portal'),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('Sign in'),
          onPressed: () {
            widget.toggleView();
          },
        ),
      
      ],
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
                  child: Container(
      padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
      child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Image.asset('Assets/vdv.png'),
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
                 decoration: textInputDecoration.copyWith(hintText: 'Password',),
                validator: (val) => val.length <6 ? 'Longer password needed' : null,
               obscureText: true,
               onChanged: (val) {
                  setState(() => password = val);
                }
                ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.red[500],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  if(_formkey.currentState.validate()){
                    setState(() => loading = true) ;
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = 'please supply a valid email';
                    });
                    }
                   }
                  // else{
                  //   print('please use correct email or password')
                  // }
                },
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize:14),
              )
            ],
          ),
      ),
    ),
        ),
          ),
    );
  }
}
