import 'package:flutter/material.dart';
import 'package:panchal/game_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.teal,
        fontFamily: 'Montserrat',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: IconMatrixBox(),
      ),
    );
  }
}

class IconMatrixBox extends StatefulWidget {
  @override
  State<IconMatrixBox> createState() => _IconMatrixBoxState();
}

class _IconMatrixBoxState extends State<IconMatrixBox> {
  @override
  Widget build(BuildContext context) {
    const borderWidth = 2.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (GameFunctions.winner.isNotEmpty)
          Text(
            'Winner: ${GameFunctions.winner}',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        Text(
          'Turn: ${GameFunctions.player}',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.teal,
            border: Border.all(color: Colors.black, width: borderWidth),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 150,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: 0,
                left: 150,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 424 + borderWidth,
                  height: 1,
                  color: Colors.black,
                  transform: Matrix4.rotationZ(45 * 0.0174533),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: 424 + borderWidth,
                  height: 1,
                  color: Colors.black,
                  transform: Matrix4.rotationZ(-45 * 0.0174533),
                ),
              ),
              // 0,0
              _buildPositioned(
                row: 0,
                column: 0,
                top: -4,
                left: -4,
              ),
              // 0,1
              _buildPositioned(row: 0, column: 1, top: -4, left: (300 / 2) - 12),
              // 0,2
              _buildPositioned(row: 0, column: 2, top: -4, right: -4),
              // 1,0
              _buildPositioned(row: 1, column: 0, top: 300 / 2 - 10, left: -4),
              // 1,1
              _buildPositioned(row: 1, column: 1, top: 300 / 2 - 11, left: 300 / 2 - 12),
              // 1,2
              _buildPositioned(row: 1, column: 2, top: 300 / 2 - 10, right: -4),
              // 2,0
              _buildPositioned(row: 2, column: 0, top: 300 - 28, left: -4),
              // 2,1
              _buildPositioned(row: 2, column: 1, top: 300 - 30, left: (300 / 2) - 12),
              // 2,2
              _buildPositioned(row: 2, column: 2, top: 300 - 28, right: -4),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (GameFunctions.winner.isNotEmpty)
          ElevatedButton(
              onPressed: () {
                GameFunctions.reset();
                setState(() {});
              },
              child: const Text('Re-start')),
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
          width: 30,
          height: 30,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GameFunctions.isActiveToReplace(r: row, c: column) ? Colors.yellow : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                GameFunctions.matrix[row][column],
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
