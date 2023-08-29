class GameFunctions {
  static String player = "X";
  static String winner = "";
  static (int? row, int? column) active = (null, null);
  static List<List<String>> matrix = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  static void _setTurn() {
    if (checkWin(player)) {
      winner = player;
      return;
    }
    player = player == "X" ? "Y" : "X";
  }

  static bool _isInitialPinsArePlaced() {
    int count = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        if (matrix[i][j] == player) {
          count++;
        }
      }
    }
    return count >= 3;
  }

  static bool isActiveToReplace({required int r, required int c}) {
    return active == (r, c) && _isInitialPinsArePlaced();
  }

  static void placePin({required int row, required int column}) {
    var isInitialPinsArePlaced = _isInitialPinsArePlaced();

    if (isInitialPinsArePlaced) {
      if (active != (null, null)) {
        var activeRow = active.$1!;
        var activeColumn = active.$2!;
        matrix[activeRow][activeColumn] = '';
        matrix[row][column] = player;
        active = (null, null);
        _setTurn();
      } else {
        var hasNearestEmptyPosition = _hasNearestEmptyPosition(row: row, column: column);
        if (hasNearestEmptyPosition && matrix[row][column] == player) {
          active = (row, column);
        }
      }
    } else {
      _setPosition(row: row, column: column, player: player);
    }
  }

  static bool _hasNearestEmptyPosition({required int row, required int column}) {
    // Check all adjacent positions, including diagonals
    List<List<int>> directions = [
      [1, 0], // Down
      [-1, 0], // Up
      [0, 1], // Right
      [0, -1], // Left
      [1, 1], // Diagonal Down-Right
      [1, -1], // Diagonal Down-Left
      [-1, 1], // Diagonal Up-Right
      [-1, -1], // Diagonal Up-Left
    ];

    for (var dir in directions) {
      int newRow = row + dir[0];
      int newCol = column + dir[1];

      if (newRow >= 0 &&
          newRow < 3 && // Assuming a 3x3 matrix
          newCol >= 0 &&
          newCol < 3 && // Assuming a 3x3 matrix
          matrix[newRow][newCol] == '') {
        return true;
      }
    }

    return false;
  }

  static _setPosition({required int row, required int column, required String player}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = player;
    _setTurn();
  }

  static replacePin({required int row, required int column}) {
    _replacePositionOf(row: row, column: column, player: player);
  }

  static void _replacePositionOf({required int row, required int column, required String player}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'Y';
    _setTurn();
  }

  static bool _canSetPositionTo({required int row, required int column}) {
    if (checkWin(player)) return false;
    return matrix[row][column] == '' || matrix[row][column] == player;
  }

  static bool checkWin(String identifier) {
    return _checkRows(identifier) || _checkColumns(identifier) || _checkDiagonals(identifier);
  }

  static bool _checkRows(String identifier) {
    for (int i = 0; i < 3; i++) {
      if (matrix[i][0] == identifier && matrix[i][1] == identifier && matrix[i][2] == identifier) {
        return true;
      }
    }
    return false;
  }

  static bool _checkColumns(String identifier) {
    for (int i = 0; i < 3; i++) {
      if (matrix[0][i] == identifier && matrix[1][i] == identifier && matrix[2][i] == identifier) {
        return true;
      }
    }
    return false;
  }

  static bool _checkDiagonals(String identifier) {
    if (matrix[0][0] == identifier && matrix[1][1] == identifier && matrix[2][2] == identifier) {
      return true;
    }
    if (matrix[0][2] == identifier && matrix[1][1] == identifier && matrix[2][0] == identifier) {
      return true;
    }
    return false;
  }

  static void reset() {
    player = "X";
    winner = "";
    matrix = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
  }
}
