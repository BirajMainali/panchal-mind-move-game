class GameFunctions {
  static String turn = "X";
  static List<List<String>> matrix = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  static void _setTurn() {
    turn = turn == "X" ? "Y" : "X";
  }

  static placePin({required int row, required int column}) {
    if (turn == "X") {
      _setXPositionTo(row: row, column: column);
    } else {
      _setYPositionTo(row: row, column: column);
    }
  }

  static void _setXPositionTo({required int row, required int column}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'X';
    _setTurn();
  }

  static void _setYPositionTo({required int row, required int column}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'Y';
    _setTurn();
  }

  static bool _canSetPositionTo({required int row, required int column}) {
    return matrix[row][column] == '';
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
    matrix = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
  }
}
