class GameFunctions {
  static String player = "X";
  static String winner = "";
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

  static bool isInitialPinsArePlaced() {
    int count = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        if (matrix[i][j] == player) {
          count++;
        }
      }
    }
    return count == 3;
  }

  static placePin({required int row, required int column}) {
    if (isInitialPinsArePlaced()) {
      var (x, y) = _getNearByEmptyPosition(row: row, column: column);
      if (x != row || y != column) {
        _replacePositionOf(row: x, column: y, player: player);
        return;
      }
      return;
    }
    _setPosition(row: row, column: column, player: player);
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

  static (int row, int column) _getNearByEmptyPosition({required int row, required int column}) {
    for (int r = -1; r <= 1; r++) {
      for (int c = -1; c <= 1; c++) {
        if (r == 0 && c == 0) continue;
        int newRow = row + r;
        int newCol = column + c;
        if (newRow >= 0 &&
            newRow < matrix.length &&
            newCol >= 0 &&
            newCol < matrix[newRow].length &&
            matrix[newRow][newCol] == '') {
          return (newRow, newCol);
        }
      }
    }
    return (row, column);
  }

  static void reset() {
    matrix = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
  }
}
