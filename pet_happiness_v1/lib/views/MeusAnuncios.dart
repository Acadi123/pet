// @dart=2.9
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/models/Anuncio.dart';
import 'package:pet_happiness_v1/views/widgets/ItemAnuncio.dart';


class MeusAnuncios extends StatefulWidget {
  //const MeusAnuncios({Key? key}) : super(key: key);

  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuarioLogado;

  _recuperarDadosUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    _idUsuarioLogado = usuarioLogado.uid;

  }


  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async{

    await _recuperarDadosUsuarioLogado();


    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .doc(_idUsuarioLogado)
        .collection("anuncios")
        .snapshots();

    stream.listen((dados) {
       _controller.add(dados);
    });

    //return _adicionarListenerAnuncios();
  }

  _removerAnuncio(String idAnuncio){

    //removendo de anuncios apenas usuario

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meus_anuncios")
      .doc(_idUsuarioLogado)
      .collection("anuncios")
      .doc(idAnuncio)
      .delete().then((_){

        //removendo de anuncios geral

        db.collection("anuncios")
            .doc(idAnuncio)
            .delete();
        
    });

  }

  @override
  void initState() {
    //_adicionarListenerAnuncios();



    super.initState();
    _adicionarListenerAnuncios();
  }


  @override
  Widget build(BuildContext context) {

    var carregandoDados = Center(
      child: Column(children: <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ]),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Meus Anúncios"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/novo-anuncio");
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot){
          switch( snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:

            //Exibe mensagem de erro
              if(snapshot.hasError)
                return Text("Erro ao carregar os dados!");

              QuerySnapshot querySnapshot = snapshot.data;


              return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (_, indice){

                    List<DocumentSnapshot> anuncios = querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = anuncios[indice];
                    Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                    return ItemAnuncio(
                      anuncio: anuncio,
                      onPressedRemover: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Confirmar"),
                                content: Text("Deseja realmente excluir o anúncio?"),
                                actions: <Widget>[
                                  ElevatedButton.icon(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      label: Text("Cancelar"),
                                      icon: const Icon(Icons.cancel_outlined),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: (){
                                      _removerAnuncio( anuncio.id );
                                      Navigator.of(context).pop();
                                    },
                                    label: Text("Remover"),
                                    icon: const Icon(Icons.delete_forever_outlined),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                      onTapItem: (){},
                    );
                  }
              );



          }return Container();


        },

      ),
    );
  }
}
