import 'package:flutter/material.dart';
import 'package:panchal/game_functions.dart';

void main() {
  runApp(MyApp());
}

class DiagonalBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = size.center(Offset.zero);

    canvas.drawLine(Offset.zero, center, paint); // Top-Left
    canvas.drawLine(Offset(size.width, 0), center, paint); // Top-Right
    canvas.drawLine(Offset(0, size.height), center, paint); // Bottom-Left
    canvas.drawLine(Offset(size.width, size.height), center, paint); // Bottom-Right
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Size pins = const Size(-10, 145);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Panchal"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            );
                          },
                        ),
                        CustomPaint(
                          painter: DiagonalBorderPainter(),
                          size: const Size(400, 400),
                        ),
                      ],
                    ),
                  ),
                  buildPositioned(top: pins.width, left: pins.width, row: 0, column: 0),
                  buildPositioned(top: pins.height, left: pins.width, row: 1, column: 0),
                  buildPositioned(top: pins.height * 2, left: pins.width, row: 2, column: 0),
                  buildPositioned(top: pins.height, left: pins.width, row: 1, column: 0),
                  buildPositioned(top: pins.width, left: pins.height, row: 0, column: 1),
                  buildPositioned(top: pins.height, left: pins.height * 2, row: 1, column: 2),
                  buildPositioned(top: pins.width, left: pins.height * 2, row: 0, column: 2),
                  buildPositioned(top: pins.height * 2, left: pins.height, row: 2, column: 1),
                  buildPositioned(top: pins.height * 2, left: pins.height * 2, row: 2, column: 2),
                  buildPositioned(top: pins.height * 2, left: pins.height, row: 1, column: 1),
                ],
              ),
            ),
            Text(
              "Turn: ${GameFunctions.turn}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Positioned buildPositioned({required double top, required double left, required int row, required int column}) {
    return Positioned(
        top: top,
        left: left,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  GameFunctions.matrix[row][column],
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
