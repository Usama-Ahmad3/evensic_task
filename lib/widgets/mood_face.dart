import 'package:flutter/material.dart';

const _faceColors = {
  'calm': Color(0xFFF0B090),
  'happy': Color(0xFFF0B090),
  'content': Color(0xFFFFD060),
  'peaceful': Color(0xFFE8A870),
  'energetic': Color(0xFFFFB347),
  'focused': Color(0xFF90C8D4),
  'reflective': Color(0xFFC4B0D8),
  'relaxed': Color(0xFFFFB8A0),
};

class MoodFace extends StatelessWidget {
  final String variant;
  final double size;

  const MoodFace({super.key, required this.variant, this.size = 110});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(variant),
        width: size,
        height: size,
        child: CustomPaint(
          painter: _FacePainter(variant: variant),
        ),
      ),
    );
  }
}

class _FacePainter extends CustomPainter {
  final String variant;

  const _FacePainter({required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 100;
    final bg = _faceColors[variant] ?? const Color(0xFFF0B090);

    final bgPaint = Paint()..color = bg;
    canvas.drawRRect(
      RRect.fromLTRBR(8 * s, 8 * s, 92 * s, 92 * s, Radius.circular(20 * s)),
      bgPaint,
    );

    final stroke = Paint()
      ..color = const Color(0xCC5A3020)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (variant) {
      case 'calm':
        _drawCalm(canvas, s, stroke);
      case 'happy':
        _drawHappy(canvas, s, stroke);
      case 'content':
        _drawContent(canvas, s, stroke);
      case 'peaceful':
        _drawPeaceful(canvas, s, stroke);
      case 'energetic':
        _drawEnergetic(canvas, s, stroke);
      case 'focused':
        _drawFocused(canvas, s, stroke);
      case 'reflective':
        _drawReflective(canvas, s, stroke);
      case 'relaxed':
        _drawRelaxed(canvas, s, stroke);
      default:
        _drawCalm(canvas, s, stroke);
    }
  }

  void _drawCalm(Canvas canvas, double s, Paint stroke) {
    final cheek = Paint()..color = const Color(0x59D27864);
    canvas.drawCircle(Offset(37 * s, 47 * s), 6 * s, cheek);
    canvas.drawCircle(Offset(63 * s, 47 * s), 6 * s, cheek);

    final leftEye = Path()
      ..moveTo(31 * s, 38 * s)
      ..quadraticBezierTo(38 * s, 46 * s, 44 * s, 38 * s);
    canvas.drawPath(leftEye, stroke);

    final rightEye = Path()
      ..moveTo(56 * s, 38 * s)
      ..quadraticBezierTo(63 * s, 46 * s, 69 * s, 38 * s);
    canvas.drawPath(rightEye, stroke);

    final mouth = Path()
      ..moveTo(40 * s, 57 * s)
      ..quadraticBezierTo(50 * s, 63 * s, 60 * s, 57 * s);
    canvas.drawPath(mouth, stroke);
  }

  void _drawHappy(Canvas canvas, double s, Paint stroke) {
    final leftEye = Path()
      ..moveTo(30 * s, 42 * s)
      ..quadraticBezierTo(37 * s, 36 * s, 44 * s, 42 * s);
    canvas.drawPath(leftEye, stroke);

    final rightEye = Path()
      ..moveTo(56 * s, 42 * s)
      ..quadraticBezierTo(63 * s, 36 * s, 70 * s, 42 * s);
    canvas.drawPath(rightEye, stroke);

    final mouth = Path()
      ..moveTo(34 * s, 55 * s)
      ..quadraticBezierTo(50 * s, 68 * s, 66 * s, 55 * s);
    canvas.drawPath(mouth, Paint()
      ..color = const Color(0xCC5A3020)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2 * s
      ..strokeCap = StrokeCap.round);
  }

  void _drawContent(Canvas canvas, double s, Paint stroke) {
    final dark = Paint()
      ..color = const Color(0xCC3A2810)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8 * s
      ..strokeCap = StrokeCap.round;

    final leftEye = Path()
      ..moveTo(30 * s, 42 * s)
      ..quadraticBezierTo(38 * s, 32 * s, 46 * s, 42 * s);
    canvas.drawPath(leftEye, dark);

    final rightEye = Path()
      ..moveTo(54 * s, 42 * s)
      ..quadraticBezierTo(62 * s, 32 * s, 70 * s, 42 * s);
    canvas.drawPath(rightEye, dark);

    final mouth = Path()
      ..moveTo(36 * s, 56 * s)
      ..quadraticBezierTo(50 * s, 67 * s, 64 * s, 56 * s);
    canvas.drawPath(mouth, Paint()
      ..color = const Color(0xCC3A2810)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3 * s
      ..strokeCap = StrokeCap.round);
  }

  void _drawPeaceful(Canvas canvas, double s, Paint stroke) {
    final dot = Paint()..color = const Color(0xCC3A2810);
    canvas.drawCircle(Offset(38 * s, 42 * s), 3.5 * s, dot);
    canvas.drawCircle(Offset(62 * s, 42 * s), 3.5 * s, dot);

    final mouth = Path()
      ..moveTo(40 * s, 57 * s)
      ..quadraticBezierTo(50 * s, 64 * s, 60 * s, 57 * s);
    canvas.drawPath(mouth, stroke);
  }

  void _drawEnergetic(Canvas canvas, double s, Paint stroke) {
    final dot = Paint()..color = const Color(0xCC5A3020);
    canvas.drawCircle(Offset(38 * s, 40 * s), 4 * s, dot);
    canvas.drawCircle(Offset(62 * s, 40 * s), 4 * s, dot);

    final mouth = Path()
      ..moveTo(34 * s, 55 * s)
      ..quadraticBezierTo(50 * s, 68 * s, 66 * s, 55 * s);
    canvas.drawPath(mouth, Paint()
      ..color = const Color(0xCC5A3020)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2 * s
      ..strokeCap = StrokeCap.round);

    final spark = Paint()
      ..color = const Color(0xCC5A3020)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final sparkPath = Path()
      ..moveTo(46 * s, 29 * s)
      ..lineTo(48 * s, 23 * s)
      ..lineTo(54 * s, 29 * s);
    canvas.drawPath(sparkPath, spark);
  }

  void _drawFocused(Canvas canvas, double s, Paint stroke) {
    final dark = Paint()
      ..color = const Color(0xCC2A4A5A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8 * s
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(31 * s, 38 * s), Offset(44 * s, 41 * s), dark);
    canvas.drawLine(Offset(56 * s, 41 * s), Offset(69 * s, 38 * s), dark);

    final dot = Paint()..color = const Color(0xCC2A4A5A);
    canvas.drawCircle(Offset(38 * s, 41 * s), 3 * s, dot);
    canvas.drawCircle(Offset(62 * s, 41 * s), 3 * s, dot);

    final mouth = Path()
      ..moveTo(42 * s, 57 * s)
      ..quadraticBezierTo(50 * s, 62 * s, 58 * s, 57 * s);
    canvas.drawPath(mouth, dark);
  }

  void _drawReflective(Canvas canvas, double s, Paint stroke) {
    final dark = Paint()
      ..color = const Color(0xCC4A3060)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8 * s
      ..strokeCap = StrokeCap.round;

    final leftEye = Path()
      ..moveTo(33 * s, 41 * s)
      ..quadraticBezierTo(38 * s, 36 * s, 43 * s, 41 * s);
    canvas.drawPath(leftEye, dark);

    final rightEye = Path()
      ..moveTo(57 * s, 41 * s)
      ..quadraticBezierTo(62 * s, 36 * s, 67 * s, 41 * s);
    canvas.drawPath(rightEye, dark);

    final mouth = Path()
      ..moveTo(40 * s, 57 * s)
      ..quadraticBezierTo(50 * s, 63 * s, 60 * s, 57 * s);
    canvas.drawPath(mouth, dark);

    canvas.drawCircle(
      Offset(50 * s, 66 * s),
      2.5 * s,
      Paint()..color = const Color(0x664A3060),
    );
  }

  void _drawRelaxed(Canvas canvas, double s, Paint stroke) {
    final leftEye = Path()
      ..moveTo(33 * s, 38 * s)
      ..quadraticBezierTo(38 * s, 45 * s, 43 * s, 38 * s);
    canvas.drawPath(leftEye, stroke);

    final rightEye = Path()
      ..moveTo(57 * s, 38 * s)
      ..quadraticBezierTo(62 * s, 45 * s, 67 * s, 38 * s);
    canvas.drawPath(rightEye, stroke);

    final mouth = Path()
      ..moveTo(40 * s, 57 * s)
      ..quadraticBezierTo(50 * s, 63 * s, 60 * s, 57 * s);
    canvas.drawPath(mouth, stroke);
  }

  @override
  bool shouldRepaint(covariant _FacePainter old) => old.variant != variant;
}
