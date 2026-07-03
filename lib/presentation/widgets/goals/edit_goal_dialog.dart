import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_edit_content.dart';

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
    final goalsVM = context.read<GoalsViewModel>();
    final goal = goalsVM.goals[widget.goalKey]!;
    _targetController = TextEditingController(text: goal['target'].toString());
    _currentController = TextEditingController(text: goal['current'].toString());
    _isActive = goal['active'] == true;
    _selectedGoalType = goal['goalType'];
    if (widget.goalKey == 'weight' && _selectedGoalType == null) {
      double t = double.tryParse(_targetController.text) ?? 0;
      double c = double.tryParse(_currentController.text) ?? 0;
      _selectedGoalType = c > t ? 'lose' : c < t ? 'gain' : 'maintain';
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
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final goal = context.read<GoalsViewModel>().goals[widget.goalKey]!;
    return AlertDialog(
      backgroundColor: colors.cardColor,
      title: Text(l10n.goalEditTitle('${widget.goalKey[0].toUpperCase()}${widget.goalKey.substring(1)}'),
          style: TextStyle(color: colors.textColor)),
      content: SingleChildScrollView(
        child: GoalEditContent(
          currentController: _currentController,
          targetController: _targetController,
          unit: goal['unit'] ?? 'kg',
          showGoalType: widget.goalKey == 'weight',
          selectedGoalType: _selectedGoalType,
          onGoalTypeChanged: (value) => setState(() => _selectedGoalType = value),
          isActive: _isActive,
          onActiveChanged: (value) => setState(() => _isActive = value),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.goalEditCancel)),
        TextButton(onPressed: _saveChanges, child: Text(l10n.goalEditSave)),
      ],
    );
  }

  void _saveChanges() {
    if (_targetController.text.isEmpty || _currentController.text.isEmpty) return;
    final goalsVM = context.read<GoalsViewModel>();
    final goal = goalsVM.goals[widget.goalKey]!;
    double targetValue = double.tryParse(_targetController.text) ?? 0.0;
    double currentValue = double.tryParse(_currentController.text) ?? 0.0;
    if (goal['unit'] == 'cal') {
      targetValue = targetValue.toInt().toDouble();
      currentValue = currentValue.toInt().toDouble();
    }
    Map<String, dynamic> updatedGoal = {
      'target': targetValue,
      'current': currentValue,
      'unit': goal['unit'] ?? 'kg',
      'active': _isActive,
    };
    if (widget.goalKey == 'weight') {
      updatedGoal['goalType'] = _selectedGoalType;
      bool gtChanged = goal['goalType'] != _selectedGoalType;
      bool tChanged = goal['target'] != targetValue;
      updatedGoal['startWeight'] = (goal['startWeight'] == null || gtChanged || tChanged)
          ? currentValue : goal['startWeight'];
    }
    goalsVM.updateGoal(widget.goalKey, updatedGoal);
    Navigator.pop(context);
  }
}
