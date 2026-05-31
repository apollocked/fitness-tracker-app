# Fitness Tracker - MVVM Architecture Guide

## Architecture Overview

This project follows the **MVVM (Model-View-ViewModel)** architectural pattern for clean, maintainable, and testable code.

```
Model → ViewModel → View
  ↓        ↓        ↓
Data    Logic     UI
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/                      # Configuration
│   └── theme/
│       ├── app_colors.dart     # Color definitions
│       └── app_theme.dart      # Theme configuration
├── core/                        # Core utilities
│   └── base_viewmodel.dart     # Base ViewModel class
├── features/                    # Feature modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── presentation/
│   │   │   ├── auth_viewmodel.dart
│   │   │   ├── login_screen.dart
│   │   │   └── register_page.dart
│   │   └── services/
│   │       └── auth_service.dart
│   ├── calculators/
│   │   ├── presentation/
│   │   │   ├── calculators_viewmodel.dart
│   │   │   └── calculator_screens.dart
│   ├── profile/
│   │   ├── presentation/
│   │   │   ├── goals_viewmodel.dart
│   │   │   └── profile_screen.dart
│   ├── progress/
│   │   └── presentation/
│   │       ├── progress_viewmodel.dart
│   │       └── progress_screen.dart
│   ├── home/
│   │   └── presentation/
│   │       └── home_screen.dart
│   └── app/
│       └── presentation/
│           └── app_viewmodel.dart
├── shared/                      # Shared across features
│   ├── widgets/                # Reusable widgets
│   ├── services/               # Global services
│   │   ├── auth_service.dart
│   │   └── calculation_service.dart
│   └── utils/                  # Utilities
└── assets/                      # Images and resources
```

## Layer Descriptions

### 1. Model Layer
**Location**: `features/*/data/models/`
- Represents data structures (UserModel, MeasurementModel, etc.)
- Independent of UI and business logic
- Only concerned with data representation

**Example**:
```dart
class UserModel {
  final String id;
  final String email;
  final String name;
  // ...
}
```

### 2. ViewModel Layer
**Location**: `features/*/presentation/*_viewmodel.dart`
- Contains all business logic for a feature
- Extends `BaseViewModel` with ChangeNotifier
- Manages state using notifyListeners()
- No direct UI code

**Key ViewModels**:
- `AuthViewModel`: Authentication logic
- `AppViewModel`: Global app state (theme, navigation)
- `CalculatorsViewModel`: Calculation logic
- `GoalsViewModel`: Goals management
- `ProgressViewModel`: Measurements and progress tracking

**Example**:
```dart
class AuthViewModel extends BaseViewModel {
  UserModel? _currentUser;
  
  UserModel? get currentUser => _currentUser;
  
  Future<bool> login(String email, String password) async {
    return executeAsync(() async {
      // Login logic
      _currentUser = user;
      notifyListeners();
      return true;
    });
  }
}
```

### 3. View Layer
**Location**: `features/*/presentation/screens.dart` or `features/*/page.dart`
- Displays data from ViewModel
- Responds to user interactions
- Rebuilds when ViewModel notifies changes
- Uses `Consumer<ViewModel>` widgets

**Example**:
```dart
class LoginScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        return Scaffold(
          body: Column(
            children: [
              TextField(
                onChanged: (email) => authVM.setEmail(email),
              ),
              ElevatedButton(
                onPressed: () => authVM.login(),
                child: Text(authVM.isLoading ? 'Loading...' : 'Login'),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

### 4. Service Layer
**Location**: `shared/services/`
- Pure business logic and calculations
- No UI or data persistence directly
- Static methods for utility functions
- Examples: `AuthService`, `CalculationService`

**Example**:
```dart
class CalculationService {
  static double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }
}
```

## State Management

### Using Provider
```dart
// In main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthViewModel()),
    ChangeNotifierProvider(create: (_) => AppViewModel()),
  ],
  child: MaterialApp(
    home: Consumer<AuthViewModel>(
      builder: (context, authVM, _) {
        return authVM.isLoggedIn ? HomePage() : LoginPage();
      },
    ),
  ),
);
```

### Accessing ViewModel in Widgets
```dart
// Read-only (doesn't rebuild on changes)
final authVM = context.read<AuthViewModel>();

// Consumer (rebuilds on changes)
Consumer<AuthViewModel>(
  builder: (context, authVM, child) {
    return Text(authVM.isLoading ? 'Loading' : 'Ready');
  },
);

// Watch (automatically listens to changes)
context.watch<AuthViewModel>().isLoading;
```

## BaseViewModel

All ViewModels extend `BaseViewModel` which provides:
- Loading state management
- Error handling
- Async operation execution

```dart
class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<T> executeAsync<T>(Future<T> Function() operation) async {
    // Handles loading and error states
  }
}
```

## Benefits of This Architecture

✅ **Separation of Concerns**: UI, Business Logic, and Data are separate
✅ **Testability**: ViewModels can be tested independently
✅ **Reusability**: Services and ViewModels can be reused
✅ **Maintainability**: Clear structure and responsibilities
✅ **Scalability**: Easy to add new features
✅ **Performance**: Only necessary widgets rebuild
✅ **Simpler State Management**: Provider is simpler than BLoC

## Migration from BLoC to Provider

### Old (BLoC):
```dart
context.read<AuthCubit>().login(email, password);
```

### New (Provider):
```dart
context.read<AuthViewModel>().login(email, password);
```

## Dependencies Reduction

**Before**: 
- flutter_bloc
- multiple cubits (AuthCubit, ThemeCubit, etc.)
- Complex state management

**After**:
- provider (single, lightweight dependency)
- ViewModels (simpler, more flexible)
- Services (focused, reusable)

## Next Steps

1. Update all screens to use the new ViewModels
2. Replace remaining old cubits with ViewModels
3. Update imports to use new file locations
4. Test all features thoroughly
5. Remove old app/, cubits, repositories folders
