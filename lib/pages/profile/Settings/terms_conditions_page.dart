import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr('Terms & Conditions', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: getTextColor(),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: TextStyle(color: getSubtitleColor()),
            ),
            const SizedBox(height: 24),
            
            _buildSection(
              '1. Acceptance of Terms',
              'By downloading, installing, or using the Fitness Tracker app, you agree to be bound by these Terms & Conditions. If you do not agree, please do not use the app.',
            ),
            
            _buildSection(
              '2. Eligibility',
              'You must be at least 13 years old to use this app. By using the app, you represent that you meet this age requirement.',
            ),
            
            _buildSection(
              '3. App Usage',
              'The Fitness Tracker app is intended for personal fitness tracking and educational purposes only. It is not a substitute for professional medical advice.',
            ),
            
            _buildSection(
              '4. Health Disclaimer',
              'The fitness calculations and recommendations provided are for informational purposes only. Consult with a healthcare professional before starting any fitness or nutrition program.',
            ),
            
            _buildSection(
              '5. User Responsibilities',
              'You are responsible for:',
              [
                'Providing accurate and truthful information',
                'Maintaining the confidentiality of your account',
                'Using the app in compliance with all applicable laws',
                'Not using the app for any unlawful purpose'
              ],
            ),
            
            _buildSection(
              '6. Intellectual Property',
              'All content, features, and functionality of the app are owned by Fitness Tracker and are protected by international copyright, trademark, and other intellectual property laws.',
            ),
            
            _buildSection(
              '7. Limitation of Liability',
              'Fitness Tracker shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use or inability to use the app.',
            ),
            
            _buildSection(
              '8. Termination',
              'We reserve the right to terminate or suspend your access to the app at our sole discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users.',
            ),
            
            _buildSection(
              '9. Changes to Terms',
              'We may modify these Terms at any time. We will provide notice of significant changes. Your continued use of the app constitutes acceptance of the modified Terms.',
            ),
            
            _buildSection(
              '10. Governing Law',
              'These Terms shall be governed by and construed in accordance with the laws of [Your Country/Region], without regard to its conflict of law provisions.',
            ),
            
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: getCardColor(),
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
                      color: getTextColor(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'For questions about these Terms & Conditions:',
                    style: TextStyle(color: getSubtitleColor()),
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

  Widget _buildSection(String title, String content, [List<String>? bulletPoints]) {
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
              color: getTextColor(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(color: getSubtitleColor()),
          ),
          if (bulletPoints != null) ...[
            const SizedBox(height: 12),
            ...bulletPoints.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 8, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(color: getTextColor()),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}