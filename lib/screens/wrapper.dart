import 'package:communityapp/models/user.dart';
import 'package:communityapp/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    return Authenticate();
    //return home or authenticate widget
  }
}