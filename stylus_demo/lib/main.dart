import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylus Demo',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const StylusCanvas(),
    );
  }
}

class StrokePoint {
  final Offset position;
  final double pressure;
  final double orientation;
  final double tilt;

  const StrokePoint({
    required this.position,
    required this.pressure,
    required this.orientation,
    required this.tilt,
  });
}

class StylusCanvas extends StatefulWidget {
  const StylusCanvas({super.key});

  @override
  State<StylusCanvas> createState() => _StylusCanvasState();
}

class _StylusCanvasState extends State<StylusCanvas>
    with SingleTickerProviderStateMixin {
  final List<List<StrokePoint>> _strokes = [];
  List<StrokePoint> _currentStroke = [];

  double _lastPressure = 0.0;
  double _lastOrientation = 0.0;
  double _lastTilt = 0.0;

  Timer? _linkTimer;
  bool _isLinkMode = false;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addListener(() {
        setState(() {});
      });
    _glowAnimation = Tween<double>(begin: 4.0, end: 16.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _linkTimer?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerEvent event) {
    _linkTimer?.cancel();
    if (_isLinkMode) {
      _glowController.stop();
    }
    setState(() {
      _isLinkMode = false;
      _currentStroke = [_toStrokePoint(event)];
      _updateDebugInfo(event);
    });
  }

  void _onPointerMove(PointerEvent event) {
    setState(() {
      _currentStroke.add(_toStrokePoint(event));
      _updateDebugInfo(event);
    });
  }

  void _onPointerUp(PointerEvent event) {
    setState(() {
      if (_currentStroke.isNotEmpty) {
        _strokes.add(List.from(_currentStroke));
      }
      _currentStroke = [];
    });

    if (_strokes.isNotEmpty) {
      _linkTimer?.cancel();
      _linkTimer = Timer(const Duration(seconds: 5), () {
        setState(() {
          _isLinkMode = true;
        });
        _glowController.repeat(reverse: true);
      });
    }
  }

  StrokePoint _toStrokePoint(PointerEvent event) {
    return StrokePoint(
      position: event.localPosition,
      pressure: event.pressure,
      orientation: event.orientation,
      tilt: event.tilt,
    );
  }

  void _updateDebugInfo(PointerEvent event) {
    _lastPressure = event.pressure;
    _lastOrientation = event.orientation;
    _lastTilt = event.tilt;
  }

  void _clearCanvas() {
    _linkTimer?.cancel();
    _glowController.stop();
    setState(() {
      _strokes.clear();
      _currentStroke = [];
      _isLinkMode = false;
    });
  }

  Future<void> _openCommunityLink() async {
    final uri = Uri.parse('https://okayama-dot-flutter.connpass.com/event/393552/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    // リンクを開いた後、編集モードに戻る
    _glowController.stop();
    setState(() {
      _isLinkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 3.44 Stylus Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'クリア',
            onPressed: _clearCanvas,
          ),
        ],
      ),
      body: Column(
        children: [
          // デバッグ情報パネル
          Container(
            width: double.infinity,
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DebugLabel('筆圧', _lastPressure.toStringAsFixed(3)),
                _DebugLabel('向き', '${(_lastOrientation * 180 / 3.14159).toStringAsFixed(1)}°'),
                _DebugLabel('傾き', '${(_lastTilt * 180 / 3.14159).toStringAsFixed(1)}°'),
              ],
            ),
          ),
          // キャンバス
          Expanded(
            child: MouseRegion(
              cursor: _isLinkMode
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: Listener(
                onPointerDown: _isLinkMode ? null : _onPointerDown,
                onPointerMove: _isLinkMode ? null : _onPointerMove,
                onPointerUp: _isLinkMode ? null : _onPointerUp,
                child: GestureDetector(
                  onTap: _isLinkMode ? _openCommunityLink : null,
                  child: CustomPaint(
                    size: Size.infinite,
                    foregroundPainter: StrokePainter(
                      strokes: List.from(_strokes),
                      currentStroke: List.from(_currentStroke),
                      isLinkMode: _isLinkMode,
                      glowRadius: _glowAnimation.value,
                    ),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DebugLabel extends StatelessWidget {
  final String label;
  final String value;

  const _DebugLabel(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class StrokePainter extends CustomPainter {
  final List<List<StrokePoint>> strokes;
  final List<StrokePoint> currentStroke;
  final bool isLinkMode;
  final double glowRadius;

  StrokePainter({
    required this.strokes,
    required this.currentStroke,
    required this.isLinkMode,
    required this.glowRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in [...strokes, currentStroke]) {
      _drawStroke(canvas, stroke);
    }
  }

  void _drawStroke(Canvas canvas, List<StrokePoint> stroke) {
    if (stroke.length < 2) return;

    for (int i = 0; i < stroke.length - 1; i++) {
      final p1 = stroke[i];
      final p2 = stroke[i + 1];

      final strokeWidth = p1.pressure > 0 ? 1.0 + p1.pressure * 7.0 : 4.0;

      if (isLinkMode) {
        // グロー層
        final glowPaint = Paint()
          ..color = Colors.cyanAccent.withOpacity(0.6)
          ..strokeWidth = strokeWidth + glowRadius
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowRadius);
        canvas.drawLine(p1.position, p2.position, glowPaint);

        // 線本体
        final linePaint = Paint()
          ..color = Colors.lightBlueAccent
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        canvas.drawLine(p1.position, p2.position, linePaint);
      } else {
        // 通常描画
        final paint = Paint()
          ..color = Colors.black
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        canvas.drawLine(p1.position, p2.position, paint);
      }
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) => true;
}