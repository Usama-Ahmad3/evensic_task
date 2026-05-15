import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class WeekStrip extends StatelessWidget {
  final List<WeekDay> days;

  const WeekStrip({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: days.map((d) => Expanded(child: _DayCell(day: d))).toList(),
    );
  }
}

class _DayCell extends StatelessWidget {
  final WeekDay day;

  const _DayCell({required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day.short,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: day.isToday ? AppTheme.white : AppTheme.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: day.isToday
                ? Border.all(color: AppTheme.primary, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              '${day.date}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: day.isToday ? FontWeight.w600 : FontWeight.w400,
                color: day.isToday ? AppTheme.white : AppTheme.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: day.dotColor ?? Colors.transparent,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
