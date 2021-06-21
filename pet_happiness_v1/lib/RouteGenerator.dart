// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:pet_happiness_v1/RouteGenerator.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/views/Anuncios.dart';
import 'package:pet_happiness_v1/views/Login.dart';
import 'package:pet_happiness_v1/views/MeusAnuncios.dart';
import 'package:pet_happiness_v1/views/NovoAnuncio.dart';

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
      case "/meus-anuncios":
        return MaterialPageRoute(
            builder: (_) => MeusAnuncios()
        );
      case "/novo-anuncio":
        return MaterialPageRoute(
            builder: (_) => NovoAnuncio()
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