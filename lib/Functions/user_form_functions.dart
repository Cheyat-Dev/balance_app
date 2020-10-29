import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser(CollectionReference user, String name, int balance) {
  // Call the user's CollectionReference to add a new user
  return user
      .add({'name': name, 'balance': balance})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> deleteUser(FirebaseFirestore db, String uid) =>
    db.collection('userNames').doc(uid).delete();

Future<bool> updateBalanceofUser(
    FirebaseFirestore db, String uid, int balance) {
  try {
    db.collection('userNames').doc(uid).update({
      'balance': balance,
    });
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}
