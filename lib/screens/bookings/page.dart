
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
var iDBookingList = new List();
var EmailList = new List();
var NameList = new List();
final databaseReference = Firestore.instance;
bool isHTML = false;
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
              key: _scaffoldKey,
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
EmailList.add(f.data['Email']);

});
});
}

class DatabaseService {

final CollectionReference facilityCollection = Firestore.instance.collection('Facilities');


  List<Facility> _facilityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      
      return Facility(
        Category:  doc.data['Category'] ,
        ContactNum:  doc.data['ContactNum'] ,
        Name:  doc.data['Name'] ,
        PricePP:  doc.data['PricePP'] ?? 0,
        EmailFac: doc.data['Email'],
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
      
      return Booking(
        UserID: doc.data['UserID'] ,
        AmmountPeople: doc.data['AmmountPeople'] ,
        Date: doc.data['Date'] ,
        Price: doc.data['Price'] ?? 0,
        FacilityID: doc.data['FacilityID'] ,
        DocID: doc.documentID.toString(),
        Time: doc.data['Time'] ,
         Name: doc.data['Name'],
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
    userData(bookings.FacilityID ,bookings.Date,bookings.AmmountPeople,bookings.UserID,bookings.DocID,bookings.Time,bookings.Name)
    );
    
  }

}








Card userData(var facility , var date , var ammountP ,var iD,var docId, var time, var name){

  var facName;
var placeholderID;

 
if(iD == id){


placeholderID=iDFacList.indexOf(facility);
facName = dbFacList[placeholderID];

  _onSelected(dynamic val) {
getDataN();
var place = iDBookingList.indexOf(val);

var Name = NameList[placeholderID];
_recipientController.text= EmailList[placeholderID];

_bodyController.text=_bodyController.text+Name.toString();
  
  databaseReference.collection("Bookings").document(val)
        .delete();


         send();
 

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


class FlutterEmailSender {
 
  static const MethodChannel _channel =
      const MethodChannel('flutter_email_sender');

  static Future<void> send(Email mail) {
    return _channel.invokeMethod('send', mail.toJson());
  }
  
}


class Email {
  final String subject;
  final List<String> recipients;
  final List<String> cc;
  final List<String> bcc;
  final String body;
  final String attachmentPath;
  final bool isHTML;
  Email({
    this.subject = '',
    this.recipients = const [],
    this.cc = const [],
    this.bcc = const [],
    this.body = '',
    this.attachmentPath,
    this.isHTML = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'body': body,
      'recipients': recipients,
      'cc': cc,
      'bcc': bcc,
      'attachment_path': attachmentPath,
      'is_html': isHTML
    };
  }
}


void getDataN(){


databaseReference
.collection("Bookings")
.getDocuments()
.then((QuerySnapshot snapshot) {
snapshot.documents.forEach((f) { 
iDBookingList.add(f.documentID);
NameList.add(f.data["Name"]);

});
});


}

  final _bodyController = TextEditingController(
    text: 'The following booking was cancelled for a :',
  );
final _recipientController = TextEditingController(
    text: 'kylechrispotgieter@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'canceled booking');


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
     
      isHTML: false,
    );

    String platformResponse;
  

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }



   
  }