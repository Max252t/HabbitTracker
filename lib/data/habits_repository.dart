import 'package:habbit_tracker/domain/habit_reminder.dart';

abstract class HabitsRepository {
  List<HabitReminder> getAll();
  void upsert(HabitReminder reminder);
  void deleteById(String id);
}

class InMemoryHabitsRepository implements HabitsRepository {
  final List<HabitReminder> _items = [];

  @override
  List<HabitReminder> getAll() => List.unmodifiable(_items);

  @override
  void upsert(HabitReminder reminder) {
    final idx = _items.indexWhere((e) => e.id == reminder.id);
    if (idx >= 0) {
      _items[idx] = reminder;
    } else {
      _items.add(reminder);
    }
  }

  @override
  void deleteById(String id) {
    _items.removeWhere((e) => e.id == id);
  }
}

