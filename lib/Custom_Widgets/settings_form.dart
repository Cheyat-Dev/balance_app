import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Functions/user_form_functions.dart';

class SettingsForm extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String uid;

  SettingsForm({this.db, this.uid});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'User Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 20),
          FlatButton.icon(
              color: Colors.pink[500],
              icon: Icon(Icons.delete_forever),
              label: Text('Delete User'),
              onPressed: () {
                deleteUser(widget.db, widget.uid);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
