import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference
final String uid;
DatabaseService({ this.uid });

  final CollectionReference userBookings = Firestore.instance.collection('Bookings');//table name
  //user booking table in firebase
  // Future updateUserData(Int AmmountPeople, String Date, int Price, ) async{
   //   return await userBookings.document(uid).setData({
     //fields come here dummy data or field names
  // })
  // }
  //below is func to add booking for user
  //the below code needs to be added to the bookings button etc.
  //  await DatabaseService(uid: user.uid).updateUserData('dummy','data',117);
  //just add field names/timestamps needed in stead of dummy data
}