import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/presentation/widgets/home/home_widgets.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthViewModel>().currentUser?.username;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: customAppBarr(
          'FitTracker', theme.primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            GreetingBanner(username: username),
            const SizedBox(height: 24),
            Text('Quick Calculators',
                style:
                    theme.textTheme.titleMedium?.copyWith(letterSpacing: 0.2)),
            const SizedBox(height: 14),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.95,
              children: [
                DashboardCard(
                  title: 'Ideal Body Weight',
                  icon: Icons.monitor_weight_outlined,
                  accentColor: const Color(0xFF2962FF),
                  label: 'Calculate',
                  onTap: () => Navigator.pushNamed(context, '/ideal-weight'),
                ),
                DashboardCard(
                  title: 'Protein Intake',
                  icon: Icons.restaurant_outlined,
                  accentColor: Colors.orange,
                  label: 'Calculate',
                  onTap: () => Navigator.pushNamed(context, '/protein-intake'),
                ),
                DashboardCard(
                  title: 'Daily Calories',
                  icon: Icons.local_fire_department_outlined,
                  accentColor: Colors.red,
                  label: 'Calculate',
                  onTap: () => Navigator.pushNamed(context, '/daily-calories'),
                ),
                DashboardCard(
                  title: 'Update Weight',
                  icon: Icons.scale_outlined,
                  accentColor: Colors.green,
                  label: 'Track Weight',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddMeasurementPage())),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _TipCard(),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
      ),
      child: Row(children: [
        Icon(Icons.lightbulb_outline, color: theme.primaryColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Consistency beats intensity — small daily habits build lasting results.',
            style: theme.textTheme.bodySmall,
          ),
        ),
      ]),
    );
  }
}
