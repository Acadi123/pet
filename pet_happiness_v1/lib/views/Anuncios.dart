import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Anuncios extends StatefulWidget {
  const Anuncios({Key? key}) : super(key: key);

  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  List<String> itensMenu = [];


  _escolhaMenuItem(String itemEscolhido){

    switch( itemEscolhido){

      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Acessar  /  Cadastrar" :
        Navigator.pushNamed(context, "/Login");
        break;
      case "Sair" :
        _deslogarUsuario();
        break;
    }

  }

  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/Login");

  }


  Future _verificarUsuarioLogado() async{
    
    //FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    //FirebaseUser userCredential = await auth.currentUser();

    if( user == null){
      itensMenu = [
        "Acessar  /  Cadastrar"
      ];

    }else{
      itensMenu = [
        "Meus anúncios", "Sair"
      ];
    }
    

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _verificarUsuarioLogado();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Happiness"),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: _escolhaMenuItem,
              itemBuilder: (context){
                return itensMenu.map((String item){
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();

              },
          )
        ],
      ),
      body: Container(
        child: Text("Anúncios"),
      ),
    );
  }
}
