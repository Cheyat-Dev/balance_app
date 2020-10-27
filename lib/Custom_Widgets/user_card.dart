import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Functions/user_form_functions.dart';

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
                flex: 3,
                child: RawMaterialButton(
                  onPressed: () async {},
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  shape: CircleBorder(),
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
