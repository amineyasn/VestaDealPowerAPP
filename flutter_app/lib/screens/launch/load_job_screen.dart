import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class LoadJobScreen extends StatefulWidget {
  const LoadJobScreen({super.key});

  @override
  State<LoadJobScreen> createState() => _LoadJobScreenState();
}

class _LoadJobScreenState extends State<LoadJobScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  int _step = 0;
  double _progress = 0.0;

  static const List<String> _steps = [
    'Downloading job...',
    'Loading CDS user profile...',
    'Fetching job rooms...',
    'Fetching window entries...',
    'Fetching measurements...',
    'Fetching labor items...',
    'Fetching material items...',
    'Fetching documents...',
    'Fetching photos...',
    'Job ready ✓',
  ];

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _runSteps();
  }

  Future<void> _runSteps() async {
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() {
        _step = i;
        _progress = (i + 1) / _steps.length;
      });
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/job-details');
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.whiteSmoke,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: _spinController,
                  child: Container(
                    width: 132,
                    height: 132,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: VestaColors.blueDark.withAlpha(20),
                    ),
                    child: const Icon(Icons.autorenew,
                        size: 80, color: VestaColors.blueDark),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('Vesta Measure', style: VestaText.appTitle),
                const SizedBox(height: 16),
                Text(
                  _step < _steps.length ? _steps[_step] : 'Job ready ✓',
                  style: VestaText.subtitle,
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VestaProgressBar(percent: _progress),
                const SizedBox(height: 8),
                const Text('Version 1.62', style: VestaText.version),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
