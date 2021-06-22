// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_happiness_v1/util/Configuracoes.dart';


class Anuncios extends StatefulWidget {
  //const Anuncios({Key? key}) : super(key: key);

  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  List<String> itensMenu = [];
  List<DropdownMenuItem<String>> _listaItensDropCategrias;
  List<DropdownMenuItem<String>> _listaItensDropEstados;

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;


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

    Navigator.pushNamed(context, "/");

  }


  Future _verificarUsuarioLogado() async{
    
    //FirebaseAuth auth = FirebaseAuth.instance;
    User user = FirebaseAuth.instance.currentUser;
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
  _carregarItensDropdown(){


    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();

    //Animal
    _listaItensDropCategrias = Configuracoes.getCategorias();



  }



  @override
  void initState() {
    super.initState();

    _carregarItensDropdown();
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
        child: Column(
          children: <Widget>[

            //Filtros
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButton(
                          iconEnabledColor: Colors.redAccent,
                          value: _itemSelecionadoEstado,
                          items: _listaItensDropEstados,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black
                          ),
                          onChanged: (estado){
                            setState(() {
                              _itemSelecionadoEstado = estado;
                            });
                          },
                        ),
                      ),
                    )
                ),
                Container(
                  color: Colors.grey[200],
                  width: 2,
                  height: 60,
                ),
                Expanded(

                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButton(
                          iconEnabledColor: Colors.redAccent,
                          value: _itemSelecionadoCategoria,
                          items: _listaItensDropCategrias,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black
                          ),
                          onChanged: (animal){
                            setState(() {
                              _itemSelecionadoCategoria = animal;
                            });
                          },
                        ),
                      ),
                    )
                ),




              ],
            ),
            //Listagem de anúncios

          ],
        ),
      ),
    );
  }
}
