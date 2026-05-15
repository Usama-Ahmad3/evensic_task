import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

int _firstWeekday(int year, int month) => DateTime(year, month, 1).weekday - 1;

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

class CalendarSheet extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarSheet({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarSheet> createState() => _CalendarSheetState();
}

class _CalendarSheetState extends State<CalendarSheet> {
  late DateTime _month;
  late DateTime _selected;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selected = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
    );
    _month = DateTime(_selected.year, _selected.month, 1);
  }

  bool _isToday(int year, int month, int day) =>
      year == _today.year && month == _today.month && day == _today.day;

  bool _isSelected(int year, int month, int day) =>
      year == _selected.year &&
      month == _selected.month &&
      day == _selected.day;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.85;
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.only(bottom: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.borderStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navBtn(Icons.chevron_left, () {
                    setState(
                      () => _month = DateTime(_month.year, _month.month - 1, 1),
                    );
                  }),
                  Text(
                    '${AppCalendar.monthsShort[_month.month - 1]} ${_month.year}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _navBtn(Icons.chevron_right, () {
                    setState(
                      () => _month = DateTime(_month.year, _month.month + 1, 1),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: AppCalendar.calendarDayHeaders
                    .map(
                      (d) => Expanded(
                        child: Text(
                          d,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              _buildGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: AppTheme.white, size: 18),
    );
  }

  Widget _buildGrid() {
    final year = _month.year;
    final month = _month.month;
    final firstDay = _firstWeekday(year, month);
    final daysCount = _daysInMonth(year, month);

    final cells = <Widget>[];

    for (int i = 0; i < firstDay; i++) {
      cells.add(const SizedBox());
    }

    for (int d = 1; d <= daysCount; d++) {
      final isToday = _isToday(year, month, d);
      final isSelected = _isSelected(year, month, d);
      cells.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final picked = DateTime(year, month, d);
            setState(() => _selected = picked);
            widget.onDateSelected(picked);
          },
          child: _DayCell(day: d, isToday: isToday, isSelected: isSelected),
        ),
      );
    }

    final rows = <Widget>[];
    for (int i = 0; i < cells.length; i += 7) {
      final end = (i + 7).clamp(0, cells.length);
      final rowCells = cells.sublist(i, end);
      while (rowCells.length < 7) {
        rowCells.add(const SizedBox());
      }
      rows.add(Row(children: rowCells.map((c) => Expanded(child: c)).toList()));
    }

    return Column(children: rows);
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isToday;
  final bool isSelected;

  const _DayCell({
    required this.day,
    this.isToday = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final highlighted = isToday || isSelected;

    return SizedBox(
      height: 52,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday
                  ? const Color(0xFF20B76F).withOpacity(0.15)
                  : AppTheme.surfaceAlt,
              border: highlighted
                  ? Border.all(color: const Color(0xFF20B76F), width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: highlighted ? FontWeight.w600 : FontWeight.w400,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday ? const Color(0xFF20B76F) : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
