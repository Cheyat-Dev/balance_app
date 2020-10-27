import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Custom_Widgets/settings_form.dart';

class UserCards extends StatefulWidget {
  @override
  _UserCardsState createState() => _UserCardsState();
}

class _UserCardsState extends State<UserCards> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('userNames').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return Column(
              children: snapshot.data.documents.map<Widget>((doc) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    color: Colors.grey[850],
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              doc.data()['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: RawMaterialButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SettingsForm(
                                      db: db,
                                      uid: doc.documentID,
                                    );
                                  },
                                );
                              },
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
                                '${doc.data()['balance']}\$',
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
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
