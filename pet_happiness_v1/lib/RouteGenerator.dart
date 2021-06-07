import 'package:flutter/cupertino.dart';
import 'package:pet_happiness_v1/RouteGenerator.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/views/Anuncios.dart';
import 'package:pet_happiness_v1/views/Login.dart';

class RouteGenerator {

  static Route <dynamic> generateRoute (RouteSettings settings) {

    final args = settings.arguments;

    switch( settings.name ){
      case "/":
        return MaterialPageRoute(
            builder: (_) => Anuncios()

        );
      case "/Login":
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      default:
        _erroRota();

    }

  return generateRoute(settings);
  }
  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("tela não encontrada"),
          ),
          body: Center(
            child: Text("Tela não encontrada"),
          ),


        );
      }
    );

  }

}