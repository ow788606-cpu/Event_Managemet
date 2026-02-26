# Import Fixes Required

## Files with import issues and their fixes:

### bookings/bookings_manager.dart
- Change: `import '../models/event_model.dart';`
- To: `import '../../../models/event_model.dart';`

### checklist_design_page.dart
- Change: `import 'add_task_page.dart';`
- To: `import 'tasks/add_task_page.dart';`
- Change: `import 'edit_task_page.dart';`
- To: `import 'tasks/edit_task_page.dart';`
- Change: `import 'services/database_service.dart';`
- To: `import '../../services/database_service.dart';`

### clients/add_client_page.dart & all_clients_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`

### employees/all_employees_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`

### events/all_events_page.dart, event_timeline_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`

### events/event_overview_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`
- Change: `import 'checklist_design_page.dart';`
- To: `import '../checklist_design_page.dart';`
- Change: `import 'vendors_page.dart';`
- To: `import '../vendors/vendors_page.dart';`
- Change: `import 'guest_list_page.dart';`
- To: `import '../guests/guest_list_page.dart';`

### events/events_page.dart
- Change: `import '../models/event_model.dart';`
- To: `import '../../../models/event_model.dart';`
- Change: `import 'favorites_manager.dart';`
- To: `import '../favorites/favorites_manager.dart';`
- Change: `import 'services_manager.dart';`
- To: `import '../services/services_manager.dart';`

### favorites/favorites_manager.dart & favorites_page.dart
- Change: `import '../models/event_model.dart';`
- To: `import '../../../models/event_model.dart';`

### guests/guest_accommodation_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`

### services/services_manager.dart
- Change: `import '../models/event_model.dart';`
- To: `import '../../../models/event_model.dart';`

### services/services_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`
- Change: `import 'checklist_design_page.dart';`
- To: `import '../checklist_design_page.dart';`
- Change: `import 'event_timeline_page.dart';`
- To: `import '../events/event_timeline_page.dart';`
- Change: `import 'vendors_page.dart';`
- To: `import '../vendors/vendors_page.dart';`
- Change: `import 'guest_list_page.dart';`
- To: `import '../guests/guest_list_page.dart';`
- Change: `import 'guest_accommodation_page.dart';`
- To: `import '../guests/guest_accommodation_page.dart';`

### vendors/all_vendors_page.dart & vendors_page.dart
- Change: `import 'services/database_service.dart';`
- To: `import '../../../services/database_service.dart';`
