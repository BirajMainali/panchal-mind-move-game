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

  static bool isInitialPinsArePlaced() {
    int count = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        if (matrix[i][j] == turn) {
          count++;
        }
      }
    }
    return count == 3;
  }

  static placePin({required int row, required int column}) {
    if (isInitialPinsArePlaced()) {
      // _replacePositionOf(row: row, column: column, player: turn);
      return;
    }
    _setPosition(row: row, column: column, player: turn);
  }

  static _setPosition({required int row, required int column, required String player}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    if (matrix[row][column] == player) {
      matrix[row][column] = '';
      return;
    }
    matrix[row][column] = player;
    _setTurn();
  }

  static replacePin({required int row, required int column}) {
    _replacePositionOf(row: row, column: column, player: turn);
  }

  static void _replacePositionOf({required int row, required int column, required String player}) {
    if (!_canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'Y';
    _setTurn();
  }

  static bool _canSetPositionTo({required int row, required int column}) {
    return matrix[row][column] == '' || matrix[row][column] == turn;
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
