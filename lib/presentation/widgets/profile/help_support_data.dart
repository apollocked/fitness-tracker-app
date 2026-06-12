import 'package:flutter/material.dart';

const List<Map<String, dynamic>> helpFaqs = [
  {
    'question': 'How do I update my weight?',
    'answer':
        'Go to the Home page > Click "Update Weight" card > Enter your current weight > Save.',
  },
  {
    'question': 'Can I edit my fitness goals?',
    'answer':
        'Yes! Go to Profile > My Goals > Click the Edit button on any goal > Modify > Save.',
  },
  {
    'question': 'How do I enable Dark Mode?',
    'answer':
        'Go to Profile > Settings > Find "Dark Mode" under Appearance > Toggle the switch.',
  },
  {
    'question': 'What calculators does the app have?',
    'answer':
        'Daily Calorie Calculator, Ideal Body Weight Calculator, and Protein Intake Calculator.',
  },
  {
    'question': 'Are my personal details safe?',
    'answer': 'Yes, all your data is stored locally on your device.',
  },
];

const List<Map<String, dynamic>> helpTroubleshooting = [
  {
    'issue': 'App crashes on startup',
    'solutions': [
      'Clear app cache in system settings',
      'Restart your phone',
      'Reinstall the app',
    ],
  },
  {
    'issue': 'Goals not updating',
    'solutions': [
      'Check your internet connection',
      'Log out and log back in',
    ],
  },
  {
    'issue': 'Dark Mode toggle not working',
    'solutions': [
      'Restart the app',
      'Check system dark mode settings',
    ],
  },
];

const List<Map<String, dynamic>> helpTips = [
  {
    'icon': Icons.flag_outlined,
    'title': 'Set Realistic Goals',
    'description': 'Aim for 0.5-1 kg weight loss/gain per week.',
  },
  {
    'icon': Icons.calendar_month_outlined,
    'title': 'Consistent Updates',
    'description': 'Update measurements on the same day each week.',
  },
  {
    'icon': Icons.calculate_outlined,
    'title': 'Use All Calculators',
    'description': 'Use all tools for a complete fitness plan.',
  },
  {
    'icon': Icons.dark_mode_outlined,
    'title': 'Dark Mode at Night',
    'description': 'Enable Dark Mode during evening to reduce eye strain.',
  },
  {
    'icon': Icons.notifications_active_outlined,
    'title': 'Enable Notifications',
    'description': 'Stay reminded about your goals.',
  },
  {
    'icon': Icons.fitness_center,
    'title': 'Track Bodybuilder Status',
    'description': 'Update your status for accurate calculations.',
  },
];
