import 'package:flutter/material.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/pages/Profile/Settings/goals_tile.dart';

class GoalsList extends StatefulWidget {
  final GoalsController controller;

  // ignore: use_super_parameters
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
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: widget.controller.goals.length,
      itemBuilder: (_, index) {
        final key = widget.controller.goals.keys.elementAt(index);
        return GoalTile(goalKey: key, controller: widget.controller);
      },
    );
  }
}
