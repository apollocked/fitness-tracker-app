import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/Goals/goal_status.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Goals/goals_list.dart';
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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload goals when page is focused again
    _controller.loadGoals();
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
          Expanded(
            child: GoalsList(controller: _controller),
          ),
        ],
      ),
    );
  }
}
