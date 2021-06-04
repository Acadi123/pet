import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/models/Usuario.dart';
import 'package:pet_happiness_v1/views/InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerEmail = TextEditingController(text: "acadi@hotmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "1234567" );

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //redireciona para tela principal

    });

  }

  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //redireciona para tela principal

    });



  }

  _validarcampos() {

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if(senha.isNotEmpty && senha.length > 6) {


        //configurar usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;


        //cadastrar ou logar
        if( _cadastrar ) {
          //cadastrar
          _cadastrarUsuario(usuario);
        }else{
          //Logar
          _logarUsuario(usuario);
        }


      }else {
        setState(() {
          _mensagemErro = "Preencha a senha com mais de 6 caracteres";
        });
      }
    }else {
      setState(() {
        _mensagemErro = "Preencha um email válido";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(''),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child:  Image.asset(
                      "Imagens/logo.png",
                  width: 200,
                  height: 160,
                  ),
                ),
                InputCustomizado(
                    controller: _controllerEmail,
                    hint: "Email",
                    autofocus: true,
                    type: TextInputType.emailAddress,
                ),
                InputCustomizado(
                    controller: _controllerSenha,
                    hint: "Senha",
                    obscure: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Acessar"),
                    Switch(
                        activeColor: Colors.redAccent,
                        value: _cadastrar,
                        onChanged: (bool valor){
                          setState(() {
                            _cadastrar = valor;
                            _textoBotao = "Entrar";
                            if(_cadastrar){
                              _textoBotao = "Cadastrar";
                            }
                          });
                        }),
                    Text("Cadastrar"),
                  ],
                ),
                ElevatedButton.icon(
                    onPressed: (){
                      _validarcampos();

                    },
                    icon: const Icon(Icons.login),
                    label: Text( _textoBotao)
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(_mensagemErro,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),
                    ),
                )
              ],
            )
          )
        ),
      ),
    );
  }
}
