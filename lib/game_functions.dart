import 'package:vibration/vibration.dart';

class GameFunctions {
  static String currentPlayer = "X";
  static String player1 = "X";
  static String player2 = "Y";

  static String winner = "";

  static (int? row, int? column) active = (null, null);

  static List<List<String>> matrix = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  static void _setTurn() {
    if (checkWin(currentPlayer)) {
      winner = currentPlayer;
      return;
    }
    currentPlayer = currentPlayer == player1 ? player2 : player1;
  }

  static int getPlacedPinsOfPlayer(String player) {
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

  static int getRemainingPinsOfPlayer(String player) {
    return 3 - getPlacedPinsOfPlayer(player);
  }

  static bool _isDefaultPinsArePlaced() {
    int count = getPlacedPinsOfPlayer(currentPlayer);
    return count >= 3;
  }

  static bool isChosenToReplace({required int row, required int column}) {
    return active == (row, column) && _isDefaultPinsArePlaced();
  }

  static bool isCheckedAt({required int row, required column}) {
    return active == (row, column);
  }

  static void placePinAt({required int row, required int column}) {
    var defaultPinsArePlaced = _isDefaultPinsArePlaced();
    var chosenTarget = (active != (null, null));

    if (defaultPinsArePlaced && matrix[row][column] != "" && matrix[row][column] != currentPlayer) {
      Vibration.vibrate(duration: 250);
      return;
    }

    if (isCheckedAt(row: row, column: column)) {
      active = (null, null);
      return;
    }

    if (defaultPinsArePlaced && !chosenTarget) {
      if (matrix[row][column] == '') {
        Vibration.vibrate(duration: 250);
        return;
      }
      active = (row, column);
      return;
    }

    if (isOccupied(row: row, column: column)) return;
    if (defaultPinsArePlaced && chosenTarget) {
      var chosenRow = active.$1!;
      var chosenColumn = active.$2!;
      var canIgnore =
          canIgnoreTheCurrentMove(chosenRow: chosenRow, chosenColumn: chosenColumn, row: row, column: column);
      if (canIgnore) {
        matrix[chosenRow][chosenColumn] = "";
        _setPosition(row: row, column: column, player: currentPlayer);
        return;
      }
      if (!canIgnore) {
        var hasRowCombination = chosenRow == row;
        var hasColumnCombination = chosenColumn == column;
        if (hasRowCombination) {
          var colDiff = (chosenColumn - column).abs();
          if (colDiff == 1) {
            matrix[chosenRow][chosenColumn] = "";
            _setPosition(row: row, column: column, player: currentPlayer);
          }
        }
        if (hasColumnCombination) {
          var rowDiff = (chosenRow - row).abs();
          if (rowDiff == 1) {
            matrix[chosenRow][chosenColumn] = "";
            _setPosition(row: row, column: column, player: currentPlayer);
          }
        }
      }
    } else {
      _setPosition(row: row, column: column, player: currentPlayer);
    }
  }

  static bool isOccupied({required int row, required int column}) {
    var occupied = matrix[row][column] != '';
    if (occupied) {
      Vibration.vibrate(duration: 250);
    }
    return occupied;
  }

  static bool canIgnoreTheCurrentMove(
      {required int chosenRow, required int chosenColumn, required int row, required int column}) {
    var chosenTargetIsOnCenterOfMatrix = (chosenRow == 1 && chosenColumn == 1);
    var currentPositionIsCenterOfMatrix = (row == 1 && column == 1);
    return chosenTargetIsOnCenterOfMatrix || currentPositionIsCenterOfMatrix;
  }

  static _setPosition({required int row, required int column, required String player}) {
    matrix[row][column] = player;
    active = (null, null);
    _setTurn();
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
    currentPlayer = "X";
    winner = "";
    matrix = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
  }

  static isPlayer1() => currentPlayer == player1;

  static isPlayer2() => currentPlayer == player2;
}
