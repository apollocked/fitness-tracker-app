import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Goals/goals_tile.dart';

class GoalsList extends StatefulWidget {
  final GoalsController controller;

  const GoalsList({super.key, required this.controller});

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
    final weightGoal = widget.controller.goals['weight'];

    if (weightGoal == null) {
      return const SizedBox();
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        GoalTile(goalKey: 'weight', controller: widget.controller),
        const SizedBox(height: 16),
        // Add a note about read-only goals
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Weight goals can be edited. Calorie and protein goals are set from their calculators.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
