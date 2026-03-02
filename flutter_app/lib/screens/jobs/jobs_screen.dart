import 'package:flutter/material.dart';
import '../../theme/vesta_theme.dart';

class _Job {
  final String id;
  final String customer;
  final String address;
  final String stage;
  final int windows;

  const _Job({
    required this.id,
    required this.customer,
    required this.address,
    required this.stage,
    required this.windows,
  });
}

const List<_Job> _mockJobs = [
  _Job(
      id: 'JOB-001',
      customer: 'Robert Thompson',
      address: '123 Oak St, Austin TX',
      stage: 'In Progress',
      windows: 12),
  _Job(
      id: 'JOB-002',
      customer: 'Michael Chen',
      address: '456 Maple Ave, Dallas TX',
      stage: 'Scheduled',
      windows: 8),
  _Job(
      id: 'JOB-003',
      customer: 'Sarah Mitchell',
      address: '789 Pine Rd, Houston TX',
      stage: 'Completed',
      windows: 6),
];

Color _stageColor(String stage) {
  switch (stage) {
    case 'In Progress':
      return VestaColors.statusInfo;
    case 'Completed':
      return VestaColors.green;
    default:
      return VestaColors.grayMediumDark;
  }
}

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String get _dateLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VestaColors.grayLight,
      appBar: VestaTitlebar(
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: Row(
        children: [
          const VestaSidebar(selectedRoute: '/jobs'),
          Expanded(
            child: Column(
              children: [
                // Date navigator
                Container(
                  height: 56,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () => setState(() => _selectedDate =
                            _selectedDate.subtract(const Duration(days: 1))),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: Center(
                            child: Text(_dateLabel,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => setState(() => _selectedDate =
                            _selectedDate.add(const Duration(days: 1))),
                      ),
                    ],
                  ),
                ),
                // Job list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _mockJobs.length,
                    itemBuilder: (context, index) {
                      final job = _mockJobs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: VestaColors.blueDark.withAlpha(15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.home,
                                color: VestaColors.blueDark, size: 28),
                          ),
                          title: Row(
                            children: [
                              Text(job.customer,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _stageColor(job.stage),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(job.stage,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11)),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(job.address,
                                  style: const TextStyle(fontSize: 13)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.window_outlined,
                                      size: 14,
                                      color: VestaColors.grayMediumDark),
                                  const SizedBox(width: 4),
                                  Text('${job.windows} windows',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: VestaColors.grayMediumDark)),
                                ],
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              Navigator.of(context).pushNamed('/job-details'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
