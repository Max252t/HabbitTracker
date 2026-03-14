part of 'habits_bloc.dart';

sealed class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object?> get props => [];
}

final class HabitsStarted extends HabitsEvent {
  const HabitsStarted();
}

final class HabitUpserted extends HabitsEvent {
  final HabitReminder reminder;

  const HabitUpserted(this.reminder);

  @override
  List<Object?> get props => [reminder];
}

final class HabitDeleted extends HabitsEvent {
  final String id;

  const HabitDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

