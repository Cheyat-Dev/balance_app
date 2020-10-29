import 'package:flutter/material.dart';
import 'package:vote_app/Custom_Widgets/User_form.dart';
import 'package:vote_app/Custom_Widgets/user_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),

              //List below
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  color: Colors.deepPurple[700],
                  height: 70,
                  child: Center(
                      child: Text(
                    'Saphal Dairy Pasal',
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
                child: UserCards(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
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
