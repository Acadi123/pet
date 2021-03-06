// @dart=2.9
import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  //const BotaoCustomizado({Key? key}) : super(key: key);

  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado({
    this.texto,
    this.corTexto = Colors.white,
    this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: this.onPressed,
        icon: const Icon(Icons.login),
        label: Text( this.texto),
    );
  }
}
