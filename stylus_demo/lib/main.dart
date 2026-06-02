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

class _StylusCanvasState extends State<StylusCanvas> {
  final List<List<StrokePoint>> _strokes = [];
  List<StrokePoint> _currentStroke = [];

  double _lastPressure = 0.0;
  double _lastOrientation = 0.0;
  double _lastTilt = 0.0;

  bool _showLinkButton = false;

  void _onPointerDown(PointerEvent event) {
    setState(() {
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
      if (_strokes.isNotEmpty) {
        _showLinkButton = true;
      }
    });
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
    setState(() {
      _strokes.clear();
      _currentStroke = [];
      _showLinkButton = false;
    });
  }

  Future<void> _openCommunityLink() async {
    // ★ここをコミュニティのURLに変えてください
    final uri = Uri.parse('https://your-community-url.example.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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
            child: Listener(
              onPointerDown: _onPointerDown,
              onPointerMove: _onPointerMove,
              onPointerUp: _onPointerUp,
              child: CustomPaint(
                size: Size.infinite,
                foregroundPainter: StrokePainter(
                  strokes: List.from(_strokes),
                  currentStroke: List.from(_currentStroke),
                ),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // コミュニティリンクボタン（1ストローク書いた後に表示）
          if (_showLinkButton)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: _openCommunityLink,
                icon: const Icon(Icons.open_in_new),
                label: const Text('コミュニティへGO！'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
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

  StrokePainter({required this.strokes, required this.currentStroke});

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

      // 筆圧に応じて太さを変える（1.0〜8.0px）
      final strokeWidth = p1.pressure > 0 ? 1.0 + p1.pressure * 7.0 : 4.0;

      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(p1.position, p2.position, paint);
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) => true;
}