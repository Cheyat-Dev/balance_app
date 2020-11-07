import 'package:flutter/material.dart';
import 'package:vote_app/Custom_Widgets/User_form.dart';
import 'package:vote_app/Custom_Widgets/app_settings_form.dart';
import 'package:vote_app/Custom_Widgets/user_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int maxSliderValue = 200;

  int updater(int toBeUpdatedValue) {
    setState(() {
      maxSliderValue = toBeUpdatedValue;
    });
    return maxSliderValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 70,
            child: Center(
                child: Text(
              'Saphal Dairy Pasal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            )),
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return AppSettings(
                    maxSliderValue: maxSliderValue,
                    updater: updater,
                  );
                },
              );
            },
            icon: Icon(
              Icons.settings_applications,
              color: Colors.white,
            ),
            label: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: UserCards(maxSliderValue: maxSliderValue),
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
