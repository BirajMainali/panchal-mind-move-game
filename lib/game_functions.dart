class GameFunctions {
  static List<List<String>> matrix = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  static void setXPositionTo({required int row, required int column}) {
    if (!canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'X';
  }

  static void setYPositionTo({required int row, required int column}) {
    if (!canSetPositionTo(row: row, column: column)) return;
    matrix[row][column] = 'Y';
  }

  static bool canSetPositionTo({required int row, required int column}) {
    return matrix[row][column] == '';
  }

  static bool checkWin(String identifier) {
    return checkRows(identifier) || checkColumns(identifier) || checkDiagonals(identifier);
  }

  static bool checkRows(String identifier) {
    for (int i = 0; i < 3; i++) {
      if (matrix[i][0] == identifier && matrix[i][1] == identifier && matrix[i][2] == identifier) {
        return true;
      }
    }
    return false;
  }

  static bool checkColumns(String identifier) {
    for (int i = 0; i < 3; i++) {
      if (matrix[0][i] == identifier && matrix[1][i] == identifier && matrix[2][i] == identifier) {
        return true;
      }
    }
    return false;
  }

  static bool checkDiagonals(String identifier) {
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
