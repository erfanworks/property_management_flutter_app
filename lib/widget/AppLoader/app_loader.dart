import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoader extends StatelessWidget {
  final String? message;
  final double size;

  const AppLoader({
    super.key,
    this.message,
    this.size = 60,
  });

  // ─── Navigator key ────────────────────────────────
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // ─── Show full screen overlay ─────────────────────
  static void show({String? message}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(80),
      builder: (_) => PopScope(
        canPop: false,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: AppLoader(message: message, size: 100),
          ),
        ),
      ),
    );
  }

  static void hide() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final navigator = Navigator.of(context, rootNavigator: true);
      if (navigator.canPop()) navigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size.w,
          height: size.w,
          child: const _ResidentialPulse(),
        ),
        if (message != null) ...[
          SizedBox(height: 12.h),
          Text(
            message!,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF0B3C6D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _ResidentialPulse extends StatefulWidget {
  const _ResidentialPulse();

  @override
  State<_ResidentialPulse> createState() => _ResidentialPulseState();
}

class _ResidentialPulseState extends State<_ResidentialPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => CustomPaint(
        painter: _ResidentialPulsePainter(progress: _controller.value),
        child: Center(
          child: _GlowCircle(
            glowOpacity: (sin(_controller.value * pi) * 80 + 40).toInt(),
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final int glowOpacity;

  const _GlowCircle({required this.glowOpacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF14B8A6).withAlpha(glowOpacity),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: _HouseIcon(size: 20, color: Color(0xFF0B3C6D)),
      ),
    );
  }
}

class _ResidentialPulsePainter extends CustomPainter {
  final double progress;

  const _ResidentialPulsePainter({required this.progress});

  static const _teal    = Color(0xFF14B8A6);
  static const _darkBlue = Color(0xFF0B3C6D);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    canvas.drawCircle(
      center,
      size.width / 2 - 6,
      Paint()
        ..color = _teal.withAlpha(30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + (progress * pi * 2),
      pi * 0.7,
      false,
      Paint()
        ..color = _teal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2 - (progress * pi * 2),
      pi * 0.5,
      false,
      Paint()
        ..color = _darkBlue.withAlpha(160)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_ResidentialPulsePainter old) =>
      old.progress != progress;
}

// House icon painter
class _HouseIcon extends StatelessWidget {
  final double size;
  final Color color;

  const _HouseIcon({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HouseIconPainter(color: color),
    );
  }
}

class _HouseIconPainter extends CustomPainter {
  final Color color;

  const _HouseIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.1, h * 0.52)
        ..lineTo(w * 0.5, h * 0.08)
        ..lineTo(w * 0.9, h * 0.52),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.18, h * 0.48)
        ..lineTo(w * 0.18, h * 0.92)
        ..lineTo(w * 0.82, h * 0.92)
        ..lineTo(w * 0.82, h * 0.48),
      paint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.40, h * 0.92)
        ..lineTo(w * 0.40, h * 0.68)
        ..quadraticBezierTo(w * 0.50, h * 0.60, w * 0.60, h * 0.68)
        ..lineTo(w * 0.60, h * 0.92),
      paint,
    );
  }

  @override
  bool shouldRepaint(_HouseIconPainter old) => old.color != color;
}