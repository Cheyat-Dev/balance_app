import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> addUser(CollectionReference user, String name, int balance) {
  // Call the user's CollectionReference to add a new user
  return user
      .add({'name': name, 'balance': balance})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
