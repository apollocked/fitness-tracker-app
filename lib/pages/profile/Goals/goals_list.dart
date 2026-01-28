// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Goals/goals_tile.dart';

class GoalsList extends StatefulWidget {
  final GoalsController controller;

  const GoalsList({Key? key, required this.controller}) : super(key: key);

  @override
  State<GoalsList> createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter to only show weight goals
    final weightGoals = widget.controller.goals.entries
        .where((entry) => entry.key == 'weight')
        .toList();

    if (weightGoals.isEmpty) {
      return const SizedBox();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: weightGoals.length,
      itemBuilder: (_, index) {
        final key = weightGoals[index].key;
        return GoalTile(goalKey: key, controller: widget.controller);
      },
    );
  }
}
