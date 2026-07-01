import 'package:flutter/material.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/shared/app_card.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar:
          customAppBarr('About', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8))
                ],
              ),
              child: const Icon(Icons.fitness_center_rounded,
                  size: 64, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Text('Fitness Tracker',
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: colors.textColor)),
            const SizedBox(height: 4),
            Text('Version 1.2.1',
                style: TextStyle(
                    fontSize: 14,
                    color: colors.subtitleColor,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 32),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: primaryColor, size: 22),
                      const SizedBox(width: 10),
                      Text('About This App',
                          style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Fitness Tracker is your personal fitness companion designed to help you achieve your health and fitness goals. Whether you\'re looking to lose weight, build muscle, or maintain a healthy lifestyle, our app provides all the tools you need in one place.',
                    style: TextStyle(
                        fontSize: 14, color: colors.subtitleColor, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(Icons.track_changes_rounded,
                          color: orangeColor, size: 22),
                      const SizedBox(width: 10),
                      Text('Our Mission', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We believe fitness is a journey, not a destination. Our mission is to make fitness tracking simple, accessible, and enjoyable for everyone. With Fitness Tracker, you\'re never alone in your fitness journey.',
                    style: TextStyle(
                        fontSize: 14, color: colors.subtitleColor, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppCard(
              borderColor: primaryColor.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Information', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 16),
                  _infoRow('App Name', 'Fitness Tracker', colors),
                  _divider(colors),
                  _infoRow('Version', '1.2.1', colors),
                  _divider(colors),
                  _infoRow('Developer', 'Mohammed jameel - Apollo', colors),
                  _divider(colors),
                  _infoRow('Tech Stack', 'Flutter & Dart', colors),
                  _divider(colors),
                  _infoRow('Email', 'mahamadbarznji712@gmail.com', colors,
                      isLink: true),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, AppColorsExtension colors,
      {bool isLink = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(color: colors.subtitleColor, fontSize: 14)),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isLink ? primaryColor : colors.textColor,
                fontSize: 14)),
      ],
    );
  }

  Widget _divider(AppColorsExtension colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: colors.subtitleColor.withOpacity(0.1)),
    );
  }
}
