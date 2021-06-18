
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Anuncio{

   late String _id;
   late String _estado;
   late String _animal;
   late String _titulo;
   late String _cidade;
   late String _cep;
   late String _telefone;
   late String _descricao;
   late List<String> _fotos;

   Anuncio(){

      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference anuncios = db.collection("meus_anuncios");
      this.id = anuncios.doc().id;


      this.fotos = [];
      //this.descricao = anuncios.doc().id;
      //this.descricao = [""].toString();
      //this.titulo = anuncios.doc().id;
      //this.titulo = [""].toString();
      //this.cep = anuncios.doc().id;
      //this.cep = [""].toString();
      //this.telefone = anuncios.doc().id;
      //this.telefone = [""].toString();
      //this.cidade = anuncios.doc().id;
      //this.cidade = [""].toString();


   }

   Map<String, dynamic> toMap(){


     Map<String, dynamic> map = {
        // ignore: unnecessary_statements
        "id" :this.id,
        // ignore: unnecessary_statements
        "estado" :this.estado,
        // ignore: unnecessary_statements
        "animal" :this.animal,
        // ignore: unnecessary_statements
        "titulo" :this.titulo,
        // ignore: unnecessary_statements
        "cidade" :this.cidade,
        // ignore: unnecessary_statements
        "cep" :this.cep,
        // ignore: unnecessary_statements
        "telefone" :this.telefone,
        // ignore: unnecessary_statements
        "descricao" :this.descricao,
        // ignore: unnecessary_statements
        "fotos" :this.fotos,

     };

     return map;
   }

   List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get animal => _animal;

  set animal(String value) {
    _animal = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}