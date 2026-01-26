import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/support_contact_widget.dart';
import 'package:myapp/utils/colors.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('Help & Support', primaryColor, backgroundColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Our Features',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Learn how to use our fitness app features',
              style: TextStyle(color: Colors.grey[600]),
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
                  'Set and manage your fitness goals to stay focused on what matters to you.',
              benefits: [
                'Define clear fitness objectives',
                'Stay motivated and focused',
                'Track progress toward your goals',
                'Adjust goals as you achieve them',
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
                'Set realistic weight goals',
                'Track progress toward ideal weight',
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureCard(
              icon: Icons.restaurant,
              title: 'Protein Intake Calculator',
              description:
                  'Calculate your daily protein needs based on your weight and fitness level (bodybuilder or regular).',
              benefits: [
                'Determine daily protein requirements',
                'Different calculations for athletes and regular users',
                'Build muscle effectively with proper nutrition',
                'Optimize your diet based on fitness goals',
              ],
            ),
            const SizedBox(height: 32),
            const SupportContactWidget(
              email: 'support@fitnessapp.com',
              title: 'Need Help?',
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(height: 16),
          const Text(
            'Why it\'s useful:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
                        style: TextStyle(color: Colors.grey[700]),
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
