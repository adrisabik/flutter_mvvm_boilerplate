import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global BLoC observer for logging state changes and errors.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    debugPrint('🟢 onCreate: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('🔄 onChange: ${bloc.runtimeType}');
    debugPrint('   Current: ${change.currentState}');
    debugPrint('   Next: ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('🔴 onError: ${bloc.runtimeType}');
    debugPrint('   Error: $error');
    debugPrint('   StackTrace: $stackTrace');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    debugPrint('⚪ onClose: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('📩 onEvent: ${bloc.runtimeType} -> $event');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint('➡️ onTransition: ${bloc.runtimeType}');
    debugPrint('   Event: ${transition.event}');
    debugPrint('   Current: ${transition.currentState}');
    debugPrint('   Next: ${transition.nextState}');
  }
}
