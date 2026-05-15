import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/calendar_sheet.dart';

// Payload carried while a workout is being dragged
class _WorkoutDrag {
  final int weekIndex;
  final int dayIndex;
  final WorkoutSession workout;

  const _WorkoutDrag({
    required this.weekIndex,
    required this.dayIndex,
    required this.workout,
  });
}

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // Mutable workout grid mirroring trainingPlan[week][day]
  late List<List<WorkoutSession?>> _workouts;

  @override
  void initState() {
    super.initState();
    _workouts = trainingPlan
        .map((w) => w.days.map((d) => d.workout).toList())
        .toList();
  }

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CalendarSheet(
        initialDate: DateTime.now(),
        onDateSelected: (_) => Navigator.pop(context),
      ),
    );
  }

  void _moveWorkout(_WorkoutDrag drag, int toWeek, int toDay) {
    setState(() {
      _workouts[toWeek][toDay] = drag.workout;
      _workouts[drag.weekIndex][drag.dayIndex] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Column(
        children: [
          _PlanHeader(onOpenCalendar: _showCalendar),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(trainingPlan.length, (wIdx) {
                  return _WeekSection(
                    week: trainingPlan[wIdx],
                    weekIndex: wIdx,
                    workouts: _workouts[wIdx],
                    onDrop: _moveWorkout,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────

class _PlanHeader extends StatelessWidget {
  final VoidCallback onOpenCalendar;

  const _PlanHeader({required this.onOpenCalendar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.plan,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppStrings.save,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 2, color: const Color(0xFF4855DF)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Week section
// ─────────────────────────────────────────────

class _WeekSection extends StatelessWidget {
  final TrainingWeek week;
  final int weekIndex;
  final List<WorkoutSession?> workouts;
  final void Function(_WorkoutDrag, int, int) onDrop;

  const _WeekSection({
    required this.week,
    required this.weekIndex,
    required this.workouts,
    required this.onDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WeekSectionHeader(week: week),
        ...List.generate(week.days.length, (dIdx) {
          return _DayRow(
            day: week.days[dIdx],
            workout: workouts[dIdx],
            weekIndex: weekIndex,
            dayIndex: dIdx,
            onDrop: onDrop,
          );
        }),
        Container(height: 2, color: AppTheme.primary),
      ],
    );
  }
}

class _WeekSectionHeader extends StatelessWidget {
  final TrainingWeek week;

  const _WeekSectionHeader({required this.week});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surfaceAlt,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week.weekLabel,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Text(
                  week.dateRange,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: AppTheme.textSecondary),
                ),
              ],
            ),
            Text(
              '${AppStrings.total}: ${week.totalMinutes}min',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Day row — DragTarget
// ─────────────────────────────────────────────

class _DayRow extends StatelessWidget {
  final TrainingDay day;
  final WorkoutSession? workout;
  final int weekIndex;
  final int dayIndex;
  final void Function(_WorkoutDrag, int, int) onDrop;

  const _DayRow({
    required this.day,
    required this.workout,
    required this.weekIndex,
    required this.dayIndex,
    required this.onDrop,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    // Width available for the workout card feedback ghost
    final cardW = screenW - 88; // 20 padding + 40 label + 8 gap + 20 padding

    return DragTarget<_WorkoutDrag>(
      onWillAcceptWithDetails: (details) {
        final d = details.data;
        return !(d.weekIndex == weekIndex && d.dayIndex == dayIndex);
      },
      onAcceptWithDetails: (details) {
        onDrop(details.data, weekIndex, dayIndex);
      },
      builder: (context, candidateData, _) {
        final hovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          color: hovering
              ? AppTheme.primaryDim.withOpacity(0.35)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 80),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Day label + date
                      SizedBox(
                        width: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.label,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                color: workout != null
                                    ? AppTheme.white
                                    : AppTheme.textSecondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${day.date}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                color: workout != null
                                    ? AppTheme.white
                                    : AppTheme.textSecondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Workout card or drop hint
                      Expanded(
                        child: workout != null
                            ? LongPressDraggable<_WorkoutDrag>(
                                data: _WorkoutDrag(
                                  weekIndex: weekIndex,
                                  dayIndex: dayIndex,
                                  workout: workout!,
                                ),
                                delay: const Duration(milliseconds: 300),
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: SizedBox(
                                    width: cardW,
                                    child: Opacity(
                                      opacity: 0.92,
                                      child: _WorkoutCard(workout: workout!),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.25,
                                  child: _WorkoutCard(workout: workout!),
                                ),
                                child: _WorkoutCard(workout: workout!),
                              )
                            : hovering
                            ? _DropHint()
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: AppTheme.border,
                margin: const EdgeInsets.only(left: 8),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Drop hint shown on empty days while hovering
// ─────────────────────────────────────────────

class _DropHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primary.withOpacity(0.5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Drop here',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppTheme.primary.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Workout card (renamed from _WorkoutRow)
// ─────────────────────────────────────────────

class _WorkoutCard extends StatelessWidget {
  final WorkoutSession workout;

  const _WorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: workout.accentColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(4, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.drag_indicator_rounded,
              color: AppTheme.textMuted,
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: workout.chipBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          workout.type.contains('Leg') ||
                                  workout.type.contains('Cardio')
                              ? AppAssets.legWorkoutSvgIcon
                              : AppAssets.armWorkoutSvgIcon,
                          height: 10,
                          width: 10,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          workout.type,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: workout.accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        workout.duration,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
