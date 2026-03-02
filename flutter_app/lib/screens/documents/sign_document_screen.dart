import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class SignDocumentScreen extends StatefulWidget {
  const SignDocumentScreen({super.key});

  @override
  State<SignDocumentScreen> createState() => _SignDocumentScreenState();
}

class _SignDocumentScreenState extends State<SignDocumentScreen> {
  final List<Offset?> _homeownerPath = [];
  final List<Offset?> _technicianPath = [];

  void _clearHomeowner() => setState(() => _homeownerPath.clear());
  void _clearTechnician() => setState(() => _technicianPath.clear());

  Widget _signatureCanvas({
    required List<Offset?> path,
    required Function(DragUpdateDetails) onUpdate,
    required Function(DragEndDetails) onEnd,
  }) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: VestaColors.grayMedium,
            width: 1,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GestureDetector(
        onPanUpdate: onUpdate,
        onPanEnd: onEnd,
        child: CustomPaint(
          painter: _SignaturePainter(path),
          size: const Size(300, 150),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(title: 'Sign Document', showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/documents'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Measurement Agreement',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  // Document content
                  const Card(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'This Measurement Agreement ("Agreement") is entered into by and between '
                        'Vesta Home Solutions ("Company") and the Homeowner identified above. '
                        'By signing below, the Homeowner acknowledges that the measurements '
                        'recorded are accurate and authorizes the Company to proceed with the '
                        'specified window replacement project.\n\n'
                        'The Company agrees to perform all work in accordance with applicable '
                        'building codes and manufacturer specifications. The Homeowner agrees '
                        'to provide access to the premises on the scheduled date and time.\n\n'
                        'Any changes to the scope of work must be agreed upon in writing by '
                        'both parties. This agreement constitutes the entire understanding '
                        'between the parties with respect to its subject matter.',
                        style: TextStyle(fontSize: 14, height: 1.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Homeowner signature
                  const Text('Homeowner Signature',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 8),
                  _signatureCanvas(
                    path: _homeownerPath,
                    onUpdate: (d) {
                      final box = context.findRenderObject() as RenderBox?;
                      if (box != null) {
                        setState(() => _homeownerPath.add(d.localPosition));
                      }
                    },
                    onEnd: (_) =>
                        setState(() => _homeownerPath.add(null)),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                    onPressed: _clearHomeowner,
                  ),
                  const SizedBox(height: 24),
                  // Technician signature
                  const Text('Technician Signature',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 8),
                  _signatureCanvas(
                    path: _technicianPath,
                    onUpdate: (d) {
                      setState(() => _technicianPath.add(d.localPosition));
                    },
                    onEnd: (_) =>
                        setState(() => _technicianPath.add(null)),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                    onPressed: _clearTechnician,
                  ),
                  const SizedBox(height: 24),
                  VestaAdvanceButton(
                    icon: Icons.save,
                    iconColor: VestaColors.green,
                    label: 'Save Signatures',
                    onPressed: () => Navigator.of(context).pop(),
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

class _SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  _SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter old) => old.points != points;
}
