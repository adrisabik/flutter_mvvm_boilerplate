# Flutter MVVM Boilerplate

A production-ready Flutter boilerplate implementing **Clean Architecture with MVVM** pattern and Feature-First organization.

---

## 🏗️ Architecture Overview

This boilerplate follows a **Hybrid Clean MVVM + Feature-First** architecture:

```
lib/
├── core/                       # Shared infrastructure
│   ├── config/                 # Environment & app configuration
│   ├── constants/              # App-wide constants (durations, keys, regex)
│   ├── di/                     # Dependency injection (GetIt + Injectable)
│   ├── error/                  # Failures, exceptions, error boundary
│   ├── extensions/             # Dart extensions (string, datetime, context)
│   ├── network/                # Dio client, interceptors, connectivity
│   │   └── interceptors/       # Auth, error interceptors
│   ├── observer/               # BLoC observer for debugging
│   ├── router/                 # GoRouter navigation with guards
│   ├── session/                # Global session management
│   ├── theme/                  # Theme & design tokens
│   └── utils/                  # Utility functions (validators, logger)
│
├── domain/                     # Business logic layer
│   ├── entities/               # Core business objects (Freezed)
│   ├── repositories/           # Abstract repository interfaces
│   └── usecases/               # Single-responsibility business operations
│       └── auth/               # Grouped by feature
│
├── data/                       # Data layer
│   ├── datasources/            # Data sources
│   │   ├── local/              # SecureStorage, Hive services
│   │   └── remote/             # API data sources
│   ├── models/                 # DTOs with JSON serialization
│   └── repositories/           # Repository implementations
│
└── presentation/               # UI layer
    ├── shared_widgets/         # Reusable UI components
    │   ├── buttons/            # AppButton
    │   ├── inputs/             # AppInput, AppDropdown
    │   ├── cards/              # AppCard
    │   ├── dialogs/            # AppDialog, AppBottomSheet
    │   ├── loaders/            # AppLoading, AppShimmer
    │   ├── feedback/           # AppEmptyState, AppErrorWidget, AppToast
    │   └── misc/               # AppAvatar, AppBadge
    ├── splash/                 # Splash screen feature
    ├── auth/                   # Authentication feature
    └── home/                   # Home feature
```

---

## 📦 Tech Stack

| Category | Package | Purpose |
|----------|---------|---------|
| **State Management** | `flutter_bloc` | BLoC/Cubit pattern |
| **Dependency Injection** | `get_it` + `injectable` | Service locator with code generation |
| **Navigation** | `go_router` | Declarative routing with auth guards |
| **Networking** | `dio` + `dio_smart_retry` | HTTP client with interceptors |
| **Connectivity** | `connectivity_plus` | Network status checking |
| **Error Handling** | `fpdart` | Functional Either type |
| **Data Models** | `freezed` + `json_serializable` | Immutable data classes |
| **Theming** | `flex_color_scheme` + `google_fonts` | Material 3 theme with Inter font |
| **Responsive** | `flutter_screenutil` + `gap` | Adaptive sizing & spacing |
| **Forms** | `flutter_form_builder` + `form_builder_validators` | Form handling & validation |
| **Animations** | `flutter_animate` + `lottie` | Declarative & rich animations |
| **Lists** | `infinite_scroll_pagination` | Paginated lists with states |
| **Images** | `cached_network_image` + `flutter_svg` | Image caching & SVG support |
| **Indicators** | `shimmer` + `smooth_page_indicator` | Loading & page indicators |
| **Local Storage** | `flutter_secure_storage` + `hive` | Secure & fast storage |
| **Linting** | `very_good_analysis` | Strict lint rules |
| **Testing** | `bloc_test` + `mocktail` | BLoC testing & mocking |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.10.4

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/flutter_mvvm_boilerplate.git

# Navigate to project
cd flutter_mvvm_boilerplate

# Install dependencies
flutter pub get

# Run code generation
# Unix/Mac
make gen

# Windows (PowerShell)
.\scripts\gen.ps1

# Run the app
flutter run
```

---

## 🛠️ Build Commands

### Unix/Mac (Makefile)

| Command | Description |
|---------|-------------|
| `make gen` | Generate code (freezed, json_serializable, injectable) |
| `make watch` | Watch mode for code generation |
| `make analyze` | Run static analysis |
| `make test` | Run all tests |
| `make format` | Format code |
| `make clean` | Clean build artifacts |

### Windows (PowerShell)

| Command | Description |
|---------|-------------|
| `.\scripts\gen.ps1` | Generate code |
| `.\scripts\watch.ps1` | Watch mode for code generation |
| `.\scripts\analyze.ps1` | Run analysis & format code |
| `.\scripts\test.ps1` | Run all tests |
| `.\scripts\test.ps1 -Coverage` | Run tests with coverage |
| `.\scripts\clean.ps1` | Clean and regenerate |
| `.\scripts\run.ps1 -Flavor dev` | Run with flavor (dev/staging/prod) |
| `.\scripts\build.ps1 -Flavor prod -Target apk` | Build APK/AppBundle |

---

## 🏭 Build Flavors

This boilerplate supports multiple environments using `--dart-define`:

### Running with Flavors

```bash
# Development
flutter run --dart-define=FLAVOR=dev

# Staging
flutter run --dart-define=FLAVOR=staging

# Production
flutter run --dart-define=FLAVOR=prod
```

### Building with Flavors

```bash
# Build APK
flutter build apk --release --dart-define=FLAVOR=prod

# Build App Bundle
flutter build appbundle --release --dart-define=FLAVOR=prod

# Build iOS
flutter build ios --release --dart-define=FLAVOR=prod
```

### Environment Configuration

```dart
// lib/core/config/env_config.dart

// Environments are auto-detected from --dart-define
// Or set manually:
EnvConfig.current = EnvConfig.staging;

// Access configuration
print(EnvConfig.current.baseUrl);     // API URL
print(EnvConfig.current.apiKey);      // API key
print(EnvConfig.current.appName);     // App name
print(EnvConfig.current.isDev);       // Is development?
print(EnvConfig.current.enableLogging); // Logging enabled?
```

---

## 🛡️ Error Handling

### Global Error Boundary

The app includes a global error boundary that:
- Catches Flutter framework errors
- Catches Dart errors and exceptions
- Shows a user-friendly error screen in release mode
- Logs errors appropriately

```dart
// Already configured in main.dart
void main() {
  ErrorBoundary.init();
  ErrorBoundary.runGuarded(() {
    runApp(const App());
  });
}
```

### Failure Types

Type-safe error handling with `fpdart`'s `Either` type:

```dart
// lib/core/error/failures.dart

abstract class Failure extends Equatable {
  final String message;
  final String? code;
}

// Available failure types:
class ServerFailure extends Failure      // API/network errors (with statusCode)
class CacheFailure extends Failure       // Local storage errors
class ValidationFailure extends Failure  // Input validation (with fieldErrors map)
class NetworkFailure extends Failure     // No internet connection
class AuthFailure extends Failure        // Authentication errors
class UnknownFailure extends Failure     // Unexpected errors

// Usage in Repository
Future<Either<Failure, User>> login(...) async {
  try {
    final response = await dioClient.post('/login', data: {...});
    return Right(UserModel.fromJson(response.data).toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  }
}
```

---

## 🔐 Session Management

Global session management using `SessionCubit`:

```dart
// Provided at app root in main.dart
BlocProvider(
  create: (_) => sl<SessionCubit>()..checkSession(),
  child: const App(),
)

// Check if authenticated
final isLoggedIn = context.read<SessionCubit>().state.isAuthenticated;

// Get current user
final user = context.read<SessionCubit>().state.user;

// Listen for session changes
BlocListener<SessionCubit, SessionState>(
  listenWhen: (prev, curr) => curr.hasExpired || !curr.isAuthenticated,
  listener: (context, state) => context.goNamed(RouteNames.login),
  child: ...
)

// Handle login success
context.read<SessionCubit>().onLoginSuccess(user);

// Logout
await context.read<SessionCubit>().logout();
```

---

## 📶 Connectivity Monitoring

Global connectivity monitoring using `ConnectivityCubit`:

```dart
// Provided at app root in main.dart
BlocProvider(
  create: (_) => sl<ConnectivityCubit>()..init(),
  child: const App(),
)

// Check connectivity
final isOnline = context.read<ConnectivityCubit>().state.isConnected;

// Show "No Internet" banner
BlocListener<ConnectivityCubit, ConnectivityState>(
  listenWhen: (prev, curr) => prev.isConnected != curr.isConnected,
  listener: (context, state) {
    if (!state.isConnected) {
      AppToast.error(context, 'No internet connection');
    } else {
      AppToast.success(context, 'Back online');
    }
  },
  child: ...
)
```

---

## 📊 Data Layer Pattern

### DTO with toEntity Pattern

```dart
// lib/data/models/user_model.dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Convert to domain entity
  User toEntity() => User(
    id: id,
    email: email,
    avatarUrl: avatarUrl,
  );

  // Create from domain entity
  static UserModel fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    avatarUrl: user.avatarUrl,
  );
}
```

---

## 🎯 Design Tokens

Consistent spacing, radius, and sizing with `flutter_screenutil`:

```dart
// lib/core/theme/app_spacing.dart

// Spacing (use with Gap widget)
abstract class AppSpacing {
  static double get xxs => 2.h;   // Micro spacing
  static double get xs  => 4.h;   // Icon margins
  static double get sm  => 8.h;   // Between related items
  static double get md  => 16.h;  // Standard sections
  static double get lg  => 24.h;  // Major sections
  static double get xl  => 32.h;  // Page padding
  static double get xxl => 48.h;  // Hero sections
}

// Border Radius
abstract class AppRadius {
  static double get xs   => 4.r;    // Tags, chips
  static double get sm   => 8.r;    // Buttons, inputs
  static double get md   => 12.r;   // Cards
  static double get lg   => 16.r;   // Bottom sheets
  static double get xl   => 24.r;   // Large cards
  static double get full => 999.r;  // Pills, avatars
}

// Icon Sizes
abstract class AppIconSize {
  static double get sm => 16.w;  // Small icons
  static double get md => 24.w;  // Default
  static double get lg => 32.w;  // Large
  static double get xl => 48.w;  // Extra large
}

// Usage
Gap(AppSpacing.md)
BorderRadius.circular(AppRadius.sm)
Icon(Icons.home, size: AppIconSize.md)
```

---

## 🎨 Shared Widgets

Dynamic, reusable components in `presentation/shared_widgets/`:

### AppButton
```dart
AppButton(
  text: 'Submit',
  type: AppButtonType.filled,    // filled, outlined, text, tonal
  size: AppButtonSize.medium,    // small, medium, large
  leadingIcon: Icons.check,
  isLoading: true,
  isFullWidth: true,
  onPressed: () {},
);
```

### AppInput
```dart
AppInput(
  label: 'Email',
  type: AppInputType.email,      // text, email, password, phone, number, search, multiline
  size: AppInputSize.medium,
  validator: Validators.email,
  controller: _emailController,
);
```

### AppCard
```dart
AppCard(
  type: AppCardType.elevated,    // elevated, filled, outlined
  onTap: () {},
  showChevron: true,
  child: Text('Card content'),
);
```

### AppDialog
```dart
// Alert
await AppDialog.showAlert(context, title: 'Success', message: 'Done!');

// Confirm
final confirmed = await AppDialog.showConfirm(
  context,
  title: 'Delete?',
  message: 'This action cannot be undone.',
);
```

### AppToast
```dart
AppToast.success(context, 'Item saved successfully');
AppToast.error(context, 'Something went wrong');
AppToast.warning(context, 'Low battery');
AppToast.info(context, 'New update available');
```

### AppStatusHandler
```dart
BlocBuilder<MyCubit, MyState>(
  builder: (context, state) {
    return AppStatusHandler<List<Item>>(
      status: state.status,
      data: state.items,
      failure: state.failure,
      onRetry: () => context.read<MyCubit>().fetch(),
      onSuccess: (items) => ListView.builder(...),
    );
  },
)
```

### Other Widgets
| Widget | Purpose |
|--------|---------|
| `AppAvatar` | User avatar with image/initials/fallback |
| `AppDropdown` | Generic dropdown selector |
| `AppBottomSheet` | Modal bottom sheet with height variants |
| `AppBadge` | Count/dot/label badges |
| `AppLoading` | Loading indicators (circular, linear, dots) |
| `AppShimmer` | Skeleton loading placeholders |
| `AppEmptyState` | Empty list state |
| `AppErrorWidget` | Error state with retry |
| `AppImage` | Unified image widget (network/asset/file/SVG) |
| `AppRefreshable` | Pull-to-refresh wrapper |
| `AppLoadingOverlay` | Full-screen loading overlay |

---

## 🔧 Core Utilities

### Logger
```dart
import 'package:flutter_mvvm_boilerplate/core/utils/utils.dart';

Log.d('Debug message');           // Debug (only in debug mode)
Log.i('Info message');            // Info
Log.w('Warning message');         // Warning
Log.e('Error', error: e, stackTrace: stack);  // Error (always logged)
```

### Debouncer & Throttler
```dart
// Debounce search input
final debouncer = Debouncer(milliseconds: 500);
onChanged: (value) => debouncer.run(() => search(value));

// Throttle scroll events
final throttler = Throttler(milliseconds: 100);
onScroll: () => throttler.run(() => updatePosition());

// Clean up
debouncer.dispose();
throttler.dispose();
```

### Clipboard, Share, URL Launcher
```dart
// Clipboard
await ClipboardUtils.copy('Text to copy');
final text = await ClipboardUtils.paste();

// Share
await ShareUtils.shareText('Check out this app!');
await ShareUtils.shareFile('/path/to/file.pdf');

// URL Launcher
await LaunchUtils.openUrl('https://example.com');
await LaunchUtils.openEmail(to: 'support@example.com');
await LaunchUtils.openPhone('+1234567890');
await LaunchUtils.openMaps(latitude: 37.7749, longitude: -122.4194);
```

---

## 📂 Adding a New Feature

### 1. Create Feature Structure
```bash
lib/presentation/products/
├── bloc/
│   ├── products_event.dart
│   ├── products_state.dart
│   └── products_bloc.dart
├── pages/
│   └── products_page.dart
└── widgets/
    └── product_card.dart
```

### 2. Define Domain Layer
```dart
// Entity
lib/domain/entities/product.dart

// Repository Interface
lib/domain/repositories/product_repository.dart

// Use Cases
lib/domain/usecases/products/get_products_usecase.dart
```

### 3. Implement Data Layer
```dart
// Model (DTO)
lib/data/models/product_model.dart

// Remote DataSource
lib/data/datasources/remote/product_remote_datasource.dart

// Repository Implementation
lib/data/repositories/product_repository_impl.dart
```

### 4. Add Route
```dart
// lib/core/router/app_router.dart
GoRoute(
  name: RouteNames.products,
  path: RoutePaths.products,
  builder: (context, state) => const ProductsPage(),
),
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/presentation/auth/bloc/auth_bloc_test.dart

# Windows PowerShell
.\scripts\test.ps1
.\scripts\test.ps1 -Coverage
.\scripts\test.ps1 -Path test/domain/usecases/
```

### Test Structure
```
test/
├── core/
│   └── utils/
│       ├── validators_test.dart
│       └── debouncer_test.dart
├── data/
│   └── repositories/
│       └── auth_repository_impl_test.dart
├── domain/
│   └── usecases/
│       └── login_usecase_test.dart
├── presentation/
│   └── auth/bloc/
│       └── auth_bloc_test.dart
└── helpers/
    ├── mocks.dart
    ├── fixtures.dart
    └── test_app.dart
```

---

## 🔧 Configuration

### Environment Setup
```dart
// Automatic from --dart-define
flutter run --dart-define=FLAVOR=prod

// Or manual in main.dart
EnvConfig.current = EnvConfig.prod;
```

### Theme Customization
```dart
// lib/core/theme/app_theme.dart
static ThemeData get light => FlexThemeData.light(
  scheme: FlexScheme.indigo,  // Change color scheme
  useMaterial3: true,
);
```

---

## 📁 Project Structure Summary

| Layer | Purpose | Key Patterns |
|-------|---------|--------------|
| **core/** | Shared infrastructure | DI, Error handling, Network, Theme |
| **domain/** | Business logic | Entities, Repository interfaces, UseCases |
| **data/** | Data access | DTOs (Models), DataSources, Repository impls |
| **presentation/** | UI | Pages, Widgets, BLoCs/Cubits |

---

## 📝 License

MIT License - feel free to use this boilerplate for your projects!

---

## 🤝 Contributing

Contributions are welcome! Please read the contributing guidelines first.
