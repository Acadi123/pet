import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/views/widgets/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({Key? key}) : super(key: key);

  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  List<File> _listaImagens = List.empty();

  final _formKey = GlobalKey<FormState>();

  _selecionarImagemGaleria(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Novo Anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              //área de imagens
              FormField<List>(
                initialValue: _listaImagens,
                validator: ( imagens ){
                  if( imagens!.length == 0 ){
                    return "Necessário selecionar uma imagem!";

                  }
                  return null;
                },
                builder: (state){
                  return Column(children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listaImagens.length + 1,
                          itemBuilder: (context, indice){
                            //indice = 0 == _listaImagens.length
                                if( indice == _listaImagens.length ){
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: (){
                                        _selecionarImagemGaleria();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                             Icons.add_a_photo,
                                             size: 40,
                                             color: Colors.grey[100],
                                            ),
                                            Text(
                                                "Adicionar",
                                              style: TextStyle(
                                                color: Colors.grey[100]
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if( _listaImagens.length > 0 ){

                                }
                                return Container();
                          }
                      ),
                    ),
                    if( state.hasError )
                      Container(
                        child: Text(
                          "[${state.hasError}]",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14
                          ),
                        ),
                      )
                  ],);
                },

              ),
              //Menus Dropdown
              Row(children: <Widget>[
                Text("Estado"),
                Text("Categoria"),
              ],),
              //caixas de textos e botões
              Text("Caixas de textos"),
              BotaoCustomizado(
                  texto: "Cadastrar anúncio",
                  onPressed: (){
                    if( _formKey.currentState!.validate() ){

                    }

              }),

            ] ),
          ),
        ),
      ),
    );
  }
}