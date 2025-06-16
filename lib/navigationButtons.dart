import 'package:flutter/material.dart';

Widget createNavigationButtons () {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_upward),
            iconSize: 40,
            onPressed: (){},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 40,
            onPressed: (){},
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            iconSize: 40,
            onPressed: (){},
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_downward),
            iconSize: 40,
            onPressed: (){},
          ),
        ],
      ),
    ],
  );
}