import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
  

      // Path number 1
  

      paint.color = Color(0xffffffff).withOpacity(0);
      path = Path();
      path.lineTo(0, 0);
      path.cubicTo(0, 0, 0, size.height * 0.27, 0, size.height * 0.27);
      path.cubicTo(0, size.height * 0.27, size.width * 0.04, size.height * 0.16, size.width * 0.08, size.height * 0.14);
      path.cubicTo(size.width * 0.12, size.height * 0.11, size.width * 0.16, size.height * 0.13, size.width / 5, size.height * 0.1);
      path.cubicTo(size.width * 0.23, size.height * 0.08, size.width * 0.27, 0, size.width * 0.27, 0);
      path.cubicTo(size.width * 0.27, 0, 0, 0, 0, 0);
      canvas.drawPath(path, paint);
  

      // Path number 2
  

      paint.color = Color(0xffa0a0a0);
      path = Path();
      path.lineTo(0, size.height / 2);
      path.cubicTo(0, size.height / 2, 0, 0, 0, 0);
      path.cubicTo(0, 0, size.width / 2, 0, size.width / 2, 0);
      path.cubicTo(size.width * 0.78, 0, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, size.width * 0.94, size.height * 0.12, size.width * 0.91, size.height * 0.17);
      path.cubicTo(size.width * 0.85, size.height * 0.27, size.width * 0.79, size.height * 0.34, size.width * 0.75, size.height * 0.37);
      path.cubicTo(size.width * 0.73, size.height * 0.39, size.width * 0.7, size.height * 0.41, size.width * 0.67, size.height * 0.42);
      path.cubicTo(size.width * 0.64, size.height * 0.43, size.width * 0.6, size.height * 0.44, size.width * 0.52, size.height * 0.45);
      path.cubicTo(size.width * 0.45, size.height * 0.47, size.width * 0.42, size.height * 0.47, size.width * 0.38, size.height * 0.48);
      path.cubicTo(size.width * 0.35, size.height * 0.49, size.width * 0.31, size.height * 0.51, size.width * 0.29, size.height * 0.52);
      path.cubicTo(size.width * 0.26, size.height * 0.54, size.width * 0.22, size.height * 0.58, size.width * 0.19, size.height * 0.63);
      path.cubicTo(size.width * 0.13, size.height * 0.71, size.width * 0.06, size.height * 0.85, size.width * 0.01, size.height);
      path.cubicTo(size.width * 0.01, size.height, 0, size.height, 0, size.height);
      path.cubicTo(0, size.height, 0, size.height / 2, 0, size.height / 2);
      canvas.drawPath(path, paint);
  

      // Path number 3
  

      paint.color = Color(0xffa0a0a0);
      path = Path();
      path.lineTo(0, size.height * 0.24);
      path.cubicTo(0, size.height * 0.16, 0, size.height * 0.08, 0, 0);
      path.cubicTo(size.width * 0.09, 0, size.width * 0.18, 0, size.width * 0.26, 0);
      path.cubicTo(size.width * 0.24, size.height * 0.04, size.width * 0.22, size.height * 0.08, size.width / 5, size.height * 0.1);
      path.cubicTo(size.width * 0.17, size.height * 0.12, size.width * 0.14, size.height * 0.12, size.width * 0.11, size.height * 0.13);
      path.cubicTo(size.width * 0.09, size.height * 0.13, size.width * 0.07, size.height * 0.14, size.width * 0.06, size.height * 0.16);
      path.cubicTo(size.width * 0.03, size.height * 0.19, size.width * 0.02, size.height * 0.22, 0, size.height * 0.26);
      path.cubicTo(0, size.height / 4, 0, size.height * 0.24, 0, size.height * 0.24);
      path.cubicTo(0, size.height * 0.24, 0, size.height * 0.24, 0, size.height * 0.24);
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }