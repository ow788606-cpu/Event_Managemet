# Event App - Folder Structure

## lib/
```
lib/
├── main.dart                          # App entry point
├── config/                            # Configuration files
│   └── database_config.dart
├── models/                            # Data models
│   └── event_model.dart
├── services/                          # Business logic & services
│   └── database_service.dart
└── views/                             # UI Layer
    ├── navigation/                    # Navigation components
    │   └── main_navigation.dart
    ├── pages/                         # All app pages
    │   ├── auth/                      # Authentication pages
    │   │   ├── login_page.dart
    │   │   ├── signup_page.dart
    │   │   ├── welcome_page.dart
    │   │   └── change_password_page.dart
    │   ├── clients/                   # Client management
    │   │   ├── add_client_page.dart
    │   │   ├── all_clients_page.dart
    │   │   ├── client_details_page.dart
    │   │   └── edit_client_page.dart
    │   ├── employees/                 # Employee management
    │   │   ├── add_employee_page.dart
    │   │   ├── all_employees_page.dart
    │   │   ├── edit_employee_page.dart
    │   │   ├── employee_details_page.dart
    │   │   └── employee_screen.dart
    │   ├── events/                    # Event management
    │   │   ├── add_event_page.dart
    │   │   ├── add_function_page.dart
    │   │   ├── all_events_page.dart
    │   │   ├── completed_events_page.dart
    │   │   ├── edit_event_page.dart
    │   │   ├── edit_function_page.dart
    │   │   ├── event_details_page.dart
    │   │   ├── event_overview_page.dart
    │   │   ├── event_timeline_page.dart
    │   │   ├── events_page.dart
    │   │   └── upcoming_events_page.dart
    │   ├── guests/                    # Guest management
    │   │   ├── add_guest_page.dart
    │   │   ├── edit_guest_page.dart
    │   │   ├── guest_accommodation_page.dart
    │   │   └── guest_list_page.dart
    │   ├── vendors/                   # Vendor management
    │   │   ├── add_new_vendor_page.dart
    │   │   ├── add_vendor_page.dart
    │   │   ├── all_vendors_page.dart
    │   │   ├── edit_vendor_page.dart
    │   │   ├── vendor_details_page.dart
    │   │   └── vendors_page.dart
    │   ├── tags/                      # Tag management
    │   │   ├── tags_page.dart
    │   │   ├── tag_details_page.dart
    │   │   ├── add_tag_page.dart
    │   │   └── edit_tag_page.dart
    │   ├── tasks/                     # Task management
    │   │   ├── add_task_page.dart
    │   │   └── edit_task_page.dart
    │   ├── bookings/                  # Booking management
    │   │   ├── bookings_page.dart
    │   │   └── bookings_manager.dart
    │   ├── favorites/                 # Favorites
    │   │   ├── favorites_page.dart
    │   │   └── favorites_manager.dart
    │   ├── services/                  # Services
    │   │   ├── services_page.dart
    │   │   ├── services_page_temp.dart
    │   │   └── services_manager.dart
    │   ├── profile/                   # User profile
    │   │   └── manage_profile_page.dart
    │   ├── help/                      # Help & support
    │   │   └── help_desk_page.dart
    │   ├── home_page.dart             # Main home page
    │   └── checklist_design_page.dart # Checklist design
    └── widgets/                       # Reusable widgets
        └── common/                    # Common widgets
```

## Import Path Examples

### From main.dart:
```dart
import 'views/pages/auth/login_page.dart';
import 'views/navigation/main_navigation.dart';
```

### From views/navigation/main_navigation.dart:
```dart
import '../pages/home_page.dart';
import '../pages/favorites/favorites_page.dart';
import '../pages/services/services_page.dart';
```

### From views/pages/home_page.dart:
```dart
import 'events/events_page.dart';
import 'auth/login_page.dart';
import 'clients/add_client_page.dart';
import 'tags/tags_page.dart';
```

### From views/pages/guests/guest_list_page.dart:
```dart
import 'edit_guest_page.dart';  // Same folder
import 'add_guest_page.dart';   // Same folder
import '../../../services/database_service.dart';  // Go up 3 levels
```

### From views/pages/tags/tags_page.dart:
```dart
import 'add_tag_page.dart';  // Same folder
import '../../../services/database_service.dart';  // Go up 3 levels
```

## Folder Organization Rules

1. **config/** - App configuration (database, API endpoints, constants)
2. **models/** - Data models and entities
3. **services/** - Business logic, API calls, database operations
4. **views/navigation/** - Navigation and routing components
5. **views/pages/** - All UI pages organized by feature
6. **views/widgets/** - Reusable UI components

## Benefits of This Structure

- ✅ Clear separation of concerns
- ✅ Easy to locate files by feature
- ✅ Scalable for large projects
- ✅ Follows Flutter best practices
- ✅ Easier team collaboration
- ✅ Better code maintainability
