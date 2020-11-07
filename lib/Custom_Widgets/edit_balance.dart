import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Functions/user_form_functions.dart';

class EditBalanceForm extends StatefulWidget {
  FirebaseFirestore db;
  String uid;
  int balance;
  int maxSliderValue;

  EditBalanceForm({this.db, this.uid, this.balance, this.maxSliderValue});

  @override
  _EditBalanceFormState createState() => _EditBalanceFormState();
}

class _EditBalanceFormState extends State<EditBalanceForm> {
  bool hasBeenAlreadyImported = false;
  int _balance;
  double offsetValue = 0;

  int returnAddedBalance(int _balance, double offsetValue) {
    return ((_balance + 0.0) + offsetValue).round();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasBeenAlreadyImported) {
      hasBeenAlreadyImported = true;
      _balance = widget.balance;
    }

    int sliderDivisions = widget.maxSliderValue ~/ 5;

    return Container(
      color: Colors.grey[850],
      height: 600,
      child: Form(
        child: Column(
          children: <Widget>[
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
                          'User Balance',
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

            //Balance
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 70.0,
                vertical: 10.0,
              ),
              color: Colors.pink[400],
              child: Text(
                'Rs. ${_balance.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.visible,
                softWrap: false,
              ),
            ),

            SizedBox(height: 20),
            //TextFormField
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                initialValue: widget.balance.toString(),
                onChanged: (value) {
                  setState(() {
                    _balance = int.parse(value);
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Edit User\'s Balance',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 20),

            //Slider
            Slider(
              min: 0,
              max: widget.maxSliderValue.toDouble(),
              value: offsetValue,
              divisions: sliderDivisions,
              onChanged: (val) {
                setState(() {
                  offsetValue = val;
                });
              },
              label: offsetValue.round().toString(),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                  color: Colors.pink[500],
                  icon: Icon(Icons.remove),
                  label: Text('Subtract'),
                  onPressed: () {
                    if (returnAddedBalance(_balance, -offsetValue) >= 0) {
                      setState(() {
                        _balance = returnAddedBalance(_balance, -offsetValue);
                      });
                    } else {
                      setState(() {
                        _balance = 0;
                      });
                    }
                  },
                ),
                FlatButton.icon(
                  color: Colors.pink[500],
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  onPressed: () {
                    setState(() {
                      _balance = returnAddedBalance(_balance, offsetValue);
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            //Update button
            FlatButton.icon(
              color: Colors.amber[300],
              icon: Icon(Icons.file_upload),
              label: Text('Update User'),
              onPressed: () async {
                Navigator.pop(context);
                if (!(await updateBalanceofUser(
                    widget.db, widget.uid, _balance))) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Actions failed'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
