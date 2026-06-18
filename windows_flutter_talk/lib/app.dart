import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windows_flutter_talk/slides/slides.dart';
import 'package:windows_flutter_talk/theme/app_colors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child) => FlutterDeckApp(
        slides: slides,
        lightTheme: FlutterDeckThemeData(
          brightness: Brightness.light,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.deckBackground,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blue,
              brightness: Brightness.light,
              surface: AppColors.deckBackground,
              onSurface: AppColors.deckText,
            ),
          ),
          textTheme: const FlutterDeckTextTheme().apply(
            color: AppColors.deckText,
          ),
        ),
        darkTheme: FlutterDeckThemeData(
          brightness: Brightness.dark,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.deckBackground,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blue,
              brightness: Brightness.dark,
              surface: AppColors.deckBackground,
              onSurface: AppColors.deckText,
            ),
          ),
          textTheme: const FlutterDeckTextTheme().apply(
            color: AppColors.deckText,
          ),
        ),
        configuration: FlutterDeckConfiguration(
          background: const FlutterDeckBackgroundConfiguration(
            light: FlutterDeckBackground.solid(AppColors.deckBackground),
            dark: FlutterDeckBackground.solid(AppColors.deckBackground),
          ),
          controls: const FlutterDeckControlsConfiguration(
            presenterToolbarVisible: true,
            gestures: FlutterDeckGesturesConfiguration.mobileOnly(),
            shortcuts: FlutterDeckShortcutsConfiguration(
              enabled: true,
              nextSlide: {SingleActivator(LogicalKeyboardKey.arrowRight)},
              previousSlide: {SingleActivator(LogicalKeyboardKey.arrowLeft)},
              toggleMarker: {SingleActivator(
                LogicalKeyboardKey.keyM,
                control: true,
                meta: true,
              )},
              toggleNavigationDrawer: {SingleActivator(
                LogicalKeyboardKey.period,
                control: true,
                meta: true,
              )},
            ),
          ),
          transition: const FlutterDeckTransition.fade(),
          footer: const FlutterDeckFooterConfiguration(
            showSlideNumbers: true,
            widget: _AnimatedFooterWidget(),
          ),
        ),
      ),
    );
  }
}

class _AnimatedFooterWidget extends StatefulWidget {
  const _AnimatedFooterWidget();

  @override
  State<_AnimatedFooterWidget> createState() => _AnimatedFooterWidgetState();
}

class _AnimatedFooterWidgetState extends State<_AnimatedFooterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isMovingRight = false;
  int _imageIndex = 0;
  bool _animationStarted = false;

  static const _idleImagePath = 'assets/images/player-idle.png';

  final List<String> _imagePaths = [
    'assets/images/player-walk-left.gif',
    'assets/images/player-walk-right.gif',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 20),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.addListener(() {
      final previousDirection = _isMovingRight;
      _isMovingRight = _animation.value >= 0.5;

      if (previousDirection != _isMovingRight && mounted) {
        setState(() {
          _imageIndex = (_imageIndex + 1) % _imagePaths.length;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_animationStarted && mounted) {
      final slideIndex = context.flutterDeck.router.currentSlideIndex;
      if (slideIndex >= 1) {
        _animationStarted = true;
        _controller.repeat();
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 50.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final footerTop = screenHeight * 0.89;
    const logoWidth = 100.0;
    const logoPosition = logoWidth;
    const rightMargin = 100.0;
    final rightEndPosition = screenWidth - rightMargin;

    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_512x512.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double position;
                if (_animationStarted) {
                  if (_animation.value <= 0.5) {
                    final progress = _animation.value * 2.0;
                    position =
                        rightEndPosition -
                        (rightEndPosition - logoPosition + imageSize) *
                            progress;
                  } else {
                    final progress = (_animation.value - 0.5) * 2.0;
                    position =
                        logoPosition -
                        imageSize +
                        (rightEndPosition - logoPosition + imageSize) *
                            progress;
                  }
                } else {
                  position = rightEndPosition;
                }

                final imagePath =
                    _animationStarted ? _imagePaths[_imageIndex] : _idleImagePath;

                return Positioned(
                  left: position,
                  top: footerTop - (screenHeight * 0.9),
                  child: Image.asset(
                    imagePath,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: imageSize,
                        height: imageSize,
                        child: Container(
                          color: Colors.grey.withValues(alpha: 0.3),
                          child: const Icon(Icons.image, size: 20),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
