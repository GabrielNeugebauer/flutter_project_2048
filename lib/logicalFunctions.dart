import 'dart:math';

class GameLogic {
  late List<List<int>> grid;
  late int moves;
  late int gridSize;
  bool gameOver = false;
  bool gameWon = false;

  // Inicia um novo jogo com base na dificuldade
  void startGame(int size) {
    gridSize = size;
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => 0));
    moves = 0;
    gameOver = false;
    gameWon = false;
    addRandomTile();
    addRandomTile();
  }

  // Adiciona um novo número (2 ou 4) em uma célula vazia
  void addRandomTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final random = Random();
      final index = random.nextInt(emptyCells.length);
      final point = emptyCells[index];
      grid[point.x][point.y] = random.nextInt(10) == 0 ? 4 : 2; // 10% de chance de ser 4
    }
  }

  // Move e mescla as células para cima
  void moveUp() {
    if (gameOver) return;
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [];
      for (int i = 0; i < gridSize; i++) {
        if (grid[i][j] != 0) {
          column.add(grid[i][j]);
        }
      }

      List<int> newColumn = _mergeTiles(column);
      for (int i = 0; i < gridSize; i++) {
        if (i < newColumn.length) {
          if (grid[i][j] != newColumn[i]) {
            grid[i][j] = newColumn[i];
            moved = true;
          }
        } else {
          if (grid[i][j] != 0) {
            grid[i][j] = 0;
            moved = true;
          }
        }
      }
    }
    if (moved) {
      moves += 1;
      addRandomTile();
      checkGameOver();
    }
  }

  // Move e mescla as células para baixo
  void moveDown() {
    if (gameOver) return;
    bool moved = false;
    for (int j = 0; j < gridSize; j++) {
      List<int> column = [];
      for (int i = gridSize - 1; i >= 0; i--) {
        if (grid[i][j] != 0) {
          column.add(grid[i][j]);
        }
      }

      List<int> newColumn = _mergeTiles(column);
      for (int i = 0; i < gridSize; i++) {
        int gridIndex = gridSize - 1 - i;
        if (i < newColumn.length) {
          if (grid[gridIndex][j] != newColumn[i]) {
            grid[gridIndex][j] = newColumn[i];
            moved = true;
          }
        } else {
          if (grid[gridIndex][j] != 0) {
            grid[gridIndex][j] = 0;
            moved = true;
          }
        }
      }
    }
    if (moved) {
      moves += 1;
      addRandomTile();
      checkGameOver();
    }
  }

  // Move e mescla as células para a esquerda
  void moveLeft() {
    if (gameOver) return;
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = [];
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] != 0) {
          row.add(grid[i][j]);
        }
      }

      List<int> newRow = _mergeTiles(row);
      for (int j = 0; j < gridSize; j++) {
        if (j < newRow.length) {
          if (grid[i][j] != newRow[j]) {
            grid[i][j] = newRow[j];
            moved = true;
          }
        } else {
          if (grid[i][j] != 0) {
            grid[i][j] = 0;
            moved = true;
          }
        }
      }
    }
    if (moved) {
      moves += 1;
      addRandomTile();
      checkGameOver();
    }
  }

  // Move e mescla as células para a direita
  void moveRight() {
    moves += 1;
    if (gameOver) return;
    bool moved = false;
    for (int i = 0; i < gridSize; i++) {
      List<int> row = [];
      for (int j = gridSize - 1; j >= 0; j--) {
        if (grid[i][j] != 0) {
          row.add(grid[i][j]);
        }
      }

      List<int> newRow = _mergeTiles(row);
      for (int j = 0; j < gridSize; j++) {
        int gridIndex = gridSize - 1 - j;
        if (j < newRow.length) {
          if (grid[i][gridIndex] != newRow[j]) {
            grid[i][gridIndex] = newRow[j];
            moved = true;
          }
        } else {
          if (grid[i][gridIndex] != 0) {
            grid[i][gridIndex] = 0;
            moved = true;
          }
        }
      }
    }
    if (moved) {
      moves += 1;
      addRandomTile();
      checkGameOver();
    }
  }

  // Lógica interna para mesclar uma linha ou coluna
  List<int> _mergeTiles(List<int> tiles) {
    if (tiles.length <= 1) {
      return tiles;
    }

    List<int> merged = [];
    int i = 0;
    while (i < tiles.length) {
      if (i + 1 < tiles.length && tiles[i] == tiles[i + 1]) {
        int newValue = tiles[i] * 2;
        merged.add(newValue);
        if (newValue == 2048) {
          gameWon = true;
        }
        i += 2;
      } else {
        merged.add(tiles[i]);
        i++;
      }
    }
    return merged;
  }

  // Verifica se o jogo terminou (sem movimentos possíveis)
  void checkGameOver() {
    bool canMove = false;
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j] == 0) {
          canMove = true;
          break;
        }
        // Verificar adjacente horizontal
        if (j + 1 < gridSize && grid[i][j] == grid[i][j + 1]) {
          canMove = true;
          break;
        }
        // Verificar adjacente vertical
        if (i + 1 < gridSize && grid[i][j] == grid[i + 1][j]) {
          canMove = true;
          break;
        }
      }
      if (canMove) break;
    }

    if (!canMove) {
      gameOver = true;
    }
  }
}