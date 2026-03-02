import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class SavingScreen extends StatefulWidget {
  const SavingScreen({super.key});

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  int _step = 0;
  bool _done = false;

  static const List<String> _steps = [
    'Saving job header...',
    'Saving rooms...',
    'Saving window entries...',
    'Saving measurements...',
    'Saving window options...',
    'Saving lead test results...',
    'Saving mull groups...',
    'Saving labor items...',
    'Saving material items...',
    'Saving material colors...',
    'Saving material species...',
    'Saving material grades...',
    'Saving photos...',
    'Saving photo metadata...',
    'Saving document signatures...',
    'Saving homeowner signature...',
    'Saving technician signature...',
    'Saving document status...',
    'Saving notes...',
    'Updating job status...',
    'Uploading to Dataverse...',
    'Verifying records...',
    'Clearing local AUD queue...',
    'Refreshing cache...',
    'Save complete ✓',
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
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      setState(() {
        _step = i;
      });
    }
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _done = true);
    _spinController.stop();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_step + 1) / _steps.length;
    return Scaffold(
      backgroundColor: VestaColors.whiteSmoke,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_done)
                  const Icon(Icons.check_circle,
                      size: 132, color: VestaColors.green)
                else
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
                  _step < _steps.length ? _steps[_step] : 'Save complete ✓',
                  style: VestaText.subtitle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Step ${_step + 1} of ${_steps.length}',
                  style: VestaText.version.copyWith(fontSize: 12),
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
                VestaProgressBar(percent: progress),
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
