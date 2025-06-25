import 'package:flutter/material.dart';

Widget create4v4Grid(){
  return Column(
    children: [
      for (int i = 0; i < 4; i++) ...[
      Row(
        children: [
          for (int i = 0; i < 4; i++) ...[
            createCell(90),
            if (i < 3) Spacer(), // Adiciona um Spacer entre os itens, mas não depois do último
          ]
        ],
      ),
      SizedBox(height: 10),//Espaço vazio, para separar os Rows
     ]
    ]
  );
}

//Grid 5v5

Widget create5v5Grid(){
  return Column(
      children: [
        for (int i = 0; i < 5; i++) ...[
          Row(
            children: [
              for (int i = 0; i < 5; i++) ...[
                createCell(75),
                if (i < 4) Spacer(), // Adiciona um Spacer entre os itens, mas não depois do último
              ]
            ],
          ),
          SizedBox(height: 10),//Espaço vazio, para separar os Rows
        ]
      ]
  );
}
//Grid 6v6
Widget create6v6Grid(){
  return Column(
      children: [
        for (int i = 0; i < 6; i++) ...[
          Row(
            children: [
              for (int i = 0; i < 6; i++) ...[
                createCell(60),
                if (i < 5) Spacer(), // Adiciona um Spacer entre os itens, mas não depois do último
              ]
            ],
          ),
          SizedBox(height: 10),//Espaço vazio, para separar os Rows
        ]
      ]
  );
}

Container createCell(double size){
  return Container(
    color: Colors.grey,
    width: size,
    height: size,
    child: Text("0", style: TextStyle(fontSize: 50, color: Colors.black),));
}