import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  int maxSliderValue;
  Function updater;
  AppSettings({this.maxSliderValue, this.updater});

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  int _currentMaxValue = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      height: 500,
      child: Form(
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                initialValue: widget.maxSliderValue.toString(),
                onChanged: (value) {
                  _currentMaxValue = int.parse(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Max Slider Value',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            SizedBox(height: 20),

            //Update button
            FlatButton.icon(
              color: Colors.amber[300],
              icon: Icon(Icons.file_upload),
              label: Text('Update App'),
              onPressed: () {
                widget.updater(_currentMaxValue);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 230),
          ],
        ),
      ),
    );
  }
}
