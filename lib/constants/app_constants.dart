class AppStrings {
  AppStrings._();

  static const String appName = 'FitTrack';

  static const String home = 'Home';
  static const String plan = 'Plan';
  static const String mood = 'Mood';
  static const String profile = 'Profile';

  static const String workouts = 'Workouts';
  static const String myInsights = 'My Insights';
  static const String save = 'Save';

  static const String calories = 'Calories';
  static const String remaining = 'Remaining';
  static const String weight = 'Weight';
  static const String hydration = 'Hydration';
  static const String logNow = 'Log Now';
  static const String addHydrationLog = '+500 ml added to water log';

  static const String moodSubtitle = 'Start your day';
  static const String moodQuestion = 'How are you feeling at the\nMoment?';
  static const String continueBtn = 'Continue';

  static const String today = 'Today';
  static const String total = 'Total';
  static const String temperature = '9°';
}

class AppNumbers {
  AppNumbers._();

  static const int calorieGoal = 2500;
  static const int caloriesConsumed = 550;
  static const int caloriesRemaining = 1950;

  static const int hydrationGoalMl = 2000;
  static const int hydrationStepMl = 500;

  static const double weightKg = 75;
  static const String weightDelta = '+1.6kg';

  static const double moodWheelSize = 280;
  static const double moodInitialAngle = 45;

  static const int dayStartHour = 6;
  static const int dayEndHour = 18;
}

class AppCalendar {
  AppCalendar._();

  static const List<String> monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> weekdaysFull = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> weekdaysShort = [
    'M',
    'TU',
    'W',
    'TH',
    'F',
    'SA',
    'SU',
  ];

  static const List<String> calendarDayHeaders = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];
}
