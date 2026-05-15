import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../data/app_data.dart';
import '../services/app_service.dart';
import '../theme/app_theme.dart';
import '../widgets/calendar_sheet.dart';
import '../widgets/calendar_strip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hydrationMl = 0;
  DateTime _selectedDate = DateTime.now();
  final _calendarController = CalendarStripController();

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CalendarSheet(
        initialDate: _selectedDate,
        onDateSelected: (date) {
          setState(() => _selectedDate = date);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _addHydration() {
    setState(
      () => _hydrationMl = (_hydrationMl + AppNumbers.hydrationStepMl).clamp(
        0,
        AppNumbers.hydrationGoalMl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekLabel = CalendarService.weekLabel(_selectedDate);
    final titleText = CalendarService.formatTitle(_selectedDate);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onOpenCalendar: _showCalendar, weekLabel: weekLabel),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              child: Text(
                titleText,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CalendarStrip(
                controller: _calendarController,
                selectedDate: _selectedDate,
                onDateSelected: (date) => setState(() => _selectedDate = date),
              ),
            ),
            const SizedBox(height: 7),
            _WorkoutsSection(selectedDate: _selectedDate),
            const SizedBox(height: 24),
            _InsightsSection(
              hydrationMl: _hydrationMl,
              onAddHydration: _addHydration,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onOpenCalendar;
  final String weekLabel;

  const _Header({required this.onOpenCalendar, required this.weekLabel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              AppAssets.notificationSvgIcon,
              height: 24,
              width: 24,
            ),
            GestureDetector(
              onTap: onOpenCalendar,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.weekSvgIcon,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      weekLabel,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 7),
                    SvgPicture.asset(AppAssets.downwardSvgIcon),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}

class _WorkoutsSection extends StatelessWidget {
  final DateTime selectedDate;

  const _WorkoutsSection({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final dateLabel =
        '${AppCalendar.monthsShort[selectedDate.month - 1]} ${selectedDate.day}';
    final dayMode = WeatherService.isDay();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.workouts,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    dayMode ? AppAssets.daySvgIcon : AppAssets.nightSvgIcon,
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppStrings.temperature,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          _WorkoutCard(session: todayWorkout, dateLabel: dateLabel),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final WorkoutSession session;
  final String dateLabel;

  const _WorkoutCard({required this.session, required this.dateLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: session.accentColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.only(
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
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$dateLabel · ${session.duration}',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    session.name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(AppAssets.arrowRightSvgIcon),
          ],
        ),
      ),
    );
  }
}

class _InsightsSection extends StatelessWidget {
  final int hydrationMl;
  final VoidCallback onAddHydration;

  const _InsightsSection({
    required this.hydrationMl,
    required this.onAddHydration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.myInsights,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 18),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _CaloriesCard()),
                const SizedBox(width: 12),
                Expanded(child: _WeightCard()),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _HydrationCard(currentMl: hydrationMl, onAdd: onAddHydration),
        ],
      ),
    );
  }
}

class _CaloriesCard extends StatelessWidget {
  const _CaloriesCard();

  @override
  Widget build(BuildContext context) {
    const consumed = AppNumbers.caloriesConsumed;
    const remaining = AppNumbers.caloriesRemaining;
    const goal = AppNumbers.calorieGoal;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '550',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' Calories',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$remaining ${AppStrings.remaining}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                '$goal',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                Container(height: 4, color: AppTheme.surfaceAlt),
                FractionallySizedBox(
                  widthFactor: (consumed / goal).clamp(0.0, 1.0),
                  child: Container(
                    height: 4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7BBDE2),
                          Color(0xFF69C0B1),
                          Color(0xFF60C198),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '75',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' kg',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppTheme.successDim,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.rotate(
                      angle: -0.8,
                      child: Center(
                        child: SvgPicture.asset(
                          colorFilter: ColorFilter.mode(
                            AppTheme.success,
                            BlendMode.srcIn,
                          ),
                          AppAssets.arrowRightSvgIcon,
                          width: 10,
                          height: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+1.6kg',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            AppStrings.weight,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _HydrationCard extends StatelessWidget {
  final int currentMl;
  final VoidCallback onAdd;

  const _HydrationCard({required this.currentMl, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final pctDisplay = HydrationService.progressPercent(currentMl);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '$pctDisplay%',
                          style: Theme.of(context).textTheme.displaySmall!
                              .copyWith(
                                fontSize: 38,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.blue,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          AppStrings.hydration,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppStrings.logNow,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _HydrationGauge(currentMl: currentMl)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: AppTheme.primaryDim,
              child: Text(
                AppStrings.addHydrationLog,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationGauge extends StatelessWidget {
  final int currentMl;

  const _HydrationGauge({required this.currentMl});

  @override
  Widget build(BuildContext context) {
    final pct = HydrationService.progress(currentMl).clamp(0.0, 1.0);

    return Row(
      children: [
        SizedBox(
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '2 L',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '0 L',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),

        ///The Scale Widget
        const SizedBox(width: 10),
        SizedBox(
          height: 110,
          child: Stack(
            children: [
              SizedBox(
                width: 6,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    CustomPaint(
                      size: const Size(6, 110),
                      painter: const _DottedTrackPainter(),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      width: 5,
                      height: 120 * pct,
                      decoration: BoxDecoration(
                        color: AppTheme.blue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 92,
                  color: AppTheme.surfaceAlt,
                  height: 1.5,
                  margin: EdgeInsets.only(bottom: 1.5, left: 1.5),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_tick(), _tick(), _tick()],
              ),
            ],
          ),
        ),
        Spacer(),
        SizedBox(
          height: 125,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '${currentMl}ml',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tick() {
    return Container(
      width: 11.5,
      height: 4.2,
      decoration: BoxDecoration(
        color: AppTheme.blue,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _DottedTrackPainter extends CustomPainter {
  const _DottedTrackPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.blue.withAlpha(20)
      ..style = PaintingStyle.fill;

    const double dotH = 3.0;
    const double gapH = 7.7;
    double y = 0;
    while (y + dotH <= size.height) {
      canvas.drawRRect(
        RRect.fromLTRBR(0, y, size.width, y + dotH, const Radius.circular(1.5)),
        paint,
      );
      y += dotH + gapH;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
