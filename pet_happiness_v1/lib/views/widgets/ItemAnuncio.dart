// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/models/Anuncio.dart';
import 'package:pet_happiness_v1/views/widgets/BotaoCustomizado.dart';

class ItemAnuncio extends StatelessWidget {
  //const ItemAnuncio({Key? key}) : super(key: key);

  Anuncio anuncio;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemAnuncio(
      {
      @required this.anuncio,
        this.onTapItem,
        this.onPressedRemover
      });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[

              //Imagem
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                    anuncio.fotos[0],
                    fit: BoxFit.cover,
                ),
              ),
              //Titulo e animal
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(
                        anuncio.titulo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(anuncio.descricao),
                  ],),
                ),
              ),
              //botao remover
              if(this.onPressedRemover != null)Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: ElevatedButton.icon(
                    label: Text(""),
                    onPressed: this.onPressedRemover,
                    icon: const Icon(Icons.delete_forever_outlined, color: Colors.white,),
                  ),

                )


              ),
            ],
          ),
        ),
      ),
    );
  }
}
