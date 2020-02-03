
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communityapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:spinner_input/spinner_input.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:communityapp/screens/home/home.dart';

final databaseReference = Firestore.instance;
var time;
var bookingList = new List();
String dropdownValue = '10:00';
var AlreadyBooked = new List();
var  AlreadyBookedDate = new List();
var bookingsDate ;
var indexAmmount = 0;
bool flag = false;
var  booking  ;
var IdexCounter=1;
var imagePath;
var FacilityReference;
var price;
var userIDBookings=UserID;
String FacilityID;

String sanitizeDateTime(DateTime dateTime) => "${dateTime.year}-${dateTime.month}-${dateTime.day}";

Set<String> getDateSet(List<DateTime> dates) => dates.map(sanitizeDateTime).toSet();

class Facilities extends StatefulWidget {
  @override
  FacilitiesState createState() => FacilitiesState();
}


class FacilitiesState extends State<Facilities> {


  @override
  Widget build(BuildContext context) {

    flag= false;

    return new Scaffold(
    body: GridView.count(
crossAxisSpacing: 2,
      mainAxisSpacing: 0.1,
      crossAxisCount: 2,

      children: List.generate(6, (index)

  {
    return

       new Column(

         children: <Widget>[


           GestureDetector(
               child: Container(
                   width:180,
                   height: 120,

                   decoration: BoxDecoration(

                     color: Colors.black,
                     image: DecorationImage(
                         image:AssetImage(ImagePath(index)),
                         fit:BoxFit.cover
                     ),
                     // button text
                   )
               ),onTap:(){


             booking = index;

             if(booking==0){
               indexAmmount= 3;
             }
             else if(booking==1) {
               indexAmmount = 1;
             }
             else if(booking==5) {
               indexAmmount = 6;
             }
             else if(booking==2) {
               indexAmmount = 2;
             }
             else
             {
               indexAmmount = 1;

             }

             flag = true;
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) =>  bookingPage()),
             );
           }
           ),


        ButtonTheme(
            minWidth: 180.0,
            height: 30.0,

            child:
            new RaisedButton.icon(

            textColor: Colors.white,
            color: Colors.amber,
            onPressed:(){ booking = index;

            if(booking==0){
              indexAmmount= 3;
            }
            else if(booking==1) {
              indexAmmount = 1;
            }
            else if(booking==5) {
              indexAmmount = 6;
            }
            else if(booking==2) {
              indexAmmount = 2;
            }
            else
              {
                indexAmmount = 1;

              }

            flag = true;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  bookingPage()),
            );

            },
            icon: IconsIndex(index),
            label: LabelIndex(index,0),
      )),
    ]);



  }),
  ));}







}


String ImagePath(var indexNum){

  if (indexNum== 0)
  {
    return'Assets/restaurant.jpg';



  }

  else if (indexNum== 1)
  {
    return'Assets/wine.jpg';


  }

  else if (indexNum== 2)
  {
    return'Assets/golf.jpg';


  }

  else if (indexNum== 3)
  {

    return'Assets/spa.jpg';


  }
  else if (indexNum== 4)
  {

    return'Assets/hotel.jpg';


  }
  else{


    return'Assets/polo.jpg';


  }

}

Icon IconsIndex(var indexNum){

  if (indexNum== 0)
    {


      return  Icon(Icons.restaurant);

    }

  else if (indexNum== 1)
    {

      return  Icon(Icons.local_bar);

    }

  else if (indexNum== 2)
  {

    return  Icon(Icons.golf_course);

  }

  else if (indexNum== 3)
  {


    return  Icon(Icons.spa);

  }
  else if (indexNum== 5)
  {


    return  Icon(Icons.local_activity);

  }
  else{



    return Icon(Icons.home);

  }


}


Text LabelIndex(var indexNum, var nameIndex){

  if (indexNum== 0)
  {
    if(flag == false)
      {
        return   Text('Restaurants');

      }
    else{


      if(nameIndex==0)

      {
        
        return   Text('POLO CLUB RESTAURANT');
      }
      else if(nameIndex==1)
        {

          return   Text('THE VALLEY RESTAURANT');
        }
      else if(nameIndex==2) {

        
        return Text("Fleet Coffee Roastery");
      }



    }




  }

  else if (indexNum== 1)
  {


    if(flag == false)
    {
      return  Text('Wine');

    }
    else{


      if(nameIndex==0)

      {
        return   Text('L’HUGUENOT VENUE & VINOTEQUE');
      }






    }

  }

  else if (indexNum== 2)
  {


    if(flag == false)
    {
      return  Text('Golf');

    }
    else{


      if(nameIndex==0)

      {
            
        return   Text('PEARL VALLEY JACK NICKLAUS SIGNATURE GOLF COURSE',style: TextStyle(fontSize: 10),);

      }
      else if(nameIndex==1)

      {


              
          return   Text('SwingFit Training Academy');

      }








    }


  }

  else if (indexNum== 3)
  {
    if(flag==false)
      {

        return  Text('Spa');
      }
    else
      {

         
        return  Text('CAMELOT SPA VAL DE VIE');


      }


  }
  else if (indexNum== 5)
  {
    if(flag==false)
    {

      return  Text('Activities');
    }
    else
    {

      if(nameIndex==0)

      {
        
        return   Text('Polo Academy Lessons');
      }
      else if (nameIndex==1)
        {
          
          return   Text('Tennis');

        }
      else if (nameIndex==2)
      {
        
        return   Text('Equestrian competitive coaching');

      }
      else if (nameIndex==3)
      {
        
        return   Text('Equestrian riding school');

      }
      else if (nameIndex==4)
      {
        
        return   Text('Pearl valley Boma');

      }
      else if (nameIndex==5)
      {
        
        return   Text('Ryk Neethling swim school');

      }

    }


  }
  else{

    if(flag==false)
    {

      return  Text('Hotel');
    }
    else
    {
      
      return  Text('PEARL VALLEY HOTEL BY MANTIS');


    }



  }



}





var Place;

class bookingPage extends StatefulWidget {
  @override
  bookingPageState createState() => bookingPageState();
}




class bookingPageState extends State<bookingPage> {



  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    
    final double itemHeight = (size.height - kToolbarHeight -300) ;
    final double itemWidth = size.width +50;

    return

   new WillPopScope(
      onWillPop: () async => true,
    child : new Scaffold(

      appBar: AppBar(
        title: Text("Bookings"),


      ),
      body: GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisCount: 1,

        children: List.generate(indexAmmount, (index)

        {

          return
              new Column(

                  children: <Widget>[


                   GestureDetector(
                        child: Container(
                            width:300,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    image:AssetImage(ImagePathBookPg(booking,index)),
                                    fit:BoxFit.cover
                                ),
                                
                            )
                        ),onTap:(){
                     PlaceName(booking,index);

                     flag=true;


                     Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) =>  bookSpot()));
                    }
                    ),

                    ButtonTheme(
                        minWidth: 300.0,
                        height: 36.0,
                        child:
                        new RaisedButton.icon(

                          textColor: Colors.white,
                          color: Colors.amber,
                          onPressed:(){
                         

                            PlaceName(booking,index);

                            flag=true;


                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  bookSpot()));
                          },
                          icon: IconsIndex(booking),
                          label: LabelIndex(booking,index),
                        )),
                  ]);



        }),
      )));}



}




class bookSpot extends StatefulWidget {
  @override
  bookSpotState createState() => bookSpotState();
}


class bookSpotState extends State<bookSpot> {

  var BookingName='';
  var AmmountOfPeople=0;
  final myController = TextEditingController();





final _recipientController = TextEditingController(
    text: 'kylechrispotgieter@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'Booking');

  final _bodyController = TextEditingController(
    text: 'The following Bokkings has been Made:',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 Future<void> send() async {
    final Email email = Email(
      body: 'bookings were made for the following: '+AmmountOfPeople.toString()+' people at '+time.toString()+' on '+bookingsDate.toString()+' for a '+myController.text
      ,
      subject: 'bookings',
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

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }



  final formatH = DateFormat("yyyy-MM-dd");

  double spinner = 1;

  Future<bool> _onWillPop() {
    flag= true;
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('changes will not be saved'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () { 
              flag = true;
              Navigator.of(context).pop(false);
            
            },
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              flag= true;
              Navigator.of(context).pop(true);},
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    flag = true;
    return

    new WillPopScope(
        onWillPop: _onWillPop,
        child : new Scaffold(
         key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Book"),


            ),
            body: GridView.count(

              crossAxisCount: 1,

              children: List.generate(1, (index)
              {
                return Center(
                    child:
                    new Column(
                        children: <Widget>[

                          TextFormField(
                            decoration: InputDecoration(labelText: 'Enter Name'
                            ),
                            controller: myController,
                            /* initialValue: name,*/
                          )
                        ,




                          Column(children: <Widget>[

                            DateTimeField(

                              format: formatH,
                              decoration: InputDecoration(labelText: 'Choose a date '),
                              onShowPicker: (context, currentValue) async {

                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                
                                    lastDate: DateTime(2400));


                                if (date != null) {
                                  var month ;
                               if(date.month == 1)
                               {
                                  month='January';

                               }
                               else if(date.month == 2){

                                 month='February';
                               }
                              else if(date.month == 3){

                                 month='March';
                               }
                               else if(date.month == 4){

                                 month='April';
                               }
                              else if(date.month == 5){

                                 month='May';
                               }

                              else if(date.month == 6){

                                 month='June';
                               }
                              else if(date.month == 7){

                                 month='July';
                               }
                              else if(date.month == 8){

                                 month='August';
                               }
                              else if(date.month == 9){

                                 month='September';
                               }
                              else if(date.month == 10){

                                 month='October';
                               }
                              else if(date.month == 11){

                                 month='November';
                               }
                              else if(date.month == 12){

                                 month='December';
                               }
                                  bookingsDate = date.day.toString()+' '+month+' '+date.year.toString() ;
                                  return date;
                                } else {

                                  return currentValue;
                                }


                                

                              },
                            ),

                            Row( children: <Widget>[

                              Text('Choose Time slot:  '),
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
                                time = dropdownValue.toString();



                              });
                            },
                            items: <String>['08:00', '08:15', '08:30', '08:45', '09:00', '09:15', '09:30',
                              '09:45', '10:00', '10:15', '10:30', '10:45','11:00','11:15','11:30','11:45','12:00',
                              '12:15','12:30','12:45','13:00','13:15','13:30','13:45','14:00','14:15','14:30','14:45','15:00'
                              ,'15:15','15:30','15:45','16:00']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                                .toList(),
                          )
                                                 ,

                                        ])

                          ]),

                          Container(
                            margin: EdgeInsets.all(20),
                            child: new Column(
                                children: <Widget>[

                             new Text('Ammount of people'),

                           new  SpinnerInput(


                              spinnerValue: spinner,
                              minValue: 1,
                              maxValue: 20,



                              onChange: (newValue) {
                                setState(() {
                                  spinner = newValue;
                                });
                                },
                         ),
              ])

                          ),


                          ButtonTheme(
                              minWidth: 150.0,
                              height: 36.0,
                              child:
                              new RaisedButton.icon(

                                textColor: Colors.white,
                                color: Colors.amber,
                                onPressed:()async{



                                  if(myController.text ==''){


                                 _ackAlert(context);

                                  }
                                  else{
                                  if (bookingsDate == null){

                                    _ackAlertDate(context);

                                  }
                                  else{

                                    BookingName = myController.text;
                                    AmmountOfPeople = spinner.toInt();


                                    if(time == null){_ackAlertTime(context);}
                                    else{

                                      print(Place+bookingsDate.toString()+time +' testing!!!!!!!!!!');
                                      if(AlreadyBooked.contains(Place+bookingsDate.toString()+time))
                                        {
                                          _ackAlertAlready(context);

                                        }
                                      else
                                        {

                                       
                                             
                                            price = 0;         //defualt !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                            var counter = 0 ;
                                                      

                                                                databaseReference
                                                            .collection("Bookings")
                                                            .getDocuments()
                                                            .then((QuerySnapshot snapshot) {
                                                            snapshot.documents.forEach((f) { 
                                                            
                                                            bookingList.add(f.data["Date"]+f.data["Time"]+f.data["FacilityID"]);

                                                            });
                                                            });
                                                            var placeholder = bookingsDate.toString()+time+FacilityReference;
                                            
                                                   
                                                    bookingList.forEach((f){
                                                          if(f ==  placeholder){counter++;
                                                          }
                                                           
                                                       
                                                    });
                                                    bookingList.clear();
                                                          var flagB  = true;
                                                        if(counter>= 2)
                                                        {
                                                           flagB = false; 
                                                          print('bookings full');
                                                        }


                                                    if(flagB==false){
                                                     
                                                      
                                                      _ackAlertBookingFull(context);
                                                        }
                                                        else
                                                        {
                                                     final DocumentReference documentReference = 
                                                      await databaseReference.collection("Bookings").add({ 
                                                        'AmmountPeople': AmmountOfPeople,'Date': bookingsDate.toString(),'Time':time,
                                                       'FacilityID': FacilityReference
                                                        ,'Price': price,'UserID': userIDBookings,'Name':myController.text});
                                                        
                                                         send();

                                                              BookingName = '';
                                                              AmmountOfPeople=0;
                                                              bookingsDate='';
                                                              time='';
                                                              Place='';
                                                              IdexCounter++;
                                                              flag =true;
                                                              dropdownValue = '10:00';
                                                              Navigator.pop(context);
                                                       


                                                          
                                                        }
                                                    

                                                  //  final String groupID = documentReference.documentID;

                                                     

                                        



                                        }

                                    }



                                  }

                                  }


                                },
                                icon:  Icon(Icons.bookmark),
                                label: new Text('book'),
                              )),
                        ]));



              }),
            )));}

}

void PlaceName (var indexNum, var nameIndex) {
  if (indexNum == 0) {


      if (nameIndex == 0) {
        FacilityID= 'Yz4sb6xBx2hvdpN7HmZX';
          FacilityReference = 'Yz4sb6xBx2hvdpN7HmZX';
      Place = 'POLO CLUB RESTAURANT';
      }
      else if (nameIndex == 1) {
        FacilityID= '5mNcafO5KtopVZaEKCIq';
        Place = 'THE VALLEY RESTAURANT';
        FacilityReference = '5mNcafO5KtopVZaEKCIq';
      }
      else if (nameIndex == 2) {
         FacilityID= 'S0zfNxaQSqoKAzRhwIuZ';
        FacilityReference = 'S0zfNxaQSqoKAzRhwIuZ';
        Place = 'Fleet Coffee roastery ';
      }

  }
  else if (indexNum == 1) {


    if (nameIndex == 0) {
      FacilityID= 'lbAMWRvPesPkVypJfOkb';
      FacilityReference='lbAMWRvPesPkVypJfOkb';
      Place = 'L’HUGUENOT VENUE & VINOTEQUE';
    }



  }

  else if (indexNum == 2) {


    if (nameIndex == 0) {
      FacilityID= 'isBzGSOgF7qS3PxCyAUv';
      Place =   'PEARL VALLEY JACK NICKLAUS SIGNATURE GOLF COURSE';
      FacilityReference = 'isBzGSOgF7qS3PxCyAUv';
    }
    else{
      FacilityID= 'BdgxN0CITYMYJJqOQ06f';
FacilityReference = 'BdgxN0CITYMYJJqOQ06f';
      Place = 'SwingFit Training Academy';
    }



  }




  else if (indexNum == 3) {


    if (nameIndex == 0) {
      FacilityID= '5rbhWfXzl5Loq6oCrreU';
       FacilityReference = '5rbhWfXzl5Loq6oCrreU';
      Place = 'CAMELOT SPA VAL DE VIE';
    }



  }

  else if (indexNum == 4) {


    if (nameIndex == 0) {
      FacilityID= 'CHYKh3mWb3xVm2m2EHwN';
      Place = 'PEARL VALLEY HOTEL BY MANTIS';
       FacilityReference = 'CHYKh3mWb3xVm2m2EHwN';
      
    }



  }

  else if (indexNum == 5) {


    if(nameIndex==0)

    {
      FacilityID= 'DlaQvFB5NShSbh0lCoaA';
      FacilityReference = 'DlaQvFB5NShSbh0lCoaA';
      Place = 'Polo Academy Lessons';
    }
    else if (nameIndex==1)
    {
      FacilityID= 'uCqK1eTNgERkvagM8n7L';
      Place =    'Tennis';
      FacilityReference = 'uCqK1eTNgERkvagM8n7L';
    }
    else if (nameIndex==2)
    {
      FacilityID= 'tjkK8Nj780J726Z3gARA';
      FacilityReference = 'tjkK8Nj780J726Z3gARA';
      Place = 'Equestrian competitive coaching';

    }
    else if (nameIndex==3)
    {
      FacilityID= 'pVNuIBj0uM300FJPszet';
      FacilityReference = 'pVNuIBj0uM300FJPszet';
      Place = 'Equestrian riding school';

    }
    else if (nameIndex==4)
    {
      FacilityID= 'hCKDdzKRknzhVfT3yA9h';
      FacilityReference = 'hCKDdzKRknzhVfT3yA9h';
      Place = 'Pearl valley Boma';

    }
    else if (nameIndex==5)
    {
      FacilityID= '6pjxPBq1RQ61FmpXpH1p';
      FacilityReference = '6pjxPBq1RQ61FmpXpH1p';
      Place = 'Ryk Neethling swim school';

    }
   



  }


}



Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('Please enter a name'),
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



Future<void> _ackAlertDate(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('Please enter a Date'),
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


Future<void> _ackAlertTime(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('Please choose a time'),
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




Future<void> _ackAlertAlready(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('already booked , please choose another time slot'),
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




String ImagePathBookPg(var indexNum, var index){


  if (indexNum== 0)
  {
    if(index==0){
      return'Assets/poloR.jpg';

    }

     else if(index== 1){

      return'Assets/valleyR.jpg';
    }

      else if(index== 2){

      return'Assets/CoffieR.jpg';
    }

  }

  else if (indexNum== 1)
  {
    if(index==0){
      return'Assets/wineR.jpg';

    }


  }

  else if (indexNum== 2)
  {
    if(index==0) {
      return 'Assets/golfR.jpg';
    }
    else {
      return 'Assets/golfRP.jpg';

    }

  }

  else if (indexNum== 3)
  {


    if(index==0) {
      return 'Assets/SPAr.jpeg';
    }



  }
  else if (indexNum== 4)
  {

    return'Assets/hotelr.jpg';


  }
  else{

    if(index==0) {
      return'Assets/poloA.jpg';
    }
    else if (index==1){

      return'Assets/tennis.jpg';
    }
    else if (index==2){

      return'Assets/Competitive.jpg';
    }
    else if (index==3){

      return'Assets/ridingSchool.jpg';
    }
    else if (index==4){

      return'Assets/poloA.jpg';
    }
    else if (index==5){

      return'Assets/4BWK9bCw.jpeg';
    }

  }
}

Future<void> _ackAlertBookingFull(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('Please choose another day or time'),
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
  
  final bool isHTML;
  Email({
    this.subject = '',
    this.recipients = const [],
    this.cc = const [],
    this.bcc = const [],
    this.body = '',
    
    this.isHTML = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'body': body,
      'recipients': recipients,
      'cc': cc,
      'bcc': bcc,
     
      'is_html': isHTML
    };
  }
}
