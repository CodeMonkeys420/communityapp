
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/main.dart';
import '../home/home.dart';
import 'Bookings.dart';
import 'Facility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/screens/home/home.dart';
var dbFacList = new List();
var iDFacList = new List();
final databaseReference = Firestore.instance;

var id = UserID;


class MyHomePageProfile extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}
bool flag = true;

class MyHomePageState extends State<MyHomePageProfile>  {

  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/')

        .then((_) => false);
  }
   
  @override
  Widget build(BuildContext context) {


  return StreamProvider<List<Booking>>.value(
      value: DatabaseService().bookings,
      child: Scaffold(
        
        
        body: Container(
          
          child: BrewList()
        ),
      ),
    );
    
  }

}


void getDataF(){


databaseReference
.collection("Facilities")
.getDocuments()
.then((QuerySnapshot snapshot) {
snapshot.documents.forEach((f) { 
iDFacList.add(f.documentID);
dbFacList.add(f.data["Name"]);

});
});


}










class DatabaseService {

final CollectionReference facilityCollection = Firestore.instance.collection('Facilities');


  List<Facility> _facilityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Facility(
        Category:  doc.data['Category'] ,
        ContactNum:  doc.data['ContactNum'] ,
        Name:  doc.data['Name'] ,
        PricePP:  doc.data['PricePP'] ?? 0,
        
        DocIdFac:  doc.documentID.toString(),
        
      );
    }).toList();
  }

  Stream<List<Facility>> get facilities {
    return facilityCollection.snapshots()
      .map(_facilityListFromSnapshot);
  }

final CollectionReference bookingsCollection = Firestore.instance.collection('Bookings');
  // brew list from snapshot
  List<Booking> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Booking(
        UserID: doc.data['UserID'] ,
        AmmountPeople: doc.data['AmmountPeople'] ,
        Date: doc.data['Date'] ,
        Price: doc.data['Price'] ?? 0,
        FacilityID: doc.data['FacilityID'] ,
        DocID: doc.documentID.toString(),
        Time: doc.data['Time'] ,
      );
    }).toList();
    
  }




   Stream<List<Booking>> get bookings {
    return bookingsCollection.snapshots()
      .map(_brewListFromSnapshot);
  }


}




class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {




  @override
  Widget build(BuildContext context) {

    final bookings = Provider.of<List<Booking>>(context) ?? [];
     
  

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BrewTile(bookings:  bookings[index]);
      },
    );
  }


}


class BrewTile extends StatelessWidget {

  final Booking bookings;
  BrewTile({ this.bookings });

  @override
  Widget build(BuildContext context) {
    
return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: 
    userData(bookings.FacilityID ,bookings.Date,bookings.AmmountPeople,bookings.UserID,bookings.DocID,bookings.Time)
    );
    
  }

}








Card userData(var facility , var date , var ammountP ,var iD,var docId, var time){

var facName;
var placeholderID;
 //getDataF();
if(iD == id){


placeholderID=iDFacList.indexOf(facility);


facName = dbFacList[placeholderID];

  _onSelected(dynamic val) {

   


         databaseReference.collection("Bookings").document(val)
        .delete();


 

  }

return Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
         
          title: Text(facName),
          subtitle: Text('Booking:  $date at $time for $ammountP'),
             trailing: PopupMenuButton(
            onSelected: _onSelected ,
            icon: Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: docId,
                child: Text("Cancel"),
              ),
            ],
          ),
        ),
      );
    
}
else{

   Card(
       
      );
}
 





}







