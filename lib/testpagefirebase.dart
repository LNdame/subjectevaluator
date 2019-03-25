import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestFireStore extends StatefulWidget{

  // This widget is the root of your application.
  @override
  _TestFireStoreState createState() {
    return new _TestFireStoreState();
  }
}

class _TestFireStoreState extends State<TestFireStore> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Firestore"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Firestore.instance.runTransaction((Transaction transaction) async{
                CollectionReference reference  = Firestore.instance.collection('courses');
                await reference.add({"name":"1_ ", "editing":false, "score":0});

              });

            },//pressed
          ),//iconb
        ],
      ),//appbar


      body: StreamBuilder(
          stream: Firestore.instance.collection('courses').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();

            return FirestoreListView(documents: snapshot.data.documents);
          }
      ),//streamBuilder
    );//scaffold
  }
}



class FirestoreListView extends StatelessWidget{

  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: documents.length,
        itemExtent: 120.0,
        itemBuilder: (BuildContext context, int index){
          String name = documents[index].data['name'].toString();
          int score = documents[index].data['score'];
          return ListTile(
              title: Container(
                decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.white)

                ),//box
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: !documents[index].data['editing']
                          ? Text(name)
                          :TextFormField(
                        initialValue: name,
                        onFieldSubmitted: (String item){
                          Firestore.instance.
                          runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction.get(
                                documents[index].reference);

                            await transaction.update(snapshot.reference,
                                {"name": item});

                            await transaction.update(snapshot.reference,
                                {"editing": !snapshot["editing"]});
                          });
                        },
                      ),//TextFormField

                    ),//expan

                    Text("$score"),
                    Column (
                      children: <Widget>[
                        IconButton(
                          onPressed: (){
                            Firestore.instance.runTransaction((Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction
                                  .get(documents[index].reference);

                              await transaction.update(snapshot.reference,
                                  {"score": snapshot["score"] +1} );
                            });
                          },
                          icon: Icon(Icons.arrow_upward),
                        ),//ICb
                        IconButton(
                          onPressed: (){
                            Firestore.instance.runTransaction((Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction
                                  .get(documents[index].reference);

                              await transaction.update(snapshot.reference,
                                  {"score": snapshot["score"] -1} );
                            });
                          },
                          icon: Icon(Icons.arrow_downward),
                        ),//ICb
                      ],
                    ),//Column

                    IconButton(

                      icon: Icon(Icons.delete),
                      onPressed: (){
                        Firestore.instance.runTransaction((Transaction transaction) async {
                          DocumentSnapshot snapshot = await transaction
                              .get(documents[index].reference);

                          await transaction.delete(snapshot.reference);
                        });

                      },
                    ),//icb


                  ],//widget
                ) ,
              ),//container

              onTap:()=> Firestore.instance.runTransaction((Transaction transaction) async{
                DocumentSnapshot snapshot = await transaction.get(documents[index].reference);

                await transaction.update(snapshot.reference,
                    {"editing": !snapshot["editing"]}
                );


              })

          );//ListTile

        }
    );//builder
  }


}




