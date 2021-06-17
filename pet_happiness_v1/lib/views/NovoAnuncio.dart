import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:pet_happiness_v1/models/Anuncio.dart';
import 'package:pet_happiness_v1/views/widgets/BotaoCustomizado.dart';
import 'package:pet_happiness_v1/views/widgets/InputCustomizado.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:validadores/Validador.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({Key? key}) : super(key: key);

  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  List<File> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  List<DropdownMenuItem<String>> _listaItensDropCategrias = [];
  late BuildContext _dialogContext;


  TextEditingController _nada = TextEditingController(text: "");
  TextEditingController _nadaa = TextEditingController(text: "");
  TextEditingController _nadaaa = TextEditingController(text: "");
  TextEditingController _nadaaaa = TextEditingController(text: "");
  TextEditingController _nadaaaaa = TextEditingController(text: "");




  //final  picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  //ImagePicker imagePicker = ImagePicker();
  late Anuncio _anuncio;


  _selecionarImagemGaleria() async {

    //PickedFile?  imagemSelecionada = await picker.getImage(source: ImageSource.gallery);
    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada);
      });

    }

  }

  _abrirDialog(BuildContext context){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text("Salvando anúncio...")
            ],),
          );
        }
    );

  }


  _salvarAnuncio() async {

    _abrirDialog(_dialogContext);

    //Upload imagens no Storage
    await _uploadImagens();

    //print("Lista imagens: ${_anuncio.fotos.toString()}");

    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    String idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("meus_anuncios")
      .doc(idUsuarioLogado)
      .collection("anuncios")
      .doc(_anuncio.id)
      .set(_anuncio.toMap()).then((_) {

        Navigator.pop(_dialogContext);

        Navigator.pop(context);
    });



  }

  Future _uploadImagens() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for ( var imagem in _listaImagens ) {
      
      String nomeImagem = DateTime.now().microsecondsSinceEpoch.toString();

      Reference arquivo = pastaRaiz
          .child("meus_anuncios")
          .child(_anuncio.id)
          .child(nomeImagem);

      UploadTask uploadTask = arquivo.putFile(imagem);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos.add(url);

    }

  }


  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();

    _anuncio = Anuncio();


  }
  _carregarItensDropdown(){

    //Cidades
    //_listaItensDropEstados.add(
    //  DropdownMenuItem(child: Text("Recife"), value: "Recife",)
   // );
    //_listaItensDropEstados.add(
    //    DropdownMenuItem(child: Text("Camaragibe"), value: "Camaragibe",)
   // );
    for ( var estado in Estados.listaEstados){
      _listaItensDropEstados.add(
        DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }
    _listaItensDropCategrias.add(
      DropdownMenuItem(child: Text("Cachorro"), value: "Cachorro",)
    );
    _listaItensDropCategrias.add(
      DropdownMenuItem(child: Text("Gato"), value: "Gato",)
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
              new Wrap(spacing: 4,
                runSpacing: 2,
                direction: Axis.horizontal,
                children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          hint: Text("Selecione o Estado"),
                          onSaved: ( estado){
                            _anuncio.estado = estado.toString();

                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                          items: _listaItensDropEstados,
                          validator: (valor){
                            return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatório").valido("valor");
                          },
                          onChanged: (valor){
                            
                          },
                        ),
                    ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DropdownButtonFormField(
                      hint: Text("Animal"),
                      onSaved: ( animal){
                        _anuncio.animal = animal.toString();

                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                      ),
                      items: _listaItensDropCategrias,
                      validator: (valor){
                        return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatório").valido("valor");
                      },
                      onChanged: (valor){

                      },
                    ),
                  ),
                ),
              ],),
              //caixas de textos e botões
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: "titulo"
                        ),
                        onSaved: (titulo) {
                          _anuncio.titulo = titulo!;
                        }


                    ),
                  ),
              //Padding(
                //  padding: EdgeInsets.only(bottom: 15, top: 15),
                  //child: InputCustomizado(
                    //  onSaved: (titulo){
                      //  _anuncio.titulo = titulo.toString();
                      //},
                      //controller: _nada,
                      //hint: "Título do Anúncio",
                      //inputFormatters: [],
                      //maxLines: 1
                  //),
              //),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.location_city),
                            hintText: "cidade"
                        ),
                        onSaved: (cidade) {
                          _anuncio.cidade = cidade!;
                        }


                    ),
                  ),
                  //Padding(
                    //padding: EdgeInsets.only(bottom: 15),
                    //child: InputCustomizado(
                      //  controller: _nadaaaaa,
                        //hint: "Cidade",
                        //onSaved: (cidade){
                         // _anuncio.cidade = cidade.toString();
                        //},
                        //type: TextInputType.number,
                        //inputFormatters: [],
                        //maxLines: 1
                    //),
                  //),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.location_on),
                            hintText: "cep"
                        ),
                        onSaved: (cep) {
                          _anuncio.cep = cep!;
                        }


                    ),
                  ),
                 // Padding(
                   //   padding: EdgeInsets.only(bottom: 15),
                     // child: InputCustomizado(
                       //   controller: _nadaa,
                         // hint: "CEP",
                          //onSaved: (cep){
                           // _anuncio.cep = cep.toString();
                          //},
                          //type: TextInputType.number,
                          //inputFormatters: [
                            //FilteringTextInputFormatter.digitsOnly,
                            //CepInputFormatter()
                          //],
                          //maxLines: 1
                      //),
                  //),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            hintText: "Telefone"
                        ),
                        onSaved: (telefone) {
                          _anuncio.telefone = telefone!;
                        }


                    ),
                  ),
                  //Padding(
                    //padding: EdgeInsets.only(bottom: 15),
                    //child: InputCustomizado(
                      //  controller: _nadaaa,
                       // hint: "Telefone",
                       // onSaved: (telefone){
                         // _anuncio.telefone = telefone.toString();
                        //},
                        //type: TextInputType.phone,
                        //inputFormatters: [
                          //FilteringTextInputFormatter.digitsOnly,
                          //TelefoneInputFormatter()
                        //],
                        //maxLines: 1
                    //),
                  //),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.add_comment_rounded),
                          hintText: "Descrição"
                        ),
                        onSaved: (descricao) {
                          _anuncio.descricao = descricao!;
                        }


                      ),
                  ),
                  //Padding(
                    //  padding: EdgeInsets.only(bottom: 15),
                      //child: InputCustomizado(
                        //  controller: _nadaaaa,
                          //hint: "Descrição do Anúncio",
                          //onSaved: (descricao){
                            //_anuncio.descricao = descricao;
                          //},
                          //inputFormatters: [],
                          //maxLines: 3
                      //),
                  //),
              BotaoCustomizado(
                  texto: "Cadastrar Anúncio",
                  onPressed: (){
                    if( _formKey.currentState!.validate() ){


                      //salva campos
                      _formKey.currentState!.save();

                      //configura dialog context
                      _dialogContext = context;

                      //salvar anuncio
                      _salvarAnuncio();



                    }

              }),

            ] ),
          ),
        ),
      ),
    );
  }
}
