import 'package:flutter/material.dart';
import 'logicalFunctions.dart';

void main() {
  runApp(Jogo2048App());
}

class Jogo2048App extends StatefulWidget {
  @override
  _Jogo2048AppState createState() => _Jogo2048AppState();
}

class _Jogo2048AppState extends State<Jogo2048App> {
  final GameLogic _game = GameLogic();
  late int _gridSize; //Declara sem inicializar
  late double _cellSize;
  String _gameMessage = "";

  @override
  void initState() {
    super.initState();
    _setDifficulty(5); // Inicia no nível médio por padrão
  }

  void _setDifficulty(int size) {
    setState(() {
      _gridSize = size;
      if (size == 4) {
        _cellSize = 90.0;
      } else if (size == 5) {
        _cellSize = 70.0;
      } else {
        _cellSize = 60.0;
      }
      _game.startGame(size);
      _updateGameMessage();
    });
  }

  void _handleMove(Function moveFunction) {
    setState(() {
      moveFunction();
      _updateGameMessage();
    });
  }

  void _updateGameMessage() {
    if (_game.gameWon) {
      _gameMessage = "Você Venceu!";
    } else if (_game.gameOver) {
      _gameMessage = "Fim de Jogo!";
    } else {
      _gameMessage = "";
    }
  }

  Widget createHeader() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text("Jogo 2048", style: TextStyle(fontSize: 20, color: Colors.orangeAccent)),
            Spacer(),
            Text("Movimentos: ${_game.moves}", style: TextStyle(fontSize: 20, color: Colors.orangeAccent)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(_gameMessage, style: TextStyle(fontSize: 22, color: Colors.red, fontWeight: FontWeight.bold)),
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () => _setDifficulty(4),
                child: Text("Fácil", style: TextStyle(fontSize: 20, color: Colors.black))),
            Spacer(),
            ElevatedButton(
                onPressed: () => _setDifficulty(5),
                child: Text("Médio", style: TextStyle(fontSize: 20, color: Colors.black))),
            Spacer(),
            ElevatedButton(
                onPressed: () => _setDifficulty(6),
                child: Text("Difícil", style: TextStyle(fontSize: 20, color: Colors.black)))
          ],
        )
      ],
    );
  }

  Container createCell(int value, double size) {
    return Container(
      color: _getCellColor(value), // Cor baseada no valor
      width: size,
      height: size,
      child: Center(
        child: Text(
          value == 0 ? "" : value.toString(),
          style: TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Função para dar cor às células
  Color _getCellColor(int value) {
    switch (value) {
      case 2: return Colors.grey.shade300;
      case 4: return Colors.grey.shade400;
      case 8: return Colors.yellow.shade400;
      case 16: return Colors.amber.shade400;
      case 32: return Colors.orange.shade400;
      case 64: return Colors.deepOrange.shade400;
      case 128: return Colors.red.shade300;
      case 256: return Colors.red.shade400;
      case 512: return Colors.red.shade500;
      case 1024: return Colors.red.shade600;
      case 2048: return Colors.green.shade500;
      default: return Colors.grey.shade200;
    }
  }


  Widget createGrid() {
    return Column(
      children: [
        for (int i = 0; i < _gridSize; i++) ...[
          Row(
            children: [
              for (int j = 0; j < _gridSize; j++) ...[
                createCell(_game.grid[i][j], _cellSize),
                if (j < _gridSize - 1) Spacer(),
              ]
            ],
          ),
          if (i < _gridSize - 1) SizedBox(height: 10),
        ]
      ],
    );
  }

  Widget createNavigationButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.arrow_upward), iconSize: 40, onPressed: () => _handleMove(_game.moveUp)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.arrow_back), iconSize: 40, onPressed: () => _handleMove(_game.moveLeft)),
            SizedBox(width: 20),
            IconButton(icon: Icon(Icons.arrow_forward), iconSize: 40, onPressed: () => _handleMove(_game.moveRight)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.arrow_downward), iconSize: 40, onPressed: () => _handleMove(_game.moveDown)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jogo 2048",
      home: Scaffold( // Scaffold oferece uma estrutura básica de layout
        backgroundColor: Colors.blueGrey.shade900, // Cor de fundo da tela
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              createHeader(),
              SizedBox(height: 20),
              createGrid(),
              SizedBox(height: 20),
              createNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}