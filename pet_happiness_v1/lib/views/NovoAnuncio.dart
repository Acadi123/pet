import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:pet_happiness_v1/views/widgets/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({Key? key}) : super(key: key);

  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  List<File> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  List<DropdownMenuItem<String>> _listaItensDropCategrias = [];


  //final  picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  //ImagePicker imagePicker = ImagePicker();

  _selecionarImagemGaleria() async {

    //PickedFile?  imagemSelecionada = await picker.getImage(source: ImageSource.gallery);
    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada);
      });

    }

  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
  }
  _carregarItensDropdown(){
    
    _listaItensDropEstados.add(
      DropdownMenuItem(child: Text("Recife"), value: "Recife",)
    );
    _listaItensDropEstados.add(
        DropdownMenuItem(child: Text("Camaragibe"), value: "Camaragibe",)
    );

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
                                  return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                  Image.file(_listaImagens[indice] ),
                                                  ElevatedButton.icon(
                                                      onPressed: (){
                                                        _listaImagens.remove(indice);
                                                        Navigator.of(context).pop();
                                                      },
                                                      icon: const Icon(Icons.delete),
                                                      label: Text("Excluir"))
                                                ],),
                                              )
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(_listaImagens[indice]),
                                          child: Container(
                                            color: Color.fromRGBO(255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: Icon(Icons.delete, color: Colors.red,),
                                          ),
                                        ),

                                      ),
                                  );
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
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          hint: Text("Cidades"),
                          items: _listaItensDropEstados,
                          onChanged: (valor){
                            
                          },
                        ),
                    )),
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
