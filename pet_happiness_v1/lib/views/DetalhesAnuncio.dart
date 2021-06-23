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
            )

          ],),
          //botao ligar
        ],
      ),
    );
  }
}
