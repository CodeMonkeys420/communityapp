import 'package:flutter/material.dart';

import 'package:communityapp/screens/bookings/Gridview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var nameList ;
var numL ;
var dateL;
var PlaceL;
int counter =0;
var BookingsL = new List();
var AlreadyBookedD = new List();
var BookedID = new List();
var timeL ;
var DeletedId;

String sanitizeDateTime(DateTime dateTime) => "${dateTime.year}-${dateTime.month}-${dateTime.day}";

Set<String> getDateSet(List<DateTime> dates) => dates.map(sanitizeDateTime).toSet();

class BookList extends StatefulWidget {


  @override
  BookListState createState() => BookListState();
}


class BookListState extends State<BookList> {




  @override
  Widget build(BuildContext context) {

    return new  Scaffold( appBar: AppBar(
      title: Text("Bookings Made"),

    ),
        body:

        DeleteItemInListViewPopupMenu()


    );

  }

 

}


class NameL{

  NameL(var name , var num, var date, var time, var place , var counterOne ,var DeleteID){
    nameList = name;
    numL = num;
    dateL = date;
    timeL = time;
    PlaceL = place;
    counter= counterOne;
     DeletedId = DeleteID;
    BookedID.add(DeletedId);
    BookingsL.add(PlaceL+' '+nameList+' '+numL+' '+ dateL+' '+time);
    AlreadyBookedD.add(Place+' '+(sanitizeDateTime(bookingsDate)).toString()+' '+time);

    print(BookedID);
  }




}


int ItemNum(){

  if(BookingsL.length == 0){



    return 1;


  }
  else{

    return (BookingsL.length);

  }

}




class DeleteItemInListViewPopupMenu extends StatefulWidget {
  
  @override
  DeleteItemInListViewPopupMenuState createState() {
    return new DeleteItemInListViewPopupMenuState();
  }
}

class DeleteItemInListViewPopupMenuState


    extends State<DeleteItemInListViewPopupMenu> {

  _onSelected(dynamic val) {

    var numId = dbBookingsListNew.indexOf(val);
 setState(() => AlreadyBookedD.removeWhere((data) => data == val));
setState(() => dbBookingsListNew.removeWhere((data) => data == val));

         databaseReference.collection("Bookings").document(iDList[numId].toString())
        .delete();


   AlreadyBD(AlreadyBookedD);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: 
      

      ListView(
        children: dbBookingsListNew
            .map((data) => ListTile(
          title: Text(data),
          trailing: PopupMenuButton(
            
            onSelected: _onSelected,
            icon: Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: data,
                child: Text("Delete"),
                
              ),
            ],
          ),
        ))
            .toList(),
      ),
  );
  }

  
}






var dbBookingsListNew = new List();
var iDList = new List();




void setList(List dbBookingsList , List iDListNew){
  dbBookingsListNew = dbBookingsList;
iDList=iDListNew ;

  


}








