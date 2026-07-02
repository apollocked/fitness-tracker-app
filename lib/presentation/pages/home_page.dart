import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/presentation/pages/profile_child_pages/goals_page.dart';
import 'package:fit_tracker/presentation/widgets/home/home_widgets.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
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
      builder: (ctx) => _CalculatorSheet(),
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
            _DailyTipCard(),
          ],
        ),
      ),
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    final tips = [
      'Consistency beats intensity — small daily habits build lasting results.',
      'Stay hydrated! Drink water before, during, and after your workout.',
      'Aim for 7-9 hours of sleep to support muscle recovery and growth.',
      'Track your meals — what gets measured gets managed.',
      'Rest days are just as important as training days.',
    ];
    final tip = tips[DateTime.now().day % tips.length];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.lightbulb_outline, color: primaryColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.homeDailyTip,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor)),
                const SizedBox(height: 4),
                Text(tip,
                    style: TextStyle(
                        fontSize: 13, color: colors.textColor, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalculatorSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.homeCalculators,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors.textColor)),
          const SizedBox(height: 8),
          Text('Science-backed tools to guide your fitness journey',
              style: TextStyle(fontSize: 13, color: colors.subtitleColor)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _CalcTile(
                icon: Icons.monitor_weight_outlined,
                title: 'Ideal Body Weight',
                color: primaryColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/ideal-weight');
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: _CalcTile(
                icon: Icons.restaurant_outlined,
                title: l10n.homeProteinIntake,
                color: orangeColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/protein-intake');
                },
              )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _CalcTile(
                icon: Icons.local_fire_department_outlined,
                title: l10n.homeCalorieCalculator,
                color: redColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/daily-calories');
                },
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: _CalcTile(
                icon: Icons.scale_outlined,
                title: 'Log Weight',
                color: greenColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddMeasurementPage()));
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalcTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _CalcTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(isDark ? 0.12 : 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(isDark ? 0.25 : 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 6),
            Text(title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: (isDark ? Colors.white : Colors.black87)),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
