# Vesta Measure — Flutter UI Preview

Runnable Flutter screens mirroring the Power Apps Vesta Measure app.

## Prerequisites

- Flutter SDK >=3.0.0

## How to Run

```bash
cd flutter_app
flutter pub get
flutter run -d chrome        # Web browser
flutter run -d windows       # Windows desktop
flutter run -d macos         # macOS desktop
flutter run -d linux         # Linux desktop
```

## Screen Inventory

| Route | Screen | File |
|---|---|---|
| `/` | Loading Screen | `lib/screens/launch/loading_screen.dart` |
| `/saving` | Saving Screen | `lib/screens/launch/saving_screen.dart` |
| `/load-job` | Load Job Screen | `lib/screens/launch/load_job_screen.dart` |
| `/incorrect` | Incorrect Version Screen | `lib/screens/launch/incorrect_version_screen.dart` |
| `/jobs` | Jobs Screen | `lib/screens/jobs/jobs_screen.dart` |
| `/job-details` | Job Details Screen | `lib/screens/jobs/job_details_screen.dart` |
| `/rooms` | Rooms Screen | `lib/screens/jobs/rooms_screen.dart` |
| `/windows` | Windows Screen | `lib/screens/measurement/windows_screen.dart` |
| `/measure-window` | Measure Window Screen | `lib/screens/measurement/measure_window_screen.dart` |
| `/options` | Options Screen | `lib/screens/measurement/options_screen.dart` |
| `/clone-window` | Clone Window Screen | `lib/screens/measurement/clone_window_screen.dart` |
| `/lead-test` | Lead Test Screen | `lib/screens/measurement/lead_test_screen.dart` |
| `/mull-windows` | Mull Windows Screen | `lib/screens/measurement/mull_windows_screen.dart` |
| `/delete-window` | Delete Window Screen | `lib/screens/measurement/delete_window_screen.dart` |
| `/labor` | Labor Screen | `lib/screens/items/labor_screen.dart` |
| `/add-labor` | Add Labor Items Screen | `lib/screens/items/add_labor_items_screen.dart` |
| `/materials` | Materials Screen | `lib/screens/items/materials_screen.dart` |
| `/add-materials` | Add Materials Screen | `lib/screens/items/add_materials_screen.dart` |
| `/documents` | Documents Screen | `lib/screens/documents/documents_screen.dart` |
| `/sign-document` | Sign Document Screen | `lib/screens/documents/sign_document_screen.dart` |
| `/photos` | Photos Screen | `lib/screens/photos/photos_screen.dart` |
| `/overview` | Overview Screen | `lib/screens/summary/overview_screen.dart` |
| `/final` | Final Steps Screen | `lib/screens/summary/final_steps_screen.dart` |
| `/admin` | Admin Screen | `lib/screens/summary/admin_screen.dart` |

## Notes

All data displayed in the screens is mock/hardcoded sample data for UI preview purposes. No real backend or Dataverse connection is included. The app is intended to give developers a visual reference matching the Power Apps design.
