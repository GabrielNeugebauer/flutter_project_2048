import 'package:flutter/material.dart';
import 'navigationButtons.dart';
import 'header.dart';

void main() {
  runApp(Jogo2048App());
}
class Jogo2048App extends StatefulWidget {
  State<Jogo2048App> createState(){
    return _Jogo2048State(); //Por ser uma classe, ao ser chamada como uma funçao, busca a funçao build() incluida dentro da classe. Build e opcional.
  }
}
class _Jogo2048State extends State<Jogo2048App>{
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jogo 2048",
      home: Column(
        children: [
          createHeader(),
          createNavigationButtons()
        ]
      ), //Dentro dos argumentos de MaterialApp, por isso a virgula
    );//Tela da aplicaçao
  }
}

