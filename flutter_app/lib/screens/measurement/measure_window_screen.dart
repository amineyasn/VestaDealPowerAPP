// ignore_for_file: deprecated_member_use

import 'dart:math' show pi;
import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class MeasureWindowScreen extends StatefulWidget {
  const MeasureWindowScreen({super.key});

  @override
  State<MeasureWindowScreen> createState() => _MeasureWindowScreenState();
}

class _MeasureWindowScreenState extends State<MeasureWindowScreen> {
  int _widthIn = 36;
  String _widthFrac = '3/4';
  int _heightIn = 48;
  String _heightFrac = '1/2';
  String _wallThickness = '3 1/2"';
  bool _leadDone = false;
  String _leadResult = 'Negative';

  static const List<String> _fractions = [
    '0', '1/8', '1/4', '3/8', '1/2', '5/8', '3/4', '7/8'
  ];
  static const List<String> _wallOptions = [
    '3 1/2"', '4 1/2"', '5 1/2"', '6"', '8"'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Measure Window', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/windows'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Window preview
                  CustomPaint(
                    size: const Size(200, 240),
                    painter: _WindowPainter(
                      widthLabel:
                          '$_widthIn${_widthFrac == '0' ? '"' : ' $_widthFrac"'}',
                      heightLabel:
                          '$_heightIn${_heightFrac == '0' ? '"' : ' $_heightFrac"'}',
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Width picker
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Width',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: _widthIn,
                          decoration:
                              const InputDecoration(labelText: 'Inches'),
                          items: List.generate(
                              120,
                              (i) => DropdownMenuItem(
                                  value: i + 1,
                                  child: Text('${i + 1}"'))),
                          onChanged: (v) =>
                              setState(() => _widthIn = v ?? _widthIn),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _widthFrac,
                          decoration:
                              const InputDecoration(labelText: 'Fraction'),
                          items: _fractions
                              .map((f) => DropdownMenuItem(
                                  value: f,
                                  child: Text(f == '0' ? '—' : f)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _widthFrac = v ?? _widthFrac),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Height picker
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Height',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: _heightIn,
                          decoration:
                              const InputDecoration(labelText: 'Inches'),
                          items: List.generate(
                              120,
                              (i) => DropdownMenuItem(
                                  value: i + 1,
                                  child: Text('${i + 1}"'))),
                          onChanged: (v) =>
                              setState(() => _heightIn = v ?? _heightIn),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _heightFrac,
                          decoration:
                              const InputDecoration(labelText: 'Fraction'),
                          items: _fractions
                              .map((f) => DropdownMenuItem(
                                  value: f,
                                  child: Text(f == '0' ? '—' : f)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _heightFrac = v ?? _heightFrac),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Wall thickness
                  DropdownButtonFormField<String>(
                    initialValue: _wallThickness,
                    decoration:
                        const InputDecoration(labelText: 'Wall Thickness'),
                    items: _wallOptions
                        .map((w) =>
                            DropdownMenuItem(value: w, child: Text(w)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _wallThickness = v ?? _wallThickness),
                  ),
                  const SizedBox(height: 16),
                  // Lead test
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Lead Test Performed',
                                  style: TextStyle(fontSize: 14)),
                              Switch(
                                value: _leadDone,
                                onChanged: (v) =>
                                    setState(() => _leadDone = v),
                              ),
                            ],
                          ),
                          if (_leadDone) ...[
                            RadioListTile<String>(
                              title: const Text('Negative'),
                              value: 'Negative',
                              // ignore: duplicate_ignore
                              // ignore: deprecated_member_use
                              groupValue: _leadResult,
                              onChanged: (v) =>
                                  setState(() => _leadResult = v!),
                            ),
                            RadioListTile<String>(
                              title: const Text('Positive'),
                              value: 'Positive',
                              groupValue: _leadResult,
                              onChanged: (v) =>
                                  setState(() => _leadResult = v!),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: VestaColors.green,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/options'),
                      child: const Text('Save Measurement',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowPainter extends CustomPainter {
  final String widthLabel;
  final String heightLabel;

  _WindowPainter({required this.widthLabel, required this.heightLabel});

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = VestaColors.blueDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final crossPaint = Paint()
      ..color = VestaColors.blueDark.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Window border
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);

    // Crosshair
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height), crossPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), crossPaint);

    // Labels
    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(
        text: widthLabel,
        style: const TextStyle(
            color: VestaColors.blueDark,
            fontSize: 12,
            fontWeight: FontWeight.w600));
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height + 4));

    tp.text = TextSpan(
        text: heightLabel,
        style: const TextStyle(
            color: VestaColors.blueDark,
            fontSize: 12,
            fontWeight: FontWeight.w600));
    tp.layout();
    canvas.save();
    canvas.translate(-4, size.height / 2 + tp.width / 2);
    canvas.rotate(-pi / 2); // rotate 90° counter-clockwise for vertical label
    tp.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_WindowPainter old) =>
      old.widthLabel != widthLabel || old.heightLabel != heightLabel;
}
