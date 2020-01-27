import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:communityapp/models/Posts.dart';
final databaseReference = Firestore.instance;
var headln;
var author;
var body;
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
     print(doc.data.toString()+'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      return Posts(
        Author:   doc.data['Author'] ,
        Body:   doc.data['Body'] ,
        Date:   doc.data['Date'] ,
        Headline:   doc.data['Headline'] ,
        SubHeadline: doc.data['SubHeadline'],
        DocIdPost:   doc.documentID.toString(),
        
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
if(val==f.documentID){
headln= f.data['Headline'];
print(headln.toString()+'!!!!!!!!!!!!!!!!!!!!!');
body = f.data['Body'];
}

});
});
Navigator.push(context, MaterialPageRoute(builder: (context) => NewsArticle()));
  }
return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: 
    //PostData(posts.Author ,posts.Body,posts.Date,posts.DocIdPost,posts.Headline,posts.SubHeadline)
    Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
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
      )
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
title: Text('hello'),

),
body: GridView.count(
crossAxisCount: 1,

 children: List.generate(1, (index)
          {


        return Center(
                child:
                new Column(
                    children: <Widget>[

                      Text(
                        headln,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ), 
                       
                      SizedBox(
                      child: Text(
                          body,
                          textAlign: TextAlign.left,
                          
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                        ),
                      )

                    ]));



          })

),

    );
  }


}