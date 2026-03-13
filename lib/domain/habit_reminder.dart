import 'package:equatable/equatable.dart';

class HabitReminder extends Equatable {
  final String id;
  final String title;
  final DateTime? scheduledAt;
  final double? latitude;
  final double? longitude;
  final double radiusMeters;

  const HabitReminder({
    required this.id,
    required this.title,
    required this.radiusMeters,
    this.scheduledAt,
    this.latitude,
    this.longitude,
  });

  HabitReminder copyWith({
    String? id,
    String? title,
    DateTime? scheduledAt,
    double? latitude,
    double? longitude,
    double? radiusMeters,
  }) {
    return HabitReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        scheduledAt,
        latitude,
        longitude,
        radiusMeters,
      ];
}

