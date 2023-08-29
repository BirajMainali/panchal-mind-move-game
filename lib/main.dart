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
        primaryColor: Colors.yellowAccent,
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
    return const Scaffold(
      backgroundColor: Colors.blue,
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
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.blueGrey, width: borderWidth),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 150,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.white60,
                ),
              ),
              Positioned(
                top: 0,
                left: 150,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.white60,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 424 + borderWidth,
                  height: 1,
                  color: Colors.white60,
                  transform: Matrix4.rotationZ(45 * 0.0174533),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: 424 + borderWidth,
                  height: 1,
                  color: Colors.white60,
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
              _buildPositioned(row: 2, column: 1, top: width - 38, left: (width / 2) - 20),
              // 2,2
              _buildPositioned(row: 2, column: 2, top: width - 38, right: -6),
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
          width: 40,
          height: 40,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GameFunctions.isActiveToReplace(r: row, c: column) ? Colors.yellow : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                GameFunctions.matrix[row][column],
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
}
