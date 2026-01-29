// lib/pages/Profile/Goals/goals_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/Goals/goal_status.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Goals/goals_list.dart';
import 'package:myapp/pages/Profile/Goals/goals_square_row.dart';

import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  late final GoalsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GoalsController();
    _loadAndRefresh();
  }

  void _loadAndRefresh() {
    _controller.loadGoals();
    _controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('My Goals', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: Column(
        children: [
          GoalsStats(controller: _controller),
          const SizedBox(height: 16),
          GoalsSquareRow(controller: _controller),
          const SizedBox(height: 16),
          Expanded(
            child: _controller.goals.containsKey('weight')
                ? GoalsList(controller: _controller)
                : _buildNoWeightGoalState(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoWeightGoalState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.monitor_weight_outlined, size: 80, color: primaryColor),
          const SizedBox(height: 16),
          Text(
            'No Weight Goal Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: getTextColor(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Use the Ideal Body Weight Calculator to set your weight goal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: getSubtitleColor(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/ideal-weight');
            },
            icon: Icon(Icons.calculate, color: getBackgroundColor()),
            label: Text(
              'Set Weight Goal',
              style: TextStyle(color: getBackgroundColor()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
