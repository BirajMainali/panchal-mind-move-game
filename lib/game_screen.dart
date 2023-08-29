import 'package:flutter/material.dart';

import 'game_functions.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFa2d2ff),
      body: Center(
        child: IconMatrixBox(),
      ),
    );
  }
}

class IconMatrixBox extends StatefulWidget {
  const IconMatrixBox({super.key});

  @override
  State<IconMatrixBox> createState() => _IconMatrixBoxState();
}

class _IconMatrixBoxState extends State<IconMatrixBox> {
  @override
  Widget build(BuildContext context) {
    const borderWidth = 3.0;
    const width = 300.0;
    const height = 300.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "✨✨✨",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/board-wood.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white60, width: borderWidth),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 150,
                  right: 0,
                  child: Container(
                    height: 3,
                    color: Colors.black45,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 150,
                  bottom: 0,
                  child: Container(
                    width: 3,
                    color: Colors.black45,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 424 + borderWidth,
                    height: 3,
                    color: Colors.black45,
                    transform: Matrix4.rotationZ(45 * 0.0174533),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 424 + borderWidth,
                    height: 3,
                    color: Colors.black45,
                    transform: Matrix4.rotationZ(-45 * 0.0174533),
                  ),
                ),
                // 0,0
                _buildPositioned(
                  row: 0,
                  column: 0,
                  top: -6,
                  left: -6,
                ),
                // 0,1
                _buildPositioned(row: 0, column: 1, top: -6, left: (width / 2) - 20),
                // 0,2
                _buildPositioned(row: 0, column: 2, top: -6, right: -6),
                // 1,0
                _buildPositioned(row: 1, column: 0, top: width / 2 - 18, left: -6),
                // 1,1
                _buildPositioned(row: 1, column: 1, top: width / 2 - 20, left: width / 2 - 20),
                // 1,2
                _buildPositioned(row: 1, column: 2, top: width / 2 - 20, right: -6),
                // 2,0
                _buildPositioned(row: 2, column: 0, top: width - 38, left: -6),
                // 2,1
                _buildPositioned(row: 2, column: 1, top: width - 38, left: (width / 2) - 18),
                // 2,2
                _buildPositioned(row: 2, column: 2, top: width - 40, right: -6),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (GameFunctions.IsPlayer1())
                  const Icon(
                    Icons.person_2_rounded,
                    color: Colors.green,
                    size: 40,
                  ),
                ..._buildTurnIndicator(GameFunctions.getRemainingPins(GameFunctions.player1), Colors.blue),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (GameFunctions.IsPlayer2())
                  const Icon(
                    Icons.person_2_rounded,
                    color: Colors.green,
                    size: 40,
                  ),
                ..._buildTurnIndicator(GameFunctions.getRemainingPins(GameFunctions.player2), Colors.red),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (GameFunctions.winner.isNotEmpty)
              Text(
                'Winner : ${getPlayer(GameFunctions.winner)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        if (GameFunctions.winner.isNotEmpty)
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    GameFunctions.reset();
                    setState(() {});
                  },
                  child: const Text('Reset'))),
      ],
    );
  }

  _buildPositioned({required int row, required int column, double? top, double? left, double? right}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: () {
          GameFunctions.placePin(row: row, column: column);
          setState(() {});
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GameFunctions.isActiveToReplace(r: row, c: column) ? Colors.yellowAccent : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.indigoAccent,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                getPlayer(GameFunctions.matrix[row][column]),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getPlayer(String player) {
    return player == 'X'
        ? '🔵'
        : player == 'Y'
            ? '️🔴'
            : '';
  }
}

List<Widget> _buildTurnIndicator(int remainingPins, Color color) {
  List<Widget> pins = [];
  for (int i = 0; i < 3; i++) {
    pins.add(Icon(
      i < 3 - remainingPins ? Icons.check_circle : Icons.circle_outlined,
      color: color,
      size: 30,
    ));
  }
  return pins;
}
