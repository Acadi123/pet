// @dart=2.9
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/models/Anuncio.dart';

class DetalhesAnuncio extends StatefulWidget {
  //const DetalhesAnuncio({Key? key}) : super(key: key);

  Anuncio anuncio;
  DetalhesAnuncio(this.anuncio);

  @override
  _DetalhesAnuncioState createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {

  Anuncio _anuncio;

  List<Widget> _getListaImagens(){

    List<String> listarUrlImagens = _anuncio.fotos;
    return listarUrlImagens.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth
          )
        ),
      );
    }).toList();


  }
  @override
  void initState() {
    super.initState();

    _anuncio = widget.anuncio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Detalhe Anúncio"),
      ),
      body: Stack(
        children: <Widget>[

          //conteudos
          ListView(children: <Widget>[

            SizedBox(
              height: 250,
              child: Carousel(
                images: _getListaImagens(),
                dotSize: 8,
                dotBgColor: Colors.transparent,
                dotColor: Colors.white,
                autoplay: false,
                dotIncreasedColor: Colors.redAccent,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _anuncio.titulo,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),
                  Text(
                    _anuncio.animal,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                  ),

                  Text(
                    "Descrição",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Text(
                    _anuncio.descricao,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    "Contato",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Text(
                    _anuncio.telefone,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    "CEP",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Text(
                    _anuncio.cep,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    "Cidade",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Text(
                    _anuncio.cidade,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),


                ],
              ),
            ),

          ],),
          //botao ligar
          Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: GestureDetector(
                child: Container(
                  child: Text(
                      "Ligar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
                onTap: (){

                },
              )
          ),
        ],
      ),
    );
  }
}
