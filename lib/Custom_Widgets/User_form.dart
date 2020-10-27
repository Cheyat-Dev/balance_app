import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Functions/user_form_functions.dart';

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
