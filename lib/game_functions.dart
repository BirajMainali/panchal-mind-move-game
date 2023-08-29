class GameFunctions {
  static String player = "X";
  static String XPlayer = "X";
  static String YPlayer = "Y";
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
    player = player == XPlayer ? YPlayer : XPlayer;
  }

  static int getPins(String player) {
    int count = 0;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix.length; j++) {
        if (matrix[i][j] == player) {
          count++;
        }
      }
    }
    return count;
  }

  static int getRemainingPins(String player) {
    return 3 - getPins(player);
  }

  static bool _isInitialPinsArePlaced() {
    int count = getPins(player);
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
        if (activeRow == row && activeColumn == column) {
          active = (null, null);
          return;
        }
        if (!_canSetPositionTo(row: row, column: column)) return;
        var distance = (row - activeRow).abs() + (column - activeColumn).abs();
        if (distance != 1) return;
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
    if (row == 0 && column == 0) {
      return matrix[row][column + 1] == '' || matrix[row + 1][column] == '';
    }
    if (row == 0 && column == 1) {
      return matrix[row][column - 1] == '' || matrix[row][column + 1] == '' || matrix[row + 1][column] == '';
    }
    if (row == 0 && column == 2) {
      return matrix[row][column - 1] == '' || matrix[row + 1][column] == '';
    }
    if (row == 1 && column == 0) {
      return matrix[row][column + 1] == '' || matrix[row - 1][column] == '' || matrix[row + 1][column] == '';
    }
    if (row == 1 && column == 1) {
      return matrix[row][column - 1] == '' ||
          matrix[row][column + 1] == '' ||
          matrix[row - 1][column] == '' ||
          matrix[row + 1][column] == '';
    }
    if (row == 1 && column == 2) {
      return matrix[row][column - 1] == '' || matrix[row - 1][column] == '' || matrix[row + 1][column] == '';
    }
    if (row == 2 && column == 0) {
      return matrix[row][column + 1] == '' || matrix[row - 1][column] == '';
    }
    if (row == 2 && column == 1) {
      return matrix[row][column - 1] == '' || matrix[row][column + 1] == '' || matrix[row - 1][column] == '';
    }
    if (row == 2 && column == 2) {
      return matrix[row][column - 1] == '' || matrix[row - 1][column] == '';
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
