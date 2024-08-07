import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meal_mate/utils/colors.dart';

class BackgroundWidget extends StatefulWidget {
  final Widget child;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;
  final Color? color5;
  final int? duration;
  const BackgroundWidget(
      {key,
      required this.child,
      this.color1,
      this.color2,
      this.color3,
      this.color4,
      this.color5,
      this.duration});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration ?? 6000));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();

    super.dispose();
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundPainter(
                      _animation,
                      widget.color1,
                      widget.color2,
                      widget.color3,
                      widget.color4,
                      widget.color5),
                  child: Container(),
                );
              }),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              )),
          widget.child,
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;
  final Color? color5;

  BackgroundPainter(
    this.animation,
    this.color1,
    this.color2,
    this.color3,
    this.color4,
    this.color5,
  );
  Offset getOffset(Path path) {
    final pms = path.computeMetrics(forceClosed: false).elementAt(0);
    final length = pms.length;
    final offset = pms.getTangentForOffset(length * animation.value)!.position;
    return offset;
  }

  // Offset getOffset(Path path) {
  //   final pms = path.computeMetrics(forceClosed: false).elementAt(0);
  //   final length = pms.length;
  //   final offset = pms.getTangentForOffset(length * animation.value)!.position;
  //   return offset;
  // }

  void drawSquare(Canvas canvas, Size size) {
    final paint1 = Paint();
    paint1.color = color1 ?? Colors.blue.shade300;
    paint1.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    paint1.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width * 0.75, 100),
            width: 300,
            height: 300,
          ),
          const Radius.circular(20),
        ),
        paint1);
  }

  void drawEllipse(Canvas canvas, Size size, Paint paint) {
    final path = Path();
    paint.color = color2 ?? mainColor;
    paint.style = PaintingStyle.stroke;
    path.moveTo(size.width * 0.4, -100);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.6,
        size.width * 1.2, size.height * 0.4);
    // canvas.drawPath(path, paint);

    paint.style = PaintingStyle.fill;
    canvas.drawOval(
        Rect.fromCenter(
          center: getOffset(path),
          width: 450,
          height: 250,
        ),
        paint);
  }

  void drawTriangle(Canvas canvas, Size size, paint) {
    paint.color = color3 ?? const Color.fromARGB(255, 54, 33, 243);
    final path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(-100.0, size.height * 0.5);
    path.quadraticBezierTo(
        300, size.height * 0.7, size.width, size.height * 1.2);
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;

    // draw triangle
    final offset = getOffset(path);
    canvas.drawPath(
        Path()
          ..moveTo(offset.dx, offset.dy)
          ..lineTo(offset.dx + 450, offset.dy + 150)
          ..lineTo(offset.dx + 250, offset.dy - 500)
          ..close(),
        paint);
  }

  void drawCircle(Canvas canvas, Size size, Paint paint) {
    paint.color = color4 ?? const Color.fromARGB(255, 106, 163, 248);
    Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;
    path.moveTo(size.width * 1.1, size.height / 4);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.0, -100, size.height / 4);
    // canvas.drawPath((path), paint);
    paint.style = PaintingStyle.fill;
    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }

  void drawAbstractShapes(Canvas canvas, Size size) {
    Path path = Path();
    final paint = Paint();
    path.moveTo(size.width * 1.2, 0);
    path.quadraticBezierTo(
        size.width * 1.2, 300, size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.7, -100, size.height * 1.2);
    path.lineTo(-50, -50);
    path.close();
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawPath(
        path,
        paint
          ..color = color4 ?? const Color.fromARGB(255, 58, 125, 224)
          ..style = PaintingStyle.fill);
    drawSquare(canvas, size);
  }

  void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    paint.blendMode = BlendMode.overlay;
    drawCircle(canvas, size, paint);
    //drawTriangle(canvas, size, paint);
    drawEllipse(canvas, size, paint);
  }

  void paintBackground(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5),
          width: size.width,
          height: size.height,
        ),
        Paint()..color = color5 ?? const Color.fromARGB(255, 6, 7, 73));
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBackground(canvas, size);
    drawAbstractShapes(canvas, size);
    final paint = Paint();
    drawContrastingBlobs(canvas, size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
