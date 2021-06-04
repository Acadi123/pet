import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'views/Home.dart';

final ThemeData tema = ThemeData(
  primaryColor: Colors.redAccent ,
  accentColor: Colors.red,
);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //future: Firebase.initializeApp(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
      ).copyWith(
        secondary: Colors.red,
      ),
      textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.redAccent)),
    ),

    title: "",
    home: Home(),
    //theme: tema,
    debugShowCheckedModeBanner: false,
  ));
}
