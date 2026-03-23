// lib/pages/Profile/Goals/edit_goal_dialog.dart
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_dialog_text_field.dart';
import 'package:myapp/pages/Profile/Goals/goals_controller.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/app_theme.dart';

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
  String? _selectedGoalType;

  @override
  void initState() {
    super.initState();
    final goal = widget.controller.goals[widget.goalKey]!;
    _targetController = TextEditingController(text: goal['target'].toString());
    _currentController =
        TextEditingController(text: goal['current'].toString());
    _isActive = goal['active'] == true;
    _selectedGoalType = goal['goalType'];

    // Default goal type for weight if not set
    if (widget.goalKey == 'weight' && _selectedGoalType == null) {
      double target = double.tryParse(_targetController.text) ?? 0;
      double current = double.tryParse(_currentController.text) ?? 0;
      if (current > target) {
        _selectedGoalType = 'lose';
      } else if (current < target) {
        _selectedGoalType = 'gain';
      } else {
        _selectedGoalType = 'maintain';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goal = widget.controller.goals[widget.goalKey]!;

    return AlertDialog(
      backgroundColor: colors.cardColor,
      title: Text('Edit ${GoalsController.capitalize(widget.goalKey)} Goal',
          style: TextStyle(color: colors.textColor)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDialogTextField(
              controller: _currentController,
              text: 'Current Weight (${goal['unit']})',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            CustomDialogTextField(
              controller: _targetController,
              text: 'Target Weight (${goal['unit']})',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            if (widget.goalKey == 'weight') ...[
              DropdownButtonFormField<String>(
                value: _selectedGoalType,
                decoration: InputDecoration(
                  labelText: 'Goal Type',
                  labelStyle: TextStyle(color: colors.subtitleColor),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: colors.subtitleColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                dropdownColor: colors.cardColor,
                items: [
                  DropdownMenuItem(
                      value: 'lose',
                      child: Text('Lose Weight',
                          style: TextStyle(color: colors.textColor))),
                  DropdownMenuItem(
                      value: 'gain',
                      child: Text('Gain Weight',
                          style: TextStyle(color: colors.textColor))),
                  DropdownMenuItem(
                      value: 'maintain',
                      child: Text('Maintain Weight',
                          style: TextStyle(color: colors.textColor))),
                ],
                onChanged: (value) => setState(() => _selectedGoalType = value),
              ),
              const SizedBox(height: 20),
            ],
            _buildActiveSwitch(colors),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _saveChanges,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildActiveSwitch(AppColorsExtension colors) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.subtitleColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Active Goal',
              style: TextStyle(fontSize: 16, color: colors.textColor)),
          Switch(
            value: _isActive,
            activeColor: primaryColor,
            onChanged: (value) => setState(() => _isActive = value),
          ),
        ],
      ),
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

      // Prepare updated goal map
      Map<String, dynamic> updatedGoal = {
        'target': targetValue,
        'current': currentValue,
        'unit': goal['unit'],
        'active': _isActive,
      };

      // Handle weight specific fields
      if (widget.goalKey == 'weight') {
        updatedGoal['goalType'] = _selectedGoalType;

        // Determine if we need to update/set startWeight
        bool goalTypeChanged = goal['goalType'] != _selectedGoalType;
        bool targetChanged = goal['target'] != targetValue;

        if (goal['startWeight'] == null || goalTypeChanged || targetChanged) {
          // If goal type or target changed significantly, reset startWeight to current
          updatedGoal['startWeight'] = currentValue;
        } else {
          // Keep existing startWeight
          updatedGoal['startWeight'] = goal['startWeight'];
        }
      }

      widget.controller.updateGoal(widget.goalKey, updatedGoal);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }
}
