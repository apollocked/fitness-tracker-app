// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class EditGoalDialog extends StatefulWidget {
  final String goalKey;
  final GoalsController controller;

  const EditGoalDialog({
    Key? key,
    required this.goalKey,
    required this.controller,
  }) : super(key: key);

  @override
  State<EditGoalDialog> createState() => _EditGoalDialogState();
}

class _EditGoalDialogState extends State<EditGoalDialog> {
  late final TextEditingController _targetController;
  late final TextEditingController _currentController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    final goal = widget.controller.goals[widget.goalKey]!;
    _targetController = TextEditingController(text: goal['target'].toString());
    _currentController =
        TextEditingController(text: goal['current'].toString());
    _isActive = goal['active'] == true;
  }

  @override
  Widget build(BuildContext context) {
    final goal = widget.controller.goals[widget.goalKey]!;

    return Dialog(
      backgroundColor: getCardColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit ${GoalsController.capitalize(widget.goalKey)} Goal',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: getTextColor())),
              const SizedBox(height: 20),
              _buildInputField('Current ${goal['unit']}', _currentController),
              const SizedBox(height: 16),
              _buildInputField('Target ${goal['unit']}', _targetController),
              const SizedBox(height: 16),
              _buildActiveSwitch(),

              // Show goal type info if it's a weight goal
              if (widget.goalKey == 'weight' && goal['goalType'] != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: _getGoalTypeColor(goal['goalType']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _getGoalTypeColor(goal['goalType'])
                            .withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getGoalTypeIcon(goal['goalType']),
                        color: _getGoalTypeColor(goal['goalType']),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Goal Type',
                                style: TextStyle(
                                    fontSize: 12, color: getSubtitleColor())),
                            Text(
                              goal['goalType'] == 'lose'
                                  ? 'Lose Weight'
                                  : goal['goalType'] == 'gain'
                                      ? 'Gain Weight'
                                      : 'Maintain Weight',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getGoalTypeColor(goal['goalType'])),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: getSubtitleColor())),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: getCardColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: getTextColor()),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: TextStyle(color: getSubtitleColor()),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: getCardColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Active Goal',
              style: TextStyle(fontSize: 16, color: getTextColor())),
          Switch(
            value: _isActive,
            activeColor: primaryColor,
            onChanged: (value) => setState(() => _isActive = value),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text('Cancel',
                style: TextStyle(
                    color: primaryColor, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomElevatedButton(
            onpressed: _saveChanges,
            text: 'Save Changes',
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _saveChanges() {
    if (_targetController.text.isNotEmpty &&
        _currentController.text.isNotEmpty) {
      final goal = widget.controller.goals[widget.goalKey]!;

      // Parse values appropriately
      double targetValue = double.tryParse(_targetController.text) ?? 0.0;
      double currentValue = double.tryParse(_currentController.text) ?? 0.0;

      // Convert to int if needed (for calories)
      if (goal['unit'] == 'cal') {
        targetValue = targetValue.toInt().toDouble();
        currentValue = currentValue.toInt().toDouble();
      }

      // For weight goal, automatically determine new goal type
      Map<String, dynamic> updatedGoal = {
        'target': targetValue,
        'current': currentValue,
        'unit': goal['unit'],
        'active': _isActive,
      };

      if (widget.goalKey == 'weight') {
        // Automatically determine goal type based on new values
        String newGoalType;
        if (targetValue < currentValue) {
          newGoalType = "lose";
        } else if (targetValue > currentValue) {
          newGoalType = "gain";
        } else {
          newGoalType = "maintain";
        }
        updatedGoal['goalType'] = newGoalType;
      } else if (goal['goalType'] != null) {
        // Keep existing goal type for other goals
        updatedGoal['goalType'] = goal['goalType'];
      }

      widget.controller.updateGoal(widget.goalKey, updatedGoal);
      Navigator.pop(context);
    }
  }

  Color _getGoalTypeColor(String? goalType) {
    switch (goalType) {
      case 'lose':
        return greenColor;
      case 'gain':
        return orangeColor;
      default:
        return blueColor;
    }
  }

  IconData _getGoalTypeIcon(String? goalType) {
    switch (goalType) {
      case 'lose':
        return Icons.trending_down;
      case 'gain':
        return Icons.trending_up;
      default:
        return Icons.trending_flat;
    }
  }

  @override
  void dispose() {
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }
}
