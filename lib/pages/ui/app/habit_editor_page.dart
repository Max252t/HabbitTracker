import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:habbit_tracker/blocs/habits/habits_bloc.dart';
import 'package:habbit_tracker/core/app_logger.dart';
import 'package:habbit_tracker/domain/habit_reminder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
  Point? _location;
  YandexMapController? _mapController;

  @override
  void initState() {
    super.initState();
    appLogger.i('[HabitEditorPage] initState initial=${widget.initial?.id ?? "null"}');
    _title = TextEditingController(text: widget.initial?.title ?? '');
    _scheduledAt = widget.initial?.scheduledAt;
    _radius = widget.initial?.radiusMeters ?? 150;

    final lat = widget.initial?.latitude;
    final lon = widget.initial?.longitude;
    if (lat != null && lon != null) {
      _location = Point(latitude: lat, longitude: lon);
    }
  }

  List<MapObject> get _mapObjects {
    if (_location == null) return const [];

    return [
      PlacemarkMapObject(
        mapId: const MapObjectId('habit_point'),
        point: _location!,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/images/backround_sign.png'),
          ),
        ),
      ),
      CircleMapObject(
        mapId: const MapObjectId('habit_radius'),
        circle: Circle(
          center: _location!,
          radius: _radius,
        ),
        strokeColor: const Color(0xFF8E97FD).withOpacity(0.9),
        strokeWidth: 2,
        fillColor: const Color(0xFF8E97FD).withOpacity(0.2),
      ),
    ];
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
    final initial = _scheduledAt ?? now;

    appLogger
        .i('[HabitEditorPage] pickDateTime start now=$now scheduledAt=$_scheduledAt');

    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final isWide = media.size.width > 600;

    // Адаптивный выбор даты: на широких экранах – центрированный диалог,
    // на телефонах – аккуратный мобильный диалог без обрезания чисел.
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        // Отдельно уменьшаем масштаб текста только внутри диалога,
        // чтобы наш основной текст в приложении не менялся.
        final scaledMedia = media.copyWith(
          textScaler: const TextScaler.linear(0.7),
        );

        Widget picker = Theme(
          data: theme.copyWith(
            platform: TargetPlatform.android, // единый внешний вид
          ),
          child: MediaQuery(
            data: scaledMedia,
            child: child,
          ),
        );

        if (!isWide) {
          // Телефон/узкий экран
          return picker;
        }

        // Десктоп/широкий экран – плюс ограничиваем ширину и высоту.
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 500,
            ),
            child: picker,
          ),
        );
      },
    );
    if (date == null) return;

    // Адаптивный выбор времени с теми же принципами.
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        final scaledMedia = media.copyWith(
          textScaler: const TextScaler.linear(0.7),
        );

        Widget picker = Theme(
          data: theme.copyWith(
            platform: TargetPlatform.android,
          ),
          child: MediaQuery(
            data: scaledMedia,
            child: child,
          ),
        );

        if (!isWide) {
          return picker;
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: picker,
          ),
        );
      },
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
      latitude: _location?.latitude,
      longitude: _location?.longitude,
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
                    child: YandexMap(
                      onMapCreated: (controller) async {
                        _mapController = controller;
                        
                        Point target = const Point(
                          latitude: 55.751244,
                          longitude: 37.618423,
                        );

                        if (_location != null) {
                          target = _location!;
                        } else {
                          try {
                            LocationPermission permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied) {
                              permission = await Geolocator.requestPermission();
                            }
                            
                            if (permission == LocationPermission.whileInUse || 
                                permission == LocationPermission.always) {
                              final position = await Geolocator.getCurrentPosition();
                              target = Point(
                                latitude: position.latitude, 
                                longitude: position.longitude,
                              );
                            }
                          } catch (e) {
                            appLogger.e('Ошибка получения геолокации: $e');
                          }
                        }

                        await _mapController?.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: target, zoom: 14),
                          ),
                        );

                        await _mapController?.toggleUserLayer(visible: true);
                      },
                      mapObjects: _mapObjects,
                      onMapTap: (point) async {
                        setState(() {
                          _location = point;
                        });
                        await _mapController?.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: point, zoom: 15),
                          ),
                        );
                      },
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
