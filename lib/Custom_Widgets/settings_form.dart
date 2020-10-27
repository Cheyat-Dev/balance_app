import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Functions/user_form_functions.dart';

class SettingsForm extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String uid;
  String userName;

  SettingsForm({this.db, this.uid, this.userName});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String _currentName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      height: 500,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),

            //Topic and cross
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        height: 50,
                        width: 350,
                      ),
                      Positioned(
                        top: 10,
                        left: 28,
                        child: Text(
                          'User Settings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 280,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            //Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                initialValue: widget.userName,
                onChanged: (value) {
                  _currentName = value.toString();
                },
                decoration: const InputDecoration(
                  labelText: 'Edit User\'s name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) =>
                    value.isEmpty ? 'Please enter a  Name' : null,
              ),
            ),

            SizedBox(height: 20),

            //Update button
            FlatButton.icon(
              color: Colors.amber[300],
              icon: Icon(Icons.file_upload),
              label: Text('Update User'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  print(_currentName);
                  if (_currentName.isNotEmpty) {
                    await widget.db
                        .collection('userNames')
                        .doc(widget.uid)
                        .update({
                      'name': _currentName,
                    });
                  }
                  Navigator.pop(context);
                }
              },
            ),
            SizedBox(height: 230),

            //Delete button
            FlatButton.icon(
                color: Colors.red[500],
                icon: Icon(Icons.delete_forever),
                label: Text('Delete User'),
                onPressed: () async {
                  await deleteUser(widget.db, widget.uid);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
