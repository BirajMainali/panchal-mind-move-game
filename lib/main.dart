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
        primarySwatch: Colors.blue,
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
      backgroundColor: Colors.indigoAccent,
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
            color: Colors.blueGrey,
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
                  color: Colors.cyan,
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
              Positioned(
                top: -4,
                left: -4,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 0, column: 0);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[0][0],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 0,1
              Positioned(
                top: -4,
                left: (300 / 2) - 12,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 0, column: 1);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[0][1],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 0,2
              Positioned(
                top: -4,
                right: -4,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 0, column: 2);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.purple,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[0][2],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 1,0
              Positioned(
                top: 300 / 2 - 10,
                left: -4,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 1, column: 0);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.purpleAccent,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[1][0],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 1,1
              Positioned(
                top: 300 / 2 - 11,
                left: 300 / 2 - 12,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 1, column: 1);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[1][1],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 1,2
              Positioned(
                top: (300 / 2) - 10,
                right: -4,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 1, column: 2);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.yellow,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[1][2],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 2,0
              Positioned(
                top: 300 - 28,
                left: -4,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 2, column: 0);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[2][0],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 2,1
              Positioned(
                top: 300 - 30,
                left: (300 / 2) - 12,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 2, column: 1);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black45,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[2][1],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 2,2
              Positioned(
                top: 300 - 28,
                right: -2,
                child: GestureDetector(
                  onTap: () {
                    GameFunctions.placePin(row: 2, column: 2);
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          GameFunctions.matrix[2][2],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
