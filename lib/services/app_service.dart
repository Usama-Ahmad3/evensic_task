import '../constants/app_constants.dart';
import '../data/app_data.dart';

class CalendarService {
  CalendarService._();

  static String formatTitle(DateTime date) {
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    if (isToday) {
      return '${AppStrings.today}, ${date.day} ${AppCalendar.monthsShort[date.month - 1]} ${date.year}';
    }
    return '${AppCalendar.weekdaysFull[date.weekday - 1]}, ${date.day} ${AppCalendar.monthsShort[date.month - 1]} ${date.year}';
  }

  static String weekLabel(DateTime date) {
    return 'Week ${weekOfMonth(date)}/${totalWeeksInMonth(date)}';
  }

  static int weekOfMonth(DateTime date) {
    final offset = DateTime(date.year, date.month, 1).weekday - 1;
    return ((date.day + offset - 1) ~/ 7) + 1;
  }

  static int totalWeeksInMonth(DateTime date) {
    final firstOfMonth = DateTime(date.year, date.month, 1);
    final daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final offset = firstOfMonth.weekday - 1;
    return ((daysInMonth + offset - 1) ~/ 7) + 1;
  }
}

class WeatherService {
  WeatherService._();

  static bool isDay() {
    final hour = DateTime.now().hour;
    return hour >= AppNumbers.dayStartHour && hour < AppNumbers.dayEndHour;
  }
}

class HydrationService {
  HydrationService._();

  static int addStep(int current) {
    return (current + AppNumbers.hydrationStepMl).clamp(0, AppNumbers.hydrationGoalMl);
  }

  static double progress(int current) {
    return current / AppNumbers.hydrationGoalMl;
  }

  static int progressPercent(int current) {
    return (progress(current) * 100).round();
  }
}

class MoodService {
  MoodService._();

  static MoodEntry atAngle(double angle) => getMoodAtAngle(angle);
}
