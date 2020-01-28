import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/models/user.dart';
import 'package:communityapp/models/booking.dart';


class DatabaseService {
  //collection reference
final String uid;
DatabaseService({ this.uid});

  final CollectionReference userBookings = Firestore.instance.collection('Bookings');//table name
// <<<<<<< Postsv2
 
// =======
  
//   //user booking table in firebase
//   // Future updateUserData(Int AmmountPeople, String Date, int Price, ) async{
//    //   return await userBookings.document(uid).setData({
//      //fields come here dummy data or field names
//   // })
//   // }
//   //below is func to add booking for user
//   //the below code needs to be added to the bookings button etc.
//   //  await DatabaseService(uid: user.uid).updateUserData('dummy','data',117);
//   //just add field names/timestamps needed in stead of dummy data

//   //
//   // List<Booking> _bookingListFromSnapShot(QuerySnapShot){
//   //   return Snapshot.documents.map((doc){
//   //     return Booking(AmmountPeople: doc.data['AmmountPeople'] ?? '',
//   //     //return die ander field names nes hier bo
//   //     );
//   //   }).toList();
//   // }

//   // Stream<QuerySnapshot> get User {//he used brew in stead of user?
//   //   return userBookings.snapshots()
//   //   .map(_bookingListFromSnapShot);
//   // }
// >>>>>>> master
}