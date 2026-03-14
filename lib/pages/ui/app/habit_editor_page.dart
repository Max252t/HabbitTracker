import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit_tracker/blocs/habits/habits_bloc.dart';
import 'package:habbit_tracker/core/app_logger.dart';
import 'package:habbit_tracker/domain/habit_reminder.dart';

class HabitEditorPage extends StatefulWidget {
  final HabitReminder? initial;

  const HabitEditorPage({super.key, this.initial});

  @override
  State<HabitEditorPage> createState() => _HabitEditorPageState();
}

class _HabitEditorPageState extends State<HabitEditorPage> {
  late final TextEditingController _title;

  DateTime? _scheduledAt;
  double _radius = 150;

  @override
  void initState() {
    super.initState();
    appLogger.i('[HabitEditorPage] initState initial=${widget.initial?.id ?? "null"}');
    _title = TextEditingController(text: widget.initial?.title ?? '');
    _scheduledAt = widget.initial?.scheduledAt;
    _radius = widget.initial?.radiusMeters ?? 150;
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return 'Не выбрано';
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    appLogger.i('[HabitEditorPage] pickDateTime start now=$now scheduledAt=$_scheduledAt');
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt ?? now),
    );
    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _save() {
    final title = _title.text.trim();
    appLogger.i('[HabitEditorPage] save pressed title="$title" radius=$_radius scheduledAt=$_scheduledAt');
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите название')));
      return;
    }

    final existing = widget.initial;
    final id =
        existing?.id ??
        '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(9999)}';

    final reminder = HabitReminder(
      id: id,
      title: title,
      scheduledAt: _scheduledAt,
      latitude: widget.initial?.latitude,
      longitude: widget.initial?.longitude,
      radiusMeters: _radius,
    );

    context.read<HabitsBloc>().add(HabitUpserted(reminder));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Редактирование' : 'Создание')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backround_sign.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            children: [
              _Card(
                child: TextField(
                  controller: _title,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Название',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: Color(0xFF3F414E)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Дата/время: ${_formatDateTime(_scheduledAt)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF3F414E),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDateTime,
                      child: const Text('Выбрать'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Радиус: ${_radius.toStringAsFixed(0)} м',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF3F414E),
                      ),
                    ),
                    Slider(
                      value: _radius,
                      min: 50,
                      max: 1000,
                      divisions: 19,
                      onChanged: (v) => setState(() => _radius = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _Card(
                child: SizedBox(
                  height: 360,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.9),
                      child: Center(
                        child: Text(
                          'Карта временно отключена.\nВыбор точки недоступен.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: const Color(0xFF3F414E)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E97FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _save,
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
