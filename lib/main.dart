import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO Make the  Number editable directly


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Balance App'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),

            //Down below is just for the text for user's balance
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30
                ),
              child: Expanded(
                child: Container(
                  color: Colors.purple[700],
                  height: 100,
                  child: Center(
                    child: Text(
                      'Users\' Balance' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      )
                    ),
                ),
              ),
            ),
            //Up Above is just for the text for user's balance

            SizedBox(height: 40,),

            //List below
            Padding(
              padding: const EdgeInsets.all(0),
              child: Expanded(
                child: Container(
                  color: Colors.grey[700],
                  height: 70,
                  child: Center(
                    child: Text(
                      'List' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                      )
                    ),
                ),
              ),
            ),
            //List above

            SizedBox(height: 40,),
            
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('userNames').snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return userCard(snapshot.data.docs[index]);
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column userCard(DocumentSnapshot doc){
  return Column(
    children: <Widget>[
      Card(
        color: Colors.grey[800],
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex : 5,
                child: Text(
                  doc['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.5
                  ),
                ),
              ),

              Expanded(
                flex : 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                    ),
                    label: Text(''),
                    onPressed: () {
                      
                      if(doc['balance'] > 0){
                        doc.reference.update({
                        'balance' : doc['balance'] - 1000
                      });}
                    },
                ),
              ),

              Expanded(
                flex : 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    ),
                    label: Text(''),
                    onPressed: () {
                      doc.reference.update({
                        'balance' : doc['balance'] + 1000
                      });
                    },
                ),
              ),

              Expanded(
                flex : 7,
                child: Center(
                  child: Text(
                    '${doc['balance']}\$',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}