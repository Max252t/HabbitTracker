import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit_tracker/core/app_logger.dart';
import 'package:habbit_tracker/data/habits_repository.dart';
import 'package:habbit_tracker/domain/habit_reminder.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final HabitsRepository _repo;

  HabitsBloc({required HabitsRepository repo})
      : _repo = repo,
        super(const HabitsState(items: [])) {
    on<HabitsStarted>((event, emit) {
      appLogger.i('[HabitsBloc] HabitsStarted');
      emit(state.copyWith(items: _repo.getAll()));
    });

    on<HabitUpserted>((event, emit) {
      appLogger.i('[HabitsBloc] HabitUpserted id=${event.reminder.id} title=${event.reminder.title}');
      _repo.upsert(event.reminder);
      emit(state.copyWith(items: _repo.getAll()));
    });

    on<HabitDeleted>((event, emit) {
      appLogger.i('[HabitsBloc] HabitDeleted id=${event.id}');
      _repo.deleteById(event.id);
      emit(state.copyWith(items: _repo.getAll()));
    });
  }
}

