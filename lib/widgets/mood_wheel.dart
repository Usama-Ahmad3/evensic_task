import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task/theme/app_theme.dart';
import '../data/app_data.dart';
import 'mood_face.dart';

class MoodWheel extends StatefulWidget {
  final double initialAngle;
  final ValueChanged<double>? onAngleChange;
  final double size;

  const MoodWheel({
    super.key,
    this.initialAngle = 45,
    this.onAngleChange,
    this.size = 80,
  });

  @override
  State<MoodWheel> createState() => _MoodWheelState();
}

class _MoodWheelState extends State<MoodWheel> {
  late double _angle;

  static const double _strokeWidth = 30;
  static const double _dotSize = 57;

  @override
  void initState() {
    super.initState();
    _angle = widget.initialAngle;
  }

  double get _trackRadius => widget.size / 2 - _strokeWidth / 2;

  Offset get _center => Offset(widget.size / 2, widget.size / 2);

  Offset get _handlePosition {
    final rad = (_angle - 90) * pi / 180;
    return Offset(
      _center.dx + _trackRadius * cos(rad),
      _center.dy + _trackRadius * sin(rad),
    );
  }

  void _updateAngle(Offset local) {
    final dx = local.dx - _center.dx;
    final dy = local.dy - _center.dy;
    final rad = atan2(dy, dx);
    final deg = (rad * 180 / pi + 90 + 360) % 360;
    setState(() => _angle = deg);
    widget.onAngleChange?.call(deg);
  }

  @override
  Widget build(BuildContext context) {
    final mood = getMoodAtAngle(_angle);
    final handle = _handlePosition;

    return GestureDetector(
      onPanStart: (d) => _updateAngle(d.localPosition),
      onPanUpdate: (d) => _updateAngle(d.localPosition),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _RingPainter(strokeWidth: _strokeWidth),
            ),
            Center(
              child: MoodFace(variant: mood.variant, size: widget.size * 0.42),
            ),
            Positioned(
              left: handle.dx - _dotSize / 2,
              top: handle.dy - _dotSize / 2,
              child: Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double strokeWidth;

  const _RingPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        colors: const [
          Color(0xFFF99955),
          Color(0xFF6EB9AD),
          Color(0xFFC9BBEF),
          Color(0xFFF28DB3),
          Color(0xFFF99955),
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        transform: GradientRotation(5 * pi / 4),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);

    // Radial divider lines on the ring every 45°
    final innerR = size.width / 2 - strokeWidth;
    final outerR = size.width / 2;
    final dividerPaint = Paint()
      ..color = Colors.white.withAlpha(100)
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.butt;

    for (int i = 0; i < 8; i++) {
      final angle = i * pi / 4; // every 45°
      final cosA = cos(angle);
      final sinA = sin(angle);
      canvas.drawLine(
        Offset(center.dx + innerR * cosA, center.dy + innerR * sinA),
        Offset(center.dx + outerR * cosA, center.dy + outerR * sinA),
        dividerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.strokeWidth != strokeWidth;
}
