import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _Document {
  final String name;
  final String status;
  final String? dateSigned;

  const _Document(
      {required this.name,
      required this.status,
      this.dateSigned});
}

const List<_Document> _mockDocs = [
  _Document(
      name: 'Measurement Agreement',
      status: 'Signed',
      dateSigned: 'Mar 1, 2026'),
  _Document(name: 'Lead Test Disclosure', status: 'Pending'),
  _Document(name: 'Work Authorization', status: 'Pending'),
];

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: const VestaTitlebar(showBack: true),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/documents'),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _mockDocs.length,
              itemBuilder: (context, i) {
                final doc = _mockDocs[i];
                final signed = doc.status == 'Signed';
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: signed
                          ? VestaColors.green
                          : VestaColors.grayMediumDark,
                      size: 32,
                    ),
                    title: Text(doc.name,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: signed
                                ? VestaColors.green
                                : VestaColors.grayMedium,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            doc.status,
                            style: TextStyle(
                                color: signed
                                    ? Colors.white
                                    : VestaColors.grayMediumDark,
                                fontSize: 11),
                          ),
                        ),
                        if (doc.dateSigned != null) ...[
                          const SizedBox(height: 2),
                          Text('Signed: ${doc.dateSigned}',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: VestaColors.grayMediumDark)),
                        ],
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/sign-document'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
