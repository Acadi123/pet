// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_happiness_v1/RouteGenerator.dart';
import 'package:pet_happiness_v1/views/Anuncios.dart';


import 'views/Login.dart';

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
    home: Anuncios(),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    //theme: tema,
    debugShowCheckedModeBanner: false,
  ));
}
