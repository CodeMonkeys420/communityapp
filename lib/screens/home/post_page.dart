import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:communityapp/models/Posts.dart';
final databaseReference = Firestore.instance;
var headln;
var author;
var body;
var datePosted;


var headlnL = new List();
var authorL = new List();
var bodyL = new List();
var iDL = new List();
var datePostedL = new List();
class NewsPG extends StatefulWidget {


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
     return StreamProvider<List<Posts>>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        
        
        body: Container(
            
            child: BrewList()
          ),
      ),
    );
  }
}



class DatabaseService {

final CollectionReference postsCollection = Firestore.instance.collection('Post');


  List<Posts> _postsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
   
      return Posts(
        Author:   doc.data['Author'] ,
        Body:   doc.data['Body'] ,
        Date:   doc.data['Date'] ,
        Headline:   doc.data['Headline'] ,
        SubHeadline: doc.data['SubHeadline'],
        DocIdPost:   doc.documentID,
        
      );
    }).toList();
  }

  Stream<List<Posts>> get posts {
    return postsCollection.snapshots()
      .map(_postsFromSnapshot);
  }




}

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {




  @override
  Widget build(BuildContext context) {

    final posts = Provider.of<List<Posts>>(context) ?? [];


    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return BrewTile(posts:  posts[index]);
      },
    );
  }


}

class BrewTile extends StatelessWidget {

  final Posts posts;
  BrewTile({ this.posts });

  @override
  Widget build(BuildContext context) {
    

    _onSelected(dynamic val) {
    

    databaseReference
.collection("Post")
.getDocuments()
.then((QuerySnapshot snapshot) {
snapshot.documents.forEach((f) { 
headlnL.add(f.data['Headline']);
datePostedL.add(f.data['Date']);
bodyL.add(f.data['Body']);
authorL.add(f.data['Author']);
iDL.add(f.documentID);


});
});

var place = iDL.indexOf(val);
headln= headlnL[place];
datePosted= datePostedL[place];
body= bodyL[place];
author= authorL[place];
print( author);
Navigator.push(context, MaterialPageRoute(builder: (context) => NewsArticle()));
  }
return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: 
    //PostData(posts.Author ,posts.Body,posts.Date,posts.DocIdPost,posts.Headline,posts.SubHeadline)
    Card(
                    elevation: 3.0,
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 0.0,),
                        Image.asset('Assets/61htWk5w.jpg'),
                        SizedBox(height: 12.0,),
                        ListTile(
          title: Text(posts.Headline),

          subtitle: Text(posts.SubHeadline),
             trailing: PopupMenuButton(
            onSelected: _onSelected,
            icon: Icon(Icons.menu),
            itemBuilder: (context) => [

              PopupMenuItem(
                value: posts.DocIdPost,
                child: Text("View"),
                
              ),
            ],
          ),
        ),
                        SizedBox(height: 16.0,),
                      ],

                    ),
                  ),
    );  
  }
}

class NewsArticle extends StatefulWidget {
  @override
  _NewsArticleState createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {

final Posts article;
  _NewsArticleState({ this.article });


  @override
  Widget build(BuildContext context) {

   return new  Scaffold(
appBar: AppBar(
title: Text('Article'),
  backgroundColor: Color.fromRGBO(217,180,111, 1),

),
body: GridView.count(
crossAxisCount: 1,
 children: List.generate(1, (index)
          {
        return new Column(
            children: <Widget>[

              Text(
                headln,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ), 
               
              Align(
                alignment: Alignment.bottomLeft,
                              child: Padding(
                  padding: EdgeInsets.all(20),
                                child: SizedBox(
                  child: Text(
                      body,
                      textAlign: TextAlign.left,
                      
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                  ),
                ),
              ),
               Align(
                 alignment: Alignment.centerLeft,
                                child: SizedBox(
              child: Padding
              (
                padding: EdgeInsets.all(20),
                 child: Text(
                      'Author: '+author,
                      textAlign: TextAlign.left,
                      
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                    ),
              ),
              ),
               ),

               Align(
                 alignment: Alignment.centerLeft,

                                child: Padding(
                                  padding: EdgeInsets.all(20),
                            child: SizedBox(
                       child: Text(
                    'Date published: '+datePosted,
                    textAlign: TextAlign.left,
                    
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                  ),
              ),
                                ),
               )

            ]);



          })

),

    );
  }


}

void getData() {
databaseReference
.collection("Post")
.getDocuments()
.then((QuerySnapshot snapshot) {
snapshot.documents.forEach((f) { 
headlnL.add(f.data['Headline']);
datePostedL.add(f.data['Date']);
bodyL.add(f.data['Body']);
authorL.add(f.data['Author']);
iDL.add(f.documentID);
});
});
}

