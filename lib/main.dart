import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class DiagonalBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = size.center(Offset.zero);

    // Draw diagonals from the center to each corner
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Positioning Game'),
        ),
        body: Center(
          child: Container(
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
        ),
      ),
    );
  }
}
