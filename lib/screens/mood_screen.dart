import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/app_service.dart';
import '../theme/app_theme.dart';
import '../widgets/mood_wheel.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  double _angle = AppNumbers.moodInitialAngle;

  @override
  Widget build(BuildContext context) {
    final mood = MoodService.atAngle(_angle);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          // Radial gradient behind the top content
          Positioned(
            top: -MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.6,
                  colors: [
                    Color(0xFF17304C),
                    Color(0xFF071F2B),
                    Color(0xFF000000),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Text(
                    AppStrings.mood,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 17),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 8, 24, 0),
                  child: Text(
                    AppStrings.moodSubtitle,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 6, 24, 0),
                  child: Text(
                    'How are you feeling at the\nMoment?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: MoodWheel(
                      initialAngle: _angle,
                      size: AppNumbers.moodWheelSize,
                      onAngleChange: (a) => setState(() => _angle = a),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        mood.name,
                        key: ValueKey(mood.name),
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.white,
                        foregroundColor: AppTheme.bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppStrings.continueBtn,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: AppTheme.bg),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
