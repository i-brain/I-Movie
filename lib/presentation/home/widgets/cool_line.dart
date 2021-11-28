import 'package:flutter/material.dart';

class CoolLine extends StatefulWidget {
  const CoolLine({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoolLineState();
}

class _CoolLineState extends State<CoolLine>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  double _progress = 0.0;
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat(max: 1);
        }
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomPaint(painter: LinePainter(_progress));
  }

  @override
  bool get wantKeepAlive => true;
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  final double _progress;

  LinePainter(this._progress) {
    final opacity = _progress > 0.5 ? 1.0 : _progress * 1.5;

    _paint = Paint()
      ..color = Color.fromRGBO(
        255,
        255,
        255,
        opacity,
      )
      ..strokeWidth = 1.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(const Offset(0.0, 0.0),
        Offset(size.width - size.width * _progress, 0.0), _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
