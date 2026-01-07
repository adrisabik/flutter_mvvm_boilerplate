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
│   ├── error/                  # Failure classes & exceptions
│   ├── extensions/             # Dart extensions (string, datetime, context)
│   ├── network/                # Dio client & network utilities
│   │   └── interceptors/       # Auth, error interceptors
│   ├── observer/               # BLoC observer for debugging
│   ├── router/                 # GoRouter navigation with guards
│   ├── theme/                  # Theme & design tokens
│   └── utils/                  # Utility functions (validators)
│
├── domain/                     # Business logic layer
│   ├── entities/               # Core business objects (Freezed)
│   ├── repositories/           # Abstract repository interfaces
│   └── usecases/               # Single-responsibility business operations
│       └── auth/               # Grouped by feature
│
├── data/                       # Data layer
│   ├── datasources/            # Local storage sources
│   │   └── local/              # SecureStorage, Hive services
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
make gen

# Run the app
flutter run
```

---

## 🛠️ Build Commands

| Command | Description |
|---------|-------------|
| `make gen` | Generate code (freezed, json_serializable, injectable) |
| `make watch` | Watch mode for code generation |
| `make analyze` | Run static analysis |
| `make test` | Run all tests |
| `make format` | Format code |
| `make clean` | Clean build artifacts |

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

## 🛡️ Error Handling

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
  } on DioException catch (e) {
    return Left(ServerFailure(message: e.message ?? 'Server error'));
  }
}

// Usage in BLoC
final result = await loginUseCase(params);
result.fold(
  (failure) => emit(AuthState.error(failure.message)),
  (user) => emit(AuthState.authenticated(user)),
);
```

---

## 🔐 Example Feature: Authentication

Complete auth flow is implemented as a reference:

### Domain Layer
```dart
// Entity
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? name,
  }) = _User;
}

// Repository Interface
abstract class AuthRepository {
  Future<Either<Failure, User>> login({...});
  Future<Either<Failure, void>> logout();
}

// Use Case
class LoginUseCase extends UseCase<User, LoginParams> {
  @override
  Future<Either<Failure, User>> call(LoginParams params) {...}
}
```

### Data Layer
```dart
// Repository Implementation
class AuthRepositoryImpl implements AuthRepository {
  final DioClient _dioClient;
  final SecureStorageService _storageService;
  // Handles API calls, token storage, error mapping
}
```

### Presentation Layer
```dart
// BLoC with Freezed states
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  // Handles UI events, emits states
}
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

// Repository Implementation
lib/data/repositories/product_repository_impl.dart
```

### 4. Register Dependencies
```dart
// lib/core/di/injection.dart
void _registerRepositories() {
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl(), sl()),
  );
}

void _registerUseCases() {
  sl.registerFactory(() => GetProductsUseCase(sl()));
}
```

### 5. Add Route
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
```

### Test Structure
```
test/
├── presentation/
│   └── auth/bloc/
│       └── auth_bloc_test.dart
├── domain/usecases/
│   └── login_usecase_test.dart
└── data/repositories/
    └── auth_repository_impl_test.dart
```

---

## 🔧 Configuration

### Environment Setup
```dart
// lib/core/config/env_config.dart
void main() {
  EnvConfig.current = EnvConfig.dev;  // dev, staging, prod
  runApp(const App());
}
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

## 📝 License

MIT License - feel free to use this boilerplate for your projects!

---

## 🤝 Contributing

Contributions are welcome! Please read the contributing guidelines first.
