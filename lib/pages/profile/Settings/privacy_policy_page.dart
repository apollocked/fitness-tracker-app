import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/app_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      appBar: customAppBarr('Privacy Policy', primaryColor,
          Theme.of(context).scaffoldBackgroundColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: May 1, 2026',
              style: TextStyle(color: colors.subtitleColor),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              colors,
              '1. Information We Collect',
              'We collect the following information to provide our fitness tracking services:',
              [
                'Personal Information: Name, email address, age, gender',
                'Health Data: Weight, height, body measurements, fitness goals',
                'Usage Data: App usage patterns, feature interactions',
                'Device Information: Device type, operating system version'
              ],
            ),
            _buildSection(
              context,
              colors,
              '2. How We Use Your Information',
              'Your information is used exclusively to:',
              [
                'Provide personalized fitness calculations and recommendations',
                'Track your progress towards fitness goals',
                'Improve app functionality and user experience',
                'Communicate important updates about the app'
              ],
            ),
            _buildSection(
              context,
              colors,
              '3. Data Storage & Security',
              'We prioritize the security of your data:',
              [
                'All data is stored locally on your device',
                'No personal information is shared with third parties',
                'We implement industry-standard security practices',
                'You maintain full control over your data'
              ],
            ),
            _buildSection(
              context,
              colors,
              '4. Your Rights',
              'You have the following rights regarding your data:',
              [
                'Access your personal information at any time',
                'Update or correct inaccurate information',
                'Delete your account and all associated data',
                'Export your fitness data for personal use'
              ],
            ),
            _buildSection(
              context,
              colors,
              '5. Children\'s Privacy',
              'Our app is not intended for children under 13:',
              [
                'We do not knowingly collect data from children under 13',
                'If you are a parent and believe your child has provided data, contact us',
                'Users under 18 should use the app under parental supervision'
              ],
            ),
            _buildSection(
              context,
              colors,
              '6. Changes to This Policy',
              'We may update this privacy policy periodically:',
              [
                'We will notify you of any significant changes',
                'Continued use of the app indicates acceptance of changes',
                'You can review the latest version anytime in this section'
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'If you have any questions about this Privacy Policy, please contact us at:',
                    style: TextStyle(color: colors.subtitleColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'support@fitnessapp.com',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
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

  Widget _buildSection(BuildContext context, AppColorsExtension colors,
      String title, String description, List<String> points) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: colors.subtitleColor),
          ),
          const SizedBox(height: 12),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, size: 8, color: primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(color: colors.textColor),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
