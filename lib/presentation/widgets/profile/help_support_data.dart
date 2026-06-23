import 'package:flutter/material.dart';

const List<Map<String, dynamic>> helpFaqs = [
  {
    'question': 'How do I update my weight?',
    'answer':
        'On the Home page, tap the "Update Weight" card. Enter your current weight and save. '
        'This automatically logs your measurement to the Progress page.',
  },
  {
    'question': 'How do calculators work?',
    'answer':
        'Navigate to any calculator from the Home dashboard or the bottom sheet. '
        'Your personal data is pre-filled from your profile. Adjust values and tap "Calculate" to see results. '
        'You can set the results as fitness goals.',
  },
  {
    'question': 'Can I edit my fitness goals?',
    'answer':
        'Go to Profile > My Goals. Tap the Edit button on any goal to modify its value. '
        'You can also delete goals you no longer need.',
  },
  {
    'question': 'How do I enable Dark Mode?',
    'answer':
        'Go to Profile > Settings. Under the Appearance section, toggle the Dark Mode switch. '
        'The change takes effect immediately.',
  },
  {
    'question': 'What calculators does the app have?',
    'answer':
        'Three calculators: Daily Calorie Calculator, Ideal Body Weight Calculator, '
        'and Protein Intake Calculator. Each uses scientifically backed formulas.',
  },
  {
    'question': 'How is progress tracked?',
    'answer':
        'Every time you update your weight or save a measurement from any calculator, '
        'it is logged on the Progress page. The chart visualizes your changes over time.',
  },
  {
    'question': 'Is my data safe?',
    'answer':
        'All your data is stored locally on your device. We do not collect, transmit, '
        'or store any personal information on external servers.',
  },
  {
    'question': 'What is Guest Mode?',
    'answer':
        'Guest Mode lets you explore the app without creating an account. '
        'Your data is saved locally. You can use all features as a guest.',
  },
];

const List<Map<String, dynamic>> helpTroubleshooting = [
  {
    'issue': 'Calculators not updating results',
    'solutions': [
      'Tap "Calculate" after changing any input value',
      'Ensure all fields are filled in correctly',
      'Restart the app and try again',
    ],
  },
  {
    'issue': 'Goals not showing on dashboard',
    'solutions': [
      'Make sure you have set at least one goal in Profile > My Goals',
      'Pull down on the Home page to refresh',
      'Check that goal values are realistic (non-zero)',
    ],
  },
  {
    'issue': 'Dark Mode toggle not working',
    'solutions': [
      'Restart the app after toggling',
      'Check your device system settings',
      'Update to the latest app version',
    ],
  },
  {
    'issue': 'Progress chart not displaying',
    'solutions': [
      'Log at least two weight measurements',
      'Ensure measurements are saved successfully',
      'Pull down to refresh the Progress page',
    ],
  },
  {
    'issue': 'App feels slow or unresponsive',
    'solutions': [
      'Close background apps to free memory',
      'Clear app cache in device settings',
      'Restart your device',
    ],
  },
];

const List<Map<String, dynamic>> helpTips = [
  {
    'icon': Icons.flag_outlined,
    'title': 'Set Realistic Goals',
    'description': 'Aim for 0.5–1 kg change per week for sustainable results.',
  },
  {
    'icon': Icons.calendar_month_outlined,
    'title': 'Consistent Updates',
    'description': 'Weigh yourself on the same day and time each week for accurate trends.',
  },
  {
    'icon': Icons.calculate_outlined,
    'title': 'Use All Calculators',
    'description': 'Combine calorie, protein, and ideal weight calculators for a complete plan.',
  },
  {
    'icon': Icons.dashboard_rounded,
    'title': 'Check Dashboard Daily',
    'description': 'Your home dashboard shows everything — check it daily to stay on track.',
  },
  {
    'icon': Icons.dark_mode_outlined,
    'title': 'Dark Mode at Night',
    'description': 'Enable Dark Mode during evening hours to reduce eye strain.',
  },
  {
    'icon': Icons.notifications_active_outlined,
    'title': 'Enable Notifications',
    'description': 'Turn on reminders to stay consistent with your measurement updates.',
  },
  {
    'icon': Icons.fitness_center,
    'title': 'Update Bodybuilder Status',
    'description': 'Set your bodybuilder status in profile for more accurate protein calculations.',
  },
  {
    'icon': Icons.trending_up,
    'title': 'Review Progress Weekly',
    'description': 'Check your progress chart every week to stay motivated and adjust goals.',
  },
];
