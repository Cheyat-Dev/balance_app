import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
