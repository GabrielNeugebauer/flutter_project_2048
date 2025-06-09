import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(Jogo2048App());
}
class Jogo2048App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo 2048',
      home: Jogo2048(),
    );
  }
}

class Jogo2048 extends StatefulWidget {
  @override
  _Jogo2048State createState() => _Jogo2048State();
}
class _Jogo2048State extends State<Jogo2048> {
  @override
  int moveCount = 0;
  int gridSize = 4;
  List<List<int>> grid = [];

  void moveLeft() {
    setState(() {
      bool moved = false;
      for (int i = 0; i < gridSize; i++) {
        List<int> row = grid[i].where((val) => val != 0).toList();
        for (int j = 0; j < row.length - 1; j++) {
          if (row[j] == row[j + 1]) {
            row[j] *= 2;
            row[j + 1] = 0;
            moved = true;
          }
        }
        row = row.where((val) => val != 0).toList();
        while (row.length < gridSize) {
          row.add(0);
        }
        if (!ListEquality().equals(grid[i], row)) moved = true;
        grid[i] = row;
      }
      if (moved) {
        moveCount++;
        addNewTile();
      }
    });
  }

  void moveRight() {
    setState(() {
      bool moved = false;
      for (int i = 0; i < gridSize; i++) {
        List<int> row = grid[i].where((val) => val != 0).toList().reversed.toList();
        for (int j = 0; j < row.length - 1; j++) {
          if (row[j] == row[j + 1]) {
            row[j] *= 2;
            row[j + 1] = 0;
            moved = true;
          }
        }
        row = row.where((val) => val != 0).toList();
        while (row.length < gridSize) {
          row.add(0);
        }
        row = row.reversed.toList();
        if (!ListEquality().equals(grid[i], row)) moved = true;
        grid[i] = row;
      }
      if (moved) {
        moveCount++;
        addNewTile();
      }
    });
  }

  void moveUp() {
    setState(() {
      bool moved = false;
      for (int j = 0; j < gridSize; j++) {
        List<int> col = [];
        for (int i = 0; i < gridSize; i++) {
          if (grid[i][j] != 0) col.add(grid[i][j]);
        }
        for (int i = 0; i < col.length - 1; i++) {
          if (col[i] == col[i + 1]) {
            col[i] *= 2;
            col[i + 1] = 0;
            moved = true;
          }
        }
        col = col.where((val) => val != 0).toList();
        while (col.length < gridSize) {
          col.add(0);
        }
        for (int i = 0; i < gridSize; i++) {
          if (grid[i][j] != col[i]) moved = true;
          grid[i][j] = col[i];
        }
      }
      if (moved) {
        moveCount++;
        addNewTile();
      }
    });
  }

  void moveDown() {
    setState(() {
      bool moved = false;
      for (int j = 0; j < gridSize; j++) {
        List<int> col = [];
        for (int i = gridSize - 1; i >= 0; i--) {
          if (grid[i][j] != 0) col.add(grid[i][j]);
        }
        for (int i = 0; i < col.length - 1; i++) {
          if (col[i] == col[i + 1]) {
            col[i] *= 2;
            col[i + 1] = 0;
            moved = true;
          }
        }
        col = col.where((val) => val != 0).toList();
        while (col.length < gridSize) {
          col.add(0);
        }
        for (int i = gridSize - 1, k = 0; i >= 0; i--, k++) {
          if (grid[i][j] != col[k]) moved = true;
          grid[i][j] = col[k];
        }
      }
      if (moved) {
        moveCount++;
        addNewTile();
      }
    });
  }

  void initState() {
    super.initState();
    resetGame();
  }
  void resetGame() {
    moveCount = 0;
    grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
    addNewTile();
    addNewTile();
  }
  void addNewTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          emptyTiles.add(i * gridSize + j);
        }
      }
    }
    if (emptyTiles.isNotEmpty) {
      int randomIndex = emptyTiles[(emptyTiles.length * 0.5).floor()];
      grid[randomIndex ~/ gridSize][randomIndex % gridSize] = 2;
    }
  }
  // Draw interface
  @override
  Widget build(BuildContext context) {
    double viewsize = View.of(context).physicalSize.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo 2048'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Movimentos: $moveCount', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(

              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                childAspectRatio: viewsize/.45,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      grid[row][col] == 0 ? '' : grid[row][col].toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Directional buttons
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_upward),
                    iconSize: 40,
                    onPressed: moveUp,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 40,
                    onPressed: moveLeft,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    iconSize: 40,
                    onPressed: moveRight,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 40,
                    onPressed: moveDown,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

