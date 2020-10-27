import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vote_app/Pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Home(),
  ));
}
