import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/goals_page.dart';
import 'package:fit_tracker/presentation/widgets/home/home_widgets.dart';
import 'package:fit_tracker/presentation/widgets/home/calculator_sheet.dart';
import 'package:fit_tracker/presentation/widgets/home/daily_tip_card.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProgressViewModel>().loadMeasurements();
    });
  }

  Future<void> _addMeasurement() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddMeasurementPage()),
    );
    if (result == true && mounted) {
      context.read<ProgressViewModel>().loadMeasurements();
    }
  }

  void _goToCalculators() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => const CalculatorSheet(),
    );
  }

  void _goToGoals() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const GoalsPage()));
  }

  void _goToProgress() {
    context.read<AppViewModel>().setIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authVM = context.watch<AuthViewModel>();
    final user = authVM.currentUser;
    final measurements = context.watch<ProgressViewModel>().measurements;
    final theme = Theme.of(context);
    final latestWeight =
        measurements.isNotEmpty ? measurements.last.weight : null;

    return Scaffold(
      appBar: customAppBarr(
          l10n.appTitle, theme.primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingBanner(username: user?.username),
            const SizedBox(height: 16),
            if (user != null)
              StatsSummaryCard(user: user, latestWeight: latestWeight),
            if (user != null) const SizedBox(height: 16),
            DashboardGoalsSection(onViewAll: _goToGoals),
            const SizedBox(height: 16),
            RecentWeightSection(onAdd: _addMeasurement),
            const SizedBox(height: 16),
            QuickActionRow(
              onCalculators: _goToCalculators,
              onGoals: _goToGoals,
              onProgress: _goToProgress,
            ),
            const SizedBox(height: 16),
            const DailyTipCard(),
          ],
        ),
      ),
    );
  }
}
