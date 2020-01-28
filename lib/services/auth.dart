import 'package:communityapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:communityapp/screens/home/home.dart';
class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on firebase user
User _userFromFirebaseUser(FirebaseUser user){

  //  userId(user.uid);

  // return user != null ? User(uid: user.uid) : null;
  userId(user?.uid ?? "no user");
  return user != null ? User(uid: user.uid) : null;


}

//auth change user stream
Stream<User> get user {
  return _auth.onAuthStateChanged
  // .map((FirebaseUser user) => _userFromFirebaseUser(user));
  .map(_userFromFirebaseUser);
}

//sign in anon
Future signInAnon() async{
try{
  AuthResult result = await _auth.signInAnonymously();
  FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
}
catch(e){
  print(e.toString());
  return null;
}
}
//sign in with email & pass
Future signInWithEmailAndPassword(String email, String password) async{
try{
  AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
  FirebaseUser user = result.user;
  return _userFromFirebaseUser(user);
  
}catch(e){
print(e.toString());
return null;

}
}

//register with email & pass
Future registerWithEmailAndPassword(String email, String password) async{
try{
  AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
  FirebaseUser user = result.user;
  return _userFromFirebaseUser(user);
  
}catch(e){
print(e.toString());
return null;

}
}


//sign out
Future signOut() async{
  try{
    return await _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
}
}