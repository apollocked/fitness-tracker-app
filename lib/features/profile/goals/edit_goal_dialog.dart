import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/widgets/custom_dialog_text_field.dart';
import 'package:fit_tracker/core/theme/colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/app/cubits/goals_cubit.dart';

class EditGoalDialog extends StatefulWidget {
  final String goalKey;
  const EditGoalDialog({super.key, required this.goalKey});
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
    final goal = context.read<GoalsCubit>().state.goals[widget.goalKey]!;
    _targetController = TextEditingController(text: goal['target'].toString());
    _currentController =
        TextEditingController(text: goal['current'].toString());
    _isActive = goal['active'] == true;
    _selectedGoalType = goal['goalType'];
    if (widget.goalKey == 'weight' && _selectedGoalType == null) {
      double target = double.tryParse(_targetController.text) ?? 0;
      double current = double.tryParse(_currentController.text) ?? 0;
      _selectedGoalType = current > target
          ? 'lose'
          : current < target
              ? 'gain'
              : 'maintain';
    }
  }

  @override
  void dispose() {
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goal = context.read<GoalsCubit>().state.goals[widget.goalKey]!;
    return AlertDialog(
      backgroundColor: colors.cardColor,
      title: Text(
          'Edit ${widget.goalKey[0].toUpperCase() + widget.goalKey.substring(1)} Goal',
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
            child: const Text('Cancel')),
        TextButton(onPressed: _saveChanges, child: const Text('Save')),
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
              onChanged: (value) => setState(() => _isActive = value)),
        ],
      ),
    );
  }

  void _saveChanges() {
    if (_targetController.text.isEmpty || _currentController.text.isEmpty) {
      return;
    }
    final cubit = context.read<GoalsCubit>();
    final goal = cubit.state.goals[widget.goalKey]!;
    double targetValue = double.tryParse(_targetController.text) ?? 0.0;
    double currentValue = double.tryParse(_currentController.text) ?? 0.0;
    if (goal['unit'] == 'cal') {
      targetValue = targetValue.toInt().toDouble();
      currentValue = currentValue.toInt().toDouble();
    }
    Map<String, dynamic> updatedGoal = {
      'target': targetValue,
      'current': currentValue,
      'unit': goal['unit'],
      'active': _isActive,
    };
    if (widget.goalKey == 'weight') {
      updatedGoal['goalType'] = _selectedGoalType;
      bool goalTypeChanged = goal['goalType'] != _selectedGoalType;
      bool targetChanged = goal['target'] != targetValue;
      updatedGoal['startWeight'] =
          (goal['startWeight'] == null || goalTypeChanged || targetChanged)
              ? currentValue
              : goal['startWeight'];
    }
    cubit.updateGoal(widget.goalKey, updatedGoal);
    Navigator.pop(context);
  }
}
