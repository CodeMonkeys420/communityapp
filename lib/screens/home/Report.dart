import 'package:communityapp/services/auth.dart';
import 'package:flutter/material.dart';



import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:communityapp/screens/home/home.dart';

import 'home.dart';
final databaseReference = Firestore.instance;
String dropdownValue = 'IT';
var imagepath;
var department='IT';
var description;
var location;
var long;
var lat;
var currentUser=UserID;
  String attachment;
  bool isHTML = false;
final AuthService _auth = AuthService();

class ReportPg extends StatefulWidget {
  @override
  ReportPgState createState() => ReportPgState();
}


class ReportPgState extends State<ReportPg> {

final _recipientController = TextEditingController(
    text: 'kylechrispotgieter@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'Report');

  final _bodyController = TextEditingController(
    text: 'The following report has been submited:',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text+' '+myControllerDescription.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPath: attachment,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }


  final myControllerDescription = TextEditingController();
  final myControllerSurname = TextEditingController();
  final myController = TextEditingController();
  Position _currentPosition;
  File _image;
  @override
  Widget build(BuildContext context) {
final Widget imagePath = Text(attachment ?? '');



    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        //print('Image Path $_image');
        imagepath=_image;
        attachment = _image.path;
      });
    }


 _getCurrentLocation();
   _getCurrentLocation();
   return new Scaffold(

          key: _scaffoldKey,

        body: GridView.count(

          crossAxisCount: 1,

          children: List.generate(1, (index)
          {
            return Center(
                child:
                new Column(
                    children: <Widget>[


                         
         

                   
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Description'
                        ),
                        controller: myControllerDescription,


                      )
                      ,


                          Row( children: <Widget>[

                            Text('Choose Department:  '),

                            DropdownButton<String>(

                            icon: Icon(Icons.arrow_downward),
                            value: dropdownValue,
                            iconSize: 24,
                            elevation: 20,
                            style:

                            TextStyle(
                                color: Colors.deepPurple
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                department=newValue;



                              });
                            },
                            items: <String>['IT', 'Maintenance', 'Landscaping']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                                .toList(),
                          )])

                                             ,


                      ButtonTheme(
                          minWidth: 150.0,
                          height: 36.0,
                          child:
                          new RaisedButton.icon(

                            textColor: Colors.white,
                            color: Colors.amber,
                            onPressed:() {
                              //uploadPic(context);
                              getImage();
                           


                            }

                            ,
                            icon:  Icon(Icons.photo),
                            label: new Text('Upload Photo'),
                          )),
           
                      ButtonTheme(
                          minWidth: 150.0,
                          height: 36.0,
                          child:
                          new RaisedButton.icon(

                            textColor: Colors.white,
                            color: Colors.amber,
                            onPressed:() {
                               
                                  

                              description= myControllerDescription.text;

                                _getCurrentLocation();

                              if (_currentPosition != null){
                                

                                print("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");}
                               lat = _currentPosition.latitude;
                               long = _currentPosition.longitude;



                               if(description==''){
                                  _ackAlertDes(context);

                               }else
                               {createRecord();
                               _ackAlertSub(context);
                               print('!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@'+attachment.toString());
                                send();
                               }
                             


                            }

                            ,
                            icon:  Icon(Icons.check),
                            label: new Text('Submit'),
                          ))










                      ])









            );},
        )));







  }



  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}




void createRecord() async{

var now = new DateTime.now();

 databaseReference.collection('Report').document()
 .setData({ 'Date': now, 'Department': department ,
 'Description':description, 'Location':'Latitude: ' +lat.toString()+
 ' Longitude: '+long.toString(),'UserID':currentUser});




//await FlutterEmailSender.send(email);


}





Future<void> _ackAlertDes(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('Please enter a description'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> _ackAlertSub(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Submitted'),
        content: const Text('Report has been submited'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
