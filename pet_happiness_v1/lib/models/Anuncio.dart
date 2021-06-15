
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