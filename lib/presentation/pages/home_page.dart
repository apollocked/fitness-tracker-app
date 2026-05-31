import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    final user = context.watch<AuthViewModel>().currentUser;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: customAppBarr(
        'FitTracker',
        primaryColor,
        theme.scaffoldBackgroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // Greeting banner
            _buildGreetingBanner(context, user?.username, isDark, colors),
            const SizedBox(height: 24),
            Text(
              'Quick Calculators',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textColor,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 14),
            // Grid of cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.95,
              children: [
                _buildDashboardCard(
                  context,
                  'Ideal Body Weight',
                  Icons.monitor_weight_outlined,
                  blueColor,
                  'Calculate',
                  isDark,
                  () => Navigator.pushNamed(context, '/ideal-weight'),
                ),
                _buildDashboardCard(
                  context,
                  'Protein Intake',
                  Icons.restaurant_outlined,
                  orangeColor,
                  'Calculate',
                  isDark,
                  () => Navigator.pushNamed(context, '/protein-intake'),
                ),
                _buildDashboardCard(
                  context,
                  'Daily Calories',
                  Icons.local_fire_department_outlined,
                  redColor,
                  'Calculate',
                  isDark,
                  () => Navigator.pushNamed(context, '/daily-calories'),
                ),
                _buildDashboardCard(
                  context,
                  'Update Weight',
                  Icons.scale_outlined,
                  greenColor,
                  'Track Weight',
                  isDark,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMeasurementPage(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTipCard(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingBanner(
    BuildContext context,
    String? username,
    bool isDark,
    AppColorsExtension colors,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [primaryColor.withOpacity(0.25), primaryColor.withOpacity(0.08)]
              : [primaryColor.withOpacity(0.15), primaryColor.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withOpacity(isDark ? 0.3 : 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${username ?? 'Athlete'}! 👋',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Track your fitness journey today',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.fitness_center, color: primaryColor, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String value,
    bool isDark,
    VoidCallback onTap,
  ) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(isDark ? 0.25 : 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadowColor,
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 26, color: color),
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textColor,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, bool isDark) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryColor.withOpacity(isDark ? 0.25 : 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.lightbulb_outline, color: primaryColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fitness Tip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Consistency beats intensity. Small daily habits build lasting results.',
                  style: TextStyle(fontSize: 12, color: colors.subtitleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
