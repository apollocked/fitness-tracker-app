import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('App Features', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover Our Features',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: getTextColor()),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore all the tools and capabilities available in our fitness app',
              style: TextStyle(color: getSubtitleColor()),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              icon: Icons.calculate,
              title: 'Daily Calorie Calculator',
              description:
                  'Calculate your daily calorie needs based on your age, weight, height, gender, and activity level.',
              benefits: [
                'Know how many calories you need to maintain your weight',
                'Get calorie targets for weight loss or gain',
                'Plan your diet based on your goals',
                'Track your nutrition accurately',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.trending_up,
              title: 'Progress Tracking',
              description:
                  'Record and monitor your body measurements over time to see your fitness progress.',
              benefits: [
                'Track weight changes week by week',
                'Monitor waist circumference reduction',
                'Visualize your fitness journey',
                'Stay motivated with progress data',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.person,
              title: 'Personal Information',
              description:
                  'Manage your profile data including age, height, weight, gender, and other personal details.',
              benefits: [
                'Keep your fitness profile up to date',
                'Personalize your fitness experience',
                'Use accurate data for calculations',
                'View all your registered information',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.flag,
              title: 'Fitness Goals',
              description:
                  'Set and manage your fitness goals to stay focused on what matters to you. Track your progress towards weight, calorie, and protein targets.',
              benefits: [
                'Define clear fitness objectives (weight, calories, protein)',
                'Stay motivated and focused on your targets',
                'Track progress towards your goals with visual indicators',
                'Adjust goals as you achieve them or change objectives',
                'View goal completion status and progress percentage',
                'Automatically sync goals with calculator results',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.monitor_weight,
              title: 'Ideal Body Weight Calculator',
              description:
                  'Calculate your ideal body weight based on your height and gender using scientific formulas.',
              benefits: [
                'Know your ideal weight target',
                'Understand how much weight to gain or lose',
                'Set realistic weight goals automatically',
                'Track progress toward ideal weight with detailed metrics',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.restaurant,
              title: 'Protein Intake Calculator',
              description:
                  'Calculate your daily protein needs based on your weight and fitness level (bodybuilder or regular).',
              benefits: [
                'Determine daily protein requirements for your fitness level',
                'Different calculations for athletes and regular users',
                'Build muscle effectively with proper nutrition',
                'Optimize your diet based on your fitness goals',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              description:
                  'Switch between light and dark themes to suit your preference and reduce eye strain.',
              benefits: [
                'Easy on the eyes during night-time usage',
                'Reduce eye strain with dark background option',
                'Save battery on OLED devices with dark theme',
                'Automatic preference saving for seamless experience',
                'Switch themes instantly from Settings',
                'All UI elements adapt to your theme choice',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.psychology,
              title: 'Smart Goal Management',
              description:
                  'Advanced goal tracking system that automatically determines your goal type and tracks progress with real-time metrics.',
              benefits: [
                'Auto-detect weight loss, gain, or maintenance goals',
                'Real-time progress tracking with percentage indicators',
                'Visual progress bars showing completion status',
                'Edit goals anytime to adjust your targets',
                'View completion status (In progress, Achieved, Not started)',
                'Goal statistics showing total, active, and completed goals',
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: primaryColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: getTextColor(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Visit Help & Support for FAQs and troubleshooting',
                          style: TextStyle(
                            fontSize: 12,
                            color: getSubtitleColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> benefits,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: getCardColor(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode()
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(color: getSubtitleColor(), fontSize: 14),
          ),
          const SizedBox(height: 16),
          Text(
            'Why it\'s useful:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: getTextColor()),
          ),
          const SizedBox(height: 8),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle,
                        size: 20, color: Colors.green[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: TextStyle(color: getSubtitleColor()),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
