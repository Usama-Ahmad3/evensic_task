import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;
int _monthOffset(int year, int month) => DateTime(year, month, 1).weekday - 1;

class CalendarStripController {
  _CalendarStripState? _state;

  void toggle() => _state?._toggle();
  void expand() => _state?._setExpanded(true);
  void collapse() => _state?._setExpanded(false);
}

class CalendarStrip extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final CalendarStripController? controller;

  const CalendarStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.controller,
  });

  @override
  State<CalendarStrip> createState() => _CalendarStripState();
}

class _CalendarStripState extends State<CalendarStrip>
    with SingleTickerProviderStateMixin {
  static const double _rowHeight = 60.0;
  static const double _monthHeaderHeight = 44.0;
  static const double _dowHeight = 28.0;
  static const double _handleHeight = 20.0;

  late final AnimationController _ctrl;
  late DateTime _focusedMonth;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;
    _focusedMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      1,
    );
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: 0.0,
    );
  }

  @override
  void didUpdateWidget(CalendarStrip old) {
    super.didUpdateWidget(old);
    widget.controller?._state = this;
    if (widget.selectedDate.year != old.selectedDate.year ||
        widget.selectedDate.month != old.selectedDate.month) {
      if (_ctrl.value < 0.5) {
        setState(() {
          _focusedMonth = DateTime(
            widget.selectedDate.year,
            widget.selectedDate.month,
            1,
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int _numRows() {
    final days = _daysInMonth(_focusedMonth.year, _focusedMonth.month);
    final offset = _monthOffset(_focusedMonth.year, _focusedMonth.month);
    return ((days + offset - 1) ~/ 7) + 1;
  }

  int _selectedRowIndex() {
    final sel = widget.selectedDate;
    if (sel.year != _focusedMonth.year || sel.month != _focusedMonth.month) {
      return 0;
    }
    final offset = _monthOffset(_focusedMonth.year, _focusedMonth.month);
    return (offset + sel.day - 1) ~/ 7;
  }

  void _toggle() {
    final target = _ctrl.value < 0.5 ? 1.0 : 0.0;
    _ctrl.animateTo(
      target,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _setExpanded(bool expanded) {
    _ctrl.animateTo(
      expanded ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (_ctrl.isAnimating) _ctrl.stop();
    final range = (_numRows() - 1) * _rowHeight;
    if (range <= 0) return;
    _ctrl.value = (_ctrl.value + d.delta.dy / range).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails d) {
    final vel = d.primaryVelocity ?? 0;
    final toMonth = vel > 300
        ? true
        : vel < -300
        ? false
        : _ctrl.value >= 0.5;
    _ctrl.animateTo(
      toMonth ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  void _prevMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = _ctrl.value;
        final numRows = _numRows();
        final selectedIdx = _selectedRowIndex();
        final monthGridH = numRows * _rowHeight;
        final visibleH = lerpDouble(_rowHeight, monthGridH.toDouble(), t)!;
        final translateY = selectedIdx * _rowHeight * (1.0 - t);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Month nav header — slides in from top as calendar expands
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: t,
                child: Opacity(
                  opacity: (t * 2.5).clamp(0.0, 1.0),
                  child: SizedBox(
                    height: _monthHeaderHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _NavBtn(icon: Icons.chevron_left, onTap: _prevMonth),
                        Text(
                          '${AppCalendar.monthsShort[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        _NavBtn(icon: Icons.chevron_right, onTap: _nextMonth),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // DOW header
            SizedBox(
              height: _dowHeight,
              child: Row(
                children: AppCalendar.weekdaysShort
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
            ),
            const SizedBox(height: 4),
            // Date rows — clipped and positioned for week/month transition
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              child: SizedBox(
                height: visibleH,
                child: ClipRect(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -translateY,
                        left: 0,
                        right: 0,
                        child: child!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Drag handle
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _toggle,
              child: SizedBox(
                height: _handleHeight,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppTheme.borderStrong,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: _buildMonthGrid(),
    );
  }

  Widget _buildMonthGrid() {
    final year = _focusedMonth.year;
    final month = _focusedMonth.month;
    final offset = _monthOffset(year, month);
    final days = _daysInMonth(year, month);
    final numRows = _numRows();

    return SizedBox(
      height: numRows * _rowHeight,
      child: Column(
        children: List.generate(numRows, (row) {
          return SizedBox(
            height: _rowHeight,
            child: Row(
              children: List.generate(7, (col) {
                final day = row * 7 + col - offset + 1;
                if (day < 1 || day > days) {
                  return const Expanded(child: SizedBox());
                }
                final date = DateTime(year, month, day);
                final isToday =
                    date.year == _today.year &&
                    date.month == _today.month &&
                    date.day == _today.day;
                final isSelected =
                    date.year == widget.selectedDate.year &&
                    date.month == widget.selectedDate.month &&
                    date.day == widget.selectedDate.day;
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => widget.onDateSelected(date),
                    child: _DayCell(
                      day: day,
                      isToday: isToday,
                      isSelected: isSelected,
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: AppTheme.white, size: 18),
    );
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
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
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
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
    );
  }
}
