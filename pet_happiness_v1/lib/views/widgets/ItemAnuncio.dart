import 'package:flutter/material.dart';
import 'package:pet_happiness_v1/views/widgets/BotaoCustomizado.dart';

class ItemAnuncio extends StatelessWidget {
  const ItemAnuncio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[

              //Imagem
              SizedBox(
                width: 120,
                height: 120,
                child: Container(color: Colors.orange,),
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
                        "novo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("R\$ 152,00"),
                  ],),
                ),
              ),
              //botao remover
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: ElevatedButton.icon(
                    label: Text(""),
                    onPressed: (){},
                    icon: const Icon(Icons.delete, color: Colors.white,),
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
