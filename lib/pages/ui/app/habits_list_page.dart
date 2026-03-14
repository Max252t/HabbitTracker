import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit_tracker/blocs/habits/habits_bloc.dart';
import 'package:habbit_tracker/pages/ui/app/habit_editor_page.dart';

class HabitsListPage extends StatelessWidget {
  const HabitsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Напоминалки',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8E97FD),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const HabitEditorPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF3F414E)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Нажми “+” чтобы создать напоминалку. Тап по элементу — редактирование.',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: const Color(0xFF3F414E)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final time = item.scheduledAt;
                  String two(int v) => v.toString().padLeft(2, '0');
                  final timeText = time == null
                      ? 'время не задано'
                      : '${two(time.day)}.${two(time.month)} ${two(time.hour)}:${two(time.minute)}';
                  final hasPoint = item.latitude != null && item.longitude != null;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Text(
                        item.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF3F414E),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      subtitle: Text(
                        'Когда: $timeText • Радиус: ${item.radiusMeters.toStringAsFixed(0)}м • Точка: ${hasPoint ? "выбрана" : "нет"}',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: const Color(0xFF3F414E)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: const Color(0xFF3F414E),
                        onPressed: () {
                          context.read<HabitsBloc>().add(HabitDeleted(item.id));
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HabitEditorPage(initial: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }
}
