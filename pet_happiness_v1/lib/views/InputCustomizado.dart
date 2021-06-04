import 'package:flutter/material.dart';


class InputCustomizado extends StatelessWidget {
  //const InputCustomizado({Key? key}) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;

  InputCustomizado({
    required this.controller,
    required this.hint,
    this.autofocus = false,
    this.obscure = false,
    this.type = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      obscureText: this.obscure,
      autofocus: this.autofocus,
      //obscureText: true,
      keyboardType: this.type,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 6, 20, 6),
          hintText: "Senha",
          filled: true,
          //fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.vertical()
          )
      ),
    );
  }
}
