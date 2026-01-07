import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_mvvm_boilerplate/presentation/home/bloc/home_state.dart';

/// Home Cubit for managing home screen state.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  /// Load initial data
  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      // TODO: Fetch user data from repository
      emit(state.copyWith(isLoading: false, userName: 'Demo User'));
    } on Exception {
      emit(state.copyWith(isLoading: false, error: 'Failed to load data'));
    }
  }

  /// Refresh data
  Future<void> refresh() async {
    await loadData();
  }
}
