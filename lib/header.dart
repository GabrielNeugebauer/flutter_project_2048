import 'package:flutter/material.dart';

Widget createHeader() {
  return Column(
    children: [
      Container(
        child: Text(""),//Pula a primeira linha, para ficar mais organizado
      ),
      Row(
        children: [
          Text("Jogo 2048",style: TextStyle(fontSize: 20, color: Colors.orangeAccent),),
          Spacer(),
          Text("Movimentos: 0", style: TextStyle(fontSize: 20, color: Colors.orangeAccent),)
        ],
      ),
      Container(
        child: Text(""),//Espaço para: você ganhou/perdeu
      ),
      Row(
        children: [
          ElevatedButton(
              onPressed: (){},//nivelFacil()
              child: Text("Fácil", style: TextStyle(fontSize: 20, color: Colors.black),)
          ),
          Spacer(),//Espaçador
          ElevatedButton(
              onPressed: (){},//nivelMedio()
              child: Text("Médio", style: TextStyle(fontSize: 20, color: Colors.black),)
          ),
          Spacer(),//Espaçador
          ElevatedButton(
              onPressed: (){},//nivelDificil()
              child: Text("Difícil", style: TextStyle(fontSize: 20, color: Colors.black),)
          )
        ],
      )
    ],
  );
}