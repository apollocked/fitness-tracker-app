import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/goals_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/presentation/widgets/progress/empty_state.dart';
import 'package:fit_tracker/presentation/widgets/progress/measurement_list.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProgressViewModel>().loadMeasurements();
    });
  }

  Future<void> _addMeasurement() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AddMeasurementPage()));
    if (result == true && context.mounted) {
      context.read<ProgressViewModel>().loadMeasurements();
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurements = context.watch<ProgressViewModel>().measurements;
    final goalsVM = context.watch<GoalsViewModel>();
    final theme = Theme.of(context);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: customAppBarr(
          l10n.progressTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: measurements.isEmpty
          ? ProgressEmptyState(onAdd: _addMeasurement)
          : MeasurementList(
              measurements: measurements,
              goalsVM: goalsVM,
              colors: colors,
            ),
    );
  }
}
