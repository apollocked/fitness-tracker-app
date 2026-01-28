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
          const SizedBox(height: 16),
          // Show calculator goal creation cards
          _buildCalculatorGoalCards(),
          const SizedBox(height: 16),
          // Show existing goals (only weight goals will appear here)
          Expanded(
            child: _controller.goals.containsKey('weight')
                ? GoalsList(controller: _controller)
                : _buildNoWeightGoalState(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorGoalCards() {
    final hasCalorieGoal = _controller.goals.containsKey('calories');
    final hasProteinGoal = _controller.goals.containsKey('protein');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Calorie Goal Card
          _buildCalculatorCard(
            icon: Icons.local_fire_department,
            title: 'Daily Calorie Goal',
            description: 'Set your daily calorie intake target',
            isCreated: hasCalorieGoal,
            onTap: () {
              Navigator.pushNamed(context, '/daily-calories');
            },
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          // Protein Goal Card
          _buildCalculatorCard(
            icon: Icons.restaurant,
            title: 'Protein Intake Goal',
            description: 'Set your daily protein intake target',
            isCreated: hasProteinGoal,
            onTap: () {
              Navigator.pushNamed(context, '/protein-intake');
            },
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isCreated,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getCardColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCreated
                ? color.withOpacity(0.5)
                : Colors.grey.withOpacity(0.3),
            width: isCreated ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: getTextColor(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: getSubtitleColor(),
                    ),
                  ),
                  if (isCreated) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle,
                              size: 14, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            'Goal Set',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              isCreated ? Icons.edit : Icons.add,
              color: isCreated ? color : getSubtitleColor(),
            ),
          ],
        ),
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
