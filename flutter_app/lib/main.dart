import 'package:flutter/material.dart';
import 'theme/vesta_theme.dart';
import 'screens/launch/loading_screen.dart';
import 'screens/launch/saving_screen.dart';
import 'screens/launch/load_job_screen.dart';
import 'screens/launch/incorrect_version_screen.dart';
import 'screens/jobs/jobs_screen.dart';
import 'screens/jobs/job_details_screen.dart';
import 'screens/jobs/rooms_screen.dart';
import 'screens/measurement/windows_screen.dart';
import 'screens/measurement/measure_window_screen.dart';
import 'screens/measurement/options_screen.dart';
import 'screens/measurement/clone_window_screen.dart';
import 'screens/measurement/lead_test_screen.dart';
import 'screens/measurement/mull_windows_screen.dart';
import 'screens/measurement/delete_window_screen.dart';
import 'screens/items/labor_screen.dart';
import 'screens/items/add_labor_items_screen.dart';
import 'screens/items/materials_screen.dart';
import 'screens/items/add_materials_screen.dart';
import 'screens/documents/documents_screen.dart';
import 'screens/documents/sign_document_screen.dart';
import 'screens/photos/photos_screen.dart';
import 'screens/summary/overview_screen.dart';
import 'screens/summary/final_steps_screen.dart';
import 'screens/summary/admin_screen.dart';

void main() {
  runApp(const VestaMeasureApp());
}

class VestaMeasureApp extends StatelessWidget {
  const VestaMeasureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vesta Measure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: VestaColors.blueDark),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/saving': (context) => const SavingScreen(),
        '/load-job': (context) => const LoadJobScreen(),
        '/incorrect': (context) => const IncorrectVersionScreen(),
        '/jobs': (context) => const JobsScreen(),
        '/job-details': (context) => const JobDetailsScreen(),
        '/rooms': (context) => const RoomsScreen(),
        '/windows': (context) => const WindowsScreen(),
        '/measure-window': (context) => const MeasureWindowScreen(),
        '/options': (context) => const OptionsScreen(),
        '/clone-window': (context) => const CloneWindowScreen(),
        '/lead-test': (context) => const LeadTestScreen(),
        '/mull-windows': (context) => const MullWindowsScreen(),
        '/delete-window': (context) => const DeleteWindowScreen(),
        '/labor': (context) => const LaborScreen(),
        '/add-labor': (context) => const AddLaborItemsScreen(),
        '/materials': (context) => const MaterialsScreen(),
        '/add-materials': (context) => const AddMaterialsScreen(),
        '/documents': (context) => const DocumentsScreen(),
        '/sign-document': (context) => const SignDocumentScreen(),
        '/photos': (context) => const PhotosScreen(),
        '/overview': (context) => const OverviewScreen(),
        '/final': (context) => const FinalStepsScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}
