import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class DiagonalBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
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
  final Size pins = const Size(-10, 169);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Positioning Game'),
        ),
        body: Center(
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
              Positioned(
                  top: pins.width,
                  left: pins.width,
                  child: const Icon(
                    Icons.circle,
                    color: Colors.purple,
                    size: 40,
                  )),
              Positioned(
                  top: pins.height,
                  left: pins.width,
                  child: const Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 40,
                  )),
              Positioned(
                  top: pins.height * 2, left: pins.width, child: const Icon(Icons.circle, color: Colors.red, size: 40)),
              Positioned(
                  top: pins.width, left: pins.height, child: const Icon(Icons.circle, color: Colors.yellow, size: 40)),
              Positioned(
                  top: pins.height,
                  left: pins.height * 2,
                  child: const Icon(Icons.circle, color: Colors.blue, size: 40)),
              Positioned(
                  top: 0, left: pins.height * 2, child: const Icon(Icons.circle, color: Colors.orange, size: 40)),
              Positioned(
                  top: pins.height * 2,
                  left: pins.height,
                  child: const Icon(Icons.circle, color: Colors.pink, size: 40)),
              Positioned(
                  top: pins.height * 2,
                  left: pins.height * 2,
                  child: const Icon(Icons.circle, color: Colors.teal, size: 40)),
              Positioned(
                  top: pins.height, left: pins.height, child: const Icon(Icons.circle, color: Colors.brown, size: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
