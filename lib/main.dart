import 'package:flutter/material.dart';

//TODO Initialize Firebase
//TODO Convert the mock data into firebase data
//TODO Make the  Number editable directly

//Mock Class
//TODO Replace the mock class
class User{
  String name;
  int balance;

  User({this.name  , this.balance = 0});
}
//Mock Class


void main() {

  

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Mock List
  //TODO Replace the Mock List
  List<User> users = [
    User(name: 'David'),
    User(name: 'Dan'),
    User(name: 'Amy'),
    User(name: 'Jane'),
  ];
  //Mock List

  //Mock SetState Function
  int changeBalance(int balance , User user){
    setState(() {
      user.balance += balance;
    });
    return 0;
  }
  //Mock SetState Function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Balance App'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),

            //Down below is just for the text for user's balance
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30
                ),
              child: Expanded(
                child: Container(
                  color: Colors.purple[700],
                  height: 100,
                  child: Center(
                    child: Text(
                      'Users\' Balance' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      )
                    ),
                ),
              ),
            ),
            //Up Above is just for the text for user's balance

            SizedBox(height: 40,),

            //List below
            Padding(
              padding: const EdgeInsets.all(0),
              child: Expanded(
                child: Container(
                  color: Colors.grey[700],
                  height: 70,
                  child: Center(
                    child: Text(
                      'List' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                      )
                    ),
                ),
              ),
            ),
            //List above

            SizedBox(height: 40,),
            
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return userCard(users[index] , changeBalance);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column userCard(User currentUser , Function changeBalance){
  return Column(
    children: <Widget>[
      Card(
        color: Colors.grey[800],
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex : 5,
                child: Text(
                  currentUser.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.5
                  ),
                ),
              ),

              Expanded(
                flex : 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                    ),
                    label: Text(''),
                    onPressed: () {
                      if(currentUser.balance > 0) changeBalance(-1000 , currentUser);
                    },
                ),
              ),

              Expanded(
                flex : 4,
                child: FlatButton.icon(
                  shape: CircleBorder(),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    ),
                    label: Text(''),
                    onPressed: () {
                      changeBalance(1000 , currentUser);
                    },
                ),
              ),

              Expanded(
                flex : 7,
                child: Center(
                  child: Text(
                    '${currentUser.balance.toString()}\$',
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
      SizedBox(height: 10,)
    ],
  );
}