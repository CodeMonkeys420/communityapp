import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/models/user.dart';
import 'package:communityapp/models/booking.dart';


class DatabaseService {
  //collection reference
final String uid;
DatabaseService({ this.uid });

  final CollectionReference userBookings = Firestore.instance.collection('Bookings');//table name
 
}