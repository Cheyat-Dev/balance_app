import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

//TODO Make the  Number editable directly
//TODO Make add users customizable

Future<void> addUser(CollectionReference user, String name, int balance) {
  // Call the user's CollectionReference to add a new user
  return user
      .add({'name': name, 'balance': balance})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

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

            SizedBox(
              height: 40,
            ),

            //List below
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                color: Colors.grey[700],
                height: 70,
                child: Center(
                    child: Text(
                  'List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                )),
              ),
            ),
            //List above

            SizedBox(
              height: 40,
            ),

            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userNames')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text('Loading');
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return userCard(snapshot.data.docs[index]);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return AddUserForm();
              });
        },
      ),
    );
  }
}

Column userCard(DocumentSnapshot doc) {
  return Column(
    children: <Widget>[
      Card(
        color: Colors.grey[800],
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  doc['name'],
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1.5),
                ),
              ),
              Expanded(
                flex: 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  label: Text(''),
                  onPressed: () {
                    if (doc['balance'] > 0) {
                      FirebaseFirestore.instance
                          .runTransaction((transaction) async {
                        DocumentSnapshot snap =
                            await transaction.get(doc.reference);
                        transaction.update(snap.reference,
                            {'balance': snap['balance'] - 1000});
                      });
                    }
                  },
                ),
              ),
              Expanded(
                flex: 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(''),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      DocumentSnapshot snap =
                          await transaction.get(doc.reference);
                      transaction.update(
                          snap.reference, {'balance': snap['balance'] + 1000});
                    });
                  },
                ),
              ),
              Expanded(
                flex: 7,
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
      SizedBox(
        height: 10,
      )
    ],
  );
}

class AddUserForm extends StatefulWidget {
  const AddUserForm({
    Key key,
  }) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final formKey = GlobalKey<FormState>();
  String _error = '';

  String _userName = 'Guest';
  int _userBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        border: Border.all(
          color: Colors.white38,
          width: 4,
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Add User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 35),

            //User Name Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                initialValue: 'Guest',
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter User\'s name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) =>
                    value.isEmpty ? 'Please enter a Name' : null,
              ),
            ),
            SizedBox(height: 35),

            //User Balance Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                initialValue: '0',
                onChanged: (value) {
                  setState(() {
                    _userBalance = int.parse(value);
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter User\'s Balance',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  String errMsg = "Please enter a valid number";
                  if (value == null) return errMsg;
                  if (int.tryParse(value) == null) {
                    return errMsg;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 35),
            FlatButton.icon(
              onPressed: () {
                Navigator.pop(context);
                if (formKey.currentState.validate()) {
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('userNames');
                  addUser(users, _userName, _userBalance);
                }
              },
              icon: Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              label: Text(
                'Add User',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.pink[500],
            ),
            SizedBox(height: 35),
            Text(
              _error,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
