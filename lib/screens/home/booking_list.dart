import 'package:flutter/material.dart';
import 'package:communityapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    
    // final booking = Provider.of<QuerySnapshot>(context);
    // //check terminal for firebase record feedback
    // for(var doc in booking.documents){
    //   print(doc.data);
    // }
     return Container(
      
     );
  }
}