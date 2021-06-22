// @dart=2.9
import 'package:brasil_fields/modelos/estados.dart';
import 'package:flutter/material.dart';


class Configuracoes {

  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> listaItensDropEstados = [];

    //Animal
    listaItensDropEstados.add(
        DropdownMenuItem(child: Text(
          "Estado", style: TextStyle(
            color: Colors.redAccent
        ),
        ), value: null,)
    );

    for ( var estado in Estados.listaEstados){
      listaItensDropEstados.add(
          DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }

    return listaItensDropEstados;
  }



  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Animal
    itensDropCategorias.add(
        DropdownMenuItem(child: Text(
            "Animal", style: TextStyle(
          color: Colors.redAccent
        ),
        ), value: null,)
    );
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Cachorro"), value: "Cachorro",)
    );
    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Gato"), value: "Gato",)
    );

    return itensDropCategorias;
  }

}