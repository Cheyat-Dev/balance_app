import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/Custom_Widgets/edit_balance.dart';
import 'package:vote_app/Custom_Widgets/settings_form.dart';

class UserCards extends StatefulWidget {
  int maxSliderValue;
  UserCards({this.maxSliderValue});

  @override
  _UserCardsState createState() => _UserCardsState();
}

class _UserCardsState extends State<UserCards> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    bool isEven = true;
    Color color;
    return ListView(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userNames')
              .orderBy('name')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return Column(
              children: snapshot.data.documents.map<Widget>((doc) {
                if (isEven) color = Colors.grey[300];
                if (!isEven) color = Colors.grey[700];
                isEven = !isEven;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    color: color,
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              doc.data()['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: RawMaterialButton(
                              fillColor: Colors.grey,
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SettingsForm(
                                      db: db,
                                      uid: doc.documentID,
                                      userName: doc.data()['name'],
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: FlatButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return EditBalanceForm(
                                        db: db,
                                        uid: doc.documentID,
                                        balance: doc.data()['balance'],
                                        maxSliderValue: widget.maxSliderValue,
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Rs. ${doc.data()['balance']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
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
