part of 'habits_bloc.dart';

class HabitsState extends Equatable {
  final List<HabitReminder> items;

  const HabitsState({required this.items});

  HabitsState copyWith({List<HabitReminder>? items}) {
    return HabitsState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}

