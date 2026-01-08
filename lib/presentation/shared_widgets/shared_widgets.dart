/// Barrel export for all shared widgets.
///
/// Import this file to access all shared widget components:
/// ```dart
/// import 'package:flutter_mvvm_boilerplate/presentation/shared_widgets/shared_widgets.dart';
/// ```
library;

// Buttons
export 'buttons/app_button.dart';
// Cards
export 'cards/app_card.dart';
export 'dialogs/app_bottom_sheet.dart';
// Dialogs
export 'dialogs/app_dialog.dart';
export 'feedback/app_empty_state.dart';
export 'feedback/app_error_widget.dart';
export 'feedback/app_refreshable.dart' hide AppEmptyState;
export 'feedback/app_status_handler.dart';
// Feedback
export 'feedback/app_toast.dart';
export 'inputs/app_dropdown.dart';
// Inputs
export 'inputs/app_input.dart';
export 'loaders/app_loading.dart';
// Loaders
export 'loaders/app_shimmer.dart';
// Misc
export 'misc/app_avatar.dart';
export 'misc/app_badge.dart';
export 'misc/app_image.dart' hide AppAvatar;
