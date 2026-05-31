import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/goals/goals_tile.dart';

class GoalsList extends StatelessWidget {
  const GoalsList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        const GoalTile(goalKey: 'weight'),
        const SizedBox(height: 16),
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
                  style: TextStyle(fontSize: 12, color: Colors.blue[800]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
