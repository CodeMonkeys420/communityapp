import 'package:flutter/material.dart';




class ContentPage extends StatelessWidget {
  ContentPage({@required this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Test(this.title)

      ),
    );
  }
}


Column Test (var titlename){
  if(titlename=='home')
   {

     return (Column(
     children: <Widget>[Text(titlename)],
  ));
   }

  else if(titlename=='home'){
  return (Column(
  children: <Widget>[Text(titlename)],
  ));

  }
  else if(titlename=='example')
{
   return (Column(


   ));

}

  else if(titlename=='Messages Page')
  {
    return (Column(
      children: <Widget>[Text('Messages Page')],));

  }
  else if(titlename=='Calendar Page')
  {
    return (Column(
      children: <Widget>[Text('Calendar Page')],));

  }
  else{

    return (Column(
      children: <Widget>[Text('Coming soon')],));
  }
}




class NewsPG extends StatefulWidget {
  NewsPG({Key key, this.title}) : super(key: key);
final String title;

@override
NewsPGState createState() => NewsPGState();
}

class NewsPGState extends State<NewsPG> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
          backgroundColor: Colors.grey[200],

          body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 0.0,),
                        Image.asset('Assets/61htWk5w.jpg'),
                        SizedBox(height: 16.0,),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 16.0,),
                            Text('HEADLINE', style: Theme.of(context).textTheme.headline,),
                            SizedBox(width: 16.0,),
                            Text('subhead of news article', style: Theme.of(context).textTheme.subhead,),


                          ],

                        ),
                        SizedBox(height: 16.0,),
                      ],

                    ),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 0.0,),
                        Image.asset('Assets/Sunset-001-1024x682.jpg.jpeg'),
                        SizedBox(height: 16.0,),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 16.0,),
                            Text('HEADLINE', style: Theme.of(context).textTheme.headline,),
                            SizedBox(width: 16.0,),
                            Text('subhead of news article', style: Theme.of(context).textTheme.subhead,),


                          ],

                        ),
                        SizedBox(height: 16.0,),
                      ],

                    ),
                  ),
                  Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 0.0,),
                        Image.asset('Assets/Val-De-Vie-Aerial-20-1024x575.jpg.jpeg'),
                        SizedBox(height: 16.0,),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 16.0,),
                            Text('HEADLINE', style: Theme.of(context).textTheme.headline,),
                            SizedBox(width: 16.0,),
                            Text('subhead of news article', style: Theme.of(context).textTheme.subhead,),


                          ],

                        ),
                        SizedBox(height: 16.0,),
                      ],

                    ),
                  )],
              )
          )
      ),
    );
  }
}
