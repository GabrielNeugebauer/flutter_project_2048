import 'package:flutter/material.dart';

Container createCell(double size){
  return Container(
      color: Colors.grey,
      width: size,
      height: size,
      child: Text("0", style: TextStyle(fontSize: 50, color: Colors.black),));
}
//4v4:90, 5v5:75, 6v6:60
createGrid(int size, double sizeCell){
  return Column(
    children: [
      for (int i = 0; i < size; i++) ...[
        Row(
          children: [
            for (int i = 0; i < size; i++) ...[
              createCell(sizeCell),
              if (i < size-1) Spacer(), // Adiciona um Spacer entre os itens, mas não depois do último
            ]
          ],
        ),
        SizedBox(height: 10),//Espaço vazio, para separar os Rows
      ]
    ]
  );
}