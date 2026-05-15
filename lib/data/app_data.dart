import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class WeekDay {
  final String short;
  final int date;
  final bool isToday;
  final Color? dotColor;

  const WeekDay({
    required this.short,
    required this.date,
    this.isToday = false,
    this.dotColor,
  });
}

class WorkoutSession {
  final String name;
  final String type;
  final String duration;
  final Color accentColor;
  final Color chipBg;

  const WorkoutSession({
    required this.name,
    required this.type,
    required this.duration,
    required this.accentColor,
    required this.chipBg,
  });
}

class TrainingDay {
  final String label;
  final int date;
  final WorkoutSession? workout;

  const TrainingDay({required this.label, required this.date, this.workout});
}

class TrainingWeek {
  final String weekLabel;
  final String dateRange;
  final int totalMinutes;
  final List<TrainingDay> days;

  const TrainingWeek({
    required this.weekLabel,
    required this.dateRange,
    required this.totalMinutes,
    required this.days,
  });
}

class MoodEntry {
  final String name;
  final String variant;

  const MoodEntry({required this.name, required this.variant});
}

const homeWeekDays = [
  WeekDay(short: 'M', date: 21),
  WeekDay(short: 'TU', date: 22, isToday: true, dotColor: Color(0xFF4DD9C0)),
  WeekDay(short: 'W', date: 23),
  WeekDay(short: 'TH', date: 24),
  WeekDay(short: 'F', date: 25),
  WeekDay(short: 'SA', date: 26),
  WeekDay(short: 'SU', date: 27),
];

const planWeekDays = [
  WeekDay(short: 'M', date: 22, dotColor: Color(0xFF4CAF76)),
  WeekDay(short: 'TU', date: 22, isToday: true),
  WeekDay(short: 'W', date: 22, dotColor: Color(0xFF444444)),
  WeekDay(short: 'TH', date: 22, dotColor: Color(0xFF6B82D4)),
  WeekDay(short: 'F', date: 22),
  WeekDay(short: 'SA', date: 22, dotColor: Color(0xFFFF7AAF)),
  WeekDay(short: 'SU', date: 22),
];

const todayWorkout = WorkoutSession(
  name: 'Upper Body',
  type: 'Upper Body',
  duration: '25m - 30m',
  accentColor: Color(0xFF4CAF76),
  chipBg: Color(0x294CAF76),
);

const trainingPlan = [
  TrainingWeek(
    weekLabel: 'Week 2/8',
    dateRange: 'December 8-14',
    totalMinutes: 60,
    days: [
      TrainingDay(
        label: 'Mon',
        date: 8,
        workout: WorkoutSession(
          name: 'Arm Blaster',
          type: 'Arms Workout',
          duration: '25m - 30m',
          accentColor: Color(0xFF4CAF76),
          chipBg: Color(0x294CAF76),
        ),
      ),
      TrainingDay(label: 'Tue', date: 9),
      TrainingDay(label: 'Wed', date: 10),
      TrainingDay(
        label: 'Thu',
        date: 11,
        workout: WorkoutSession(
          name: 'Leg Day Blitz',
          type: 'Leg Workout',
          duration: '25m - 30m',
          accentColor: Color(0xFF6B82D4),
          chipBg: Color(0x296B82D4),
        ),
      ),
      TrainingDay(label: 'Fri', date: 12),
      TrainingDay(label: 'Sat', date: 13),
      TrainingDay(label: 'Sun', date: 14),
    ],
  ),
  TrainingWeek(
    weekLabel: 'Week 2',
    dateRange: 'December 14-22',
    totalMinutes: 60,
    days: [
      TrainingDay(
        label: 'Mon',
        date: 15,
        workout: WorkoutSession(
          name: 'Chest Press',
          type: 'Upper Body',
          duration: '30m - 40m',
          accentColor: Color(0xFF4DD9C0),
          chipBg: Color(0x264DD9C0),
        ),
      ),
      TrainingDay(label: 'Tue', date: 16),
      TrainingDay(
        label: 'Wed',
        date: 17,
        workout: WorkoutSession(
          name: 'HIIT Cardio',
          type: 'Cardio',
          duration: '20m - 25m',
          accentColor: Color(0xFF6B82D4),
          chipBg: Color(0x296B82D4),
        ),
      ),
      TrainingDay(label: 'Thu', date: 18),
      TrainingDay(label: 'Fri', date: 19),
      TrainingDay(label: 'Sat', date: 20),
      TrainingDay(label: 'Sun', date: 21),
    ],
  ),
];

const moodList = [
  MoodEntry(name: 'Energetic', variant: 'energetic'),
  MoodEntry(name: 'Calm', variant: 'calm'),
  MoodEntry(name: 'Focused', variant: 'focused'),
  MoodEntry(name: 'Content', variant: 'content'),
  MoodEntry(name: 'Reflective', variant: 'reflective'),
  MoodEntry(name: 'Peaceful', variant: 'peaceful'),
  MoodEntry(name: 'Tender', variant: 'relaxed'),
  MoodEntry(name: 'Happy', variant: 'happy'),
];

MoodEntry getMoodAtAngle(double angle) {
  final idx = ((angle + 22.5) / 45).floor() % 8;
  return moodList[idx];
}

List<WeekDay> weekDaysFor(DateTime selected) {
  final monday = selected.subtract(Duration(days: selected.weekday - 1));
  return List.generate(7, (i) {
    final d = monday.add(Duration(days: i));
    final isSelected =
        d.year == selected.year &&
        d.month == selected.month &&
        d.day == selected.day;
    return WeekDay(
      short: AppCalendar.weekdaysShort[i],
      date: d.day,
      isToday: isSelected,
    );
  });
}
