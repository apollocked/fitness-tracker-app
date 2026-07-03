import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_dialog_text_field.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_type_selector.dart';
import 'package:fit_tracker/presentation/widgets/goals/goal_active_toggle.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class GoalEditContent extends StatelessWidget {
  final TextEditingController currentController;
  final TextEditingController targetController;
  final String unit;
  final bool showGoalType;
  final String? selectedGoalType;
  final ValueChanged<String?> onGoalTypeChanged;
  final bool isActive;
  final ValueChanged<bool> onActiveChanged;

  const GoalEditContent({
    super.key,
    required this.currentController,
    required this.targetController,
    required this.unit,
    required this.showGoalType,
    required this.selectedGoalType,
    required this.onGoalTypeChanged,
    required this.isActive,
    required this.onActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDialogTextField(
          controller: currentController,
          text: l10n.goalEditCurrentWeight(unit),
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16),
        CustomDialogTextField(
          controller: targetController,
          text: l10n.goalEditTargetWeight(unit),
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16),
        if (showGoalType) ...[
          GoalTypeSelector(
            value: selectedGoalType,
            onChanged: onGoalTypeChanged,
          ),
          const SizedBox(height: 20),
        ],
        GoalActiveToggle(
          isActive: isActive,
          onChanged: onActiveChanged,
        ),
      ],
    );
  }
}
