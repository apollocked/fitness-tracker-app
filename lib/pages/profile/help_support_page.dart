// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/support_contact_widget.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  int _expandedFAQIndex = -1;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _faqSectionKey = GlobalKey();
  final GlobalKey _troubleshootSectionKey = GlobalKey();
  final GlobalKey _tipsSectionKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarr('Help & Support', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Help & Support',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: getTextColor()),
            ),
            const SizedBox(height: 8),
            Text(
              'Find answers to common questions and learn how to use the app',
              style: TextStyle(color: getSubtitleColor()),
            ),
            const SizedBox(height: 28),

            // Quick Navigation
            _buildQuickNavigation(),
            const SizedBox(height: 28),

            // FAQs Section
            Container(
              key: _faqSectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Frequently Asked Questions'),
                  const SizedBox(height: 12),
                  _buildFAQSection(),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Troubleshooting Section
            Container(
              key: _troubleshootSectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Troubleshooting'),
                  const SizedBox(height: 12),
                  _buildTroubleshootingSection(),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Tips & Tricks Section
            Container(
              key: _tipsSectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Tips & Tricks'),
                  const SizedBox(height: 12),
                  _buildTipsSection(),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Contact Support
            _buildSectionTitle('Still Need Help?'),
            const SizedBox(height: 12),
            const SupportContactWidget(
              email: 'support@fitnessapp.com',
              title: 'Contact Us',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Navigation',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: getTextColor()),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickNavButton('📋 Features', () {
                Navigator.pushNamed(context, '/features');
              }),
              _buildQuickNavButton('❓ FAQs', () {
                _scrollToSection(_faqSectionKey);
              }),
              _buildQuickNavButton('🔧 Troubleshoot', () {
                _scrollToSection(_troubleshootSectionKey);
              }),
              _buildQuickNavButton('💡 Tips', () {
                _scrollToSection(_tipsSectionKey);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickNavButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: getCardColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: getTextColor(),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: getTextColor()),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      {
        'question': 'How do I update my weight?',
        'answer':
            'Go to the Home page > Click "Update Weight" card > Enter your current weight > Save. Your weight goal progress will update automatically.',
      },
      {
        'question': 'Can I edit my fitness goals?',
        'answer':
            'Yes! Go to Profile > My Goals > Click the Edit button on any goal > Modify the target or current values > Save changes.',
      },
      {
        'question': 'How do I enable Dark Mode?',
        'answer':
            'Go to Profile > Settings > Find "Dark Mode" under Appearance section > Toggle the switch. The app will change theme immediately.',
      },
      {
        'question': 'What calculators does the app have?',
        'answer':
            'The app includes: Daily Calorie Calculator, Ideal Body Weight Calculator, and Protein Intake Calculator. All are accessible from the Home page.',
      },
      {
        'question': 'How often should I update my measurements?',
        'answer':
            'We recommend updating your measurements once a week (same day/time) for the most accurate progress tracking.',
      },
      {
        'question': 'Are my personal details safe?',
        'answer':
            'Yes, all your data is stored locally on your device. We do not share your information with third parties.',
      },
      {
        'question': 'Can I change my password?',
        'answer':
            'Yes! Go to Profile > Settings > Account section > Click "Change Password" > Enter your old and new password > Save.',
      },
      {
        'question': 'What is the difference between goal types?',
        'answer':
            'Lose: Target weight is lower than current. Gain: Target is higher. Maintain: Target equals current. Progress is calculated accordingly.',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        final isExpanded = _expandedFAQIndex == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: getCardColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpanded ? primaryColor : Colors.grey.withOpacity(0.2),
              width: isExpanded ? 2 : 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              onExpansionChanged: (expanded) {
                setState(() {
                  _expandedFAQIndex = expanded ? index : -1;
                });
              },
              title: Text(
                faq['question'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: getTextColor(),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faq['answer'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: getSubtitleColor(),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTroubleshootingSection() {
    final issues = [
      {
        'issue': 'App crashes on startup',
        'solutions': [
          'Clear app cache (Settings > Apps > Fitness > Clear Cache)',
          'Force close the app and restart it',
          'Restart your phone',
          'Reinstall the app if problem persists',
        ],
      },
      {
        'issue': 'Goals not updating after entering measurements',
        'solutions': [
          'Check your internet connection',
          'Refresh the app (swipe down on Progress page)',
          'Log out and log back in',
          'Ensure you have enough storage space',
        ],
      },
      {
        'issue': 'Dark Mode toggle not working',
        'solutions': [
          'Go to Settings and toggle Dark Mode off then on',
          'Restart the app',
          'Clear app cache and restart',
          'Check if your phone is in system dark mode',
        ],
      },
      {
        'issue': 'Measurements not saving',
        'solutions': [
          'Make sure all fields are filled correctly',
          'Check that weight value is a valid number',
          'Ensure you have internet connection',
          'Try updating again after a few seconds',
        ],
      },
      {
        'issue': 'Calculator showing unexpected results',
        'solutions': [
          'Verify that all input values are correct',
          'Check that you selected the right gender/activity level',
          'Ensure height is in centimeters and weight in kilograms',
          'Try the calculator again with verified inputs',
        ],
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: issues.length,
      itemBuilder: (context, index) {
        final issue = issues[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: getCardColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber,
                      size: 18, color: Colors.orange[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      issue['issue'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: getTextColor(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Solutions:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: getSubtitleColor(),
                ),
              ),
              const SizedBox(height: 8),
              ...(issue['solutions'] as List<String>)
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key + 1}. ',
                            style: TextStyle(
                              fontSize: 12,
                              color: getSubtitleColor(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                fontSize: 12,
                                color: getSubtitleColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTipsSection() {
    final tips = [
      {
        'icon': '🎯',
        'title': 'Set Realistic Goals',
        'description':
            'Aim for 0.5-1 kg weight loss/gain per week for sustainable results.',
      },
      {
        'icon': '📊',
        'title': 'Consistent Updates',
        'description':
            'Update measurements on the same day each week for accurate tracking.',
      },
      {
        'icon': '🧮',
        'title': 'Use All Calculators',
        'description':
            'Use Calorie, Protein, and Ideal Weight calculators for a complete fitness plan.',
      },
      {
        'icon': '🌙',
        'title': 'Dark Mode at Night',
        'description':
            'Enable Dark Mode during evening use to reduce eye strain and save battery.',
      },
      {
        'icon': '🔔',
        'title': 'Enable Notifications',
        'description':
            'Turn on notifications in Settings to stay reminded about your goals.',
      },
      {
        'icon': '💪',
        'title': 'Track Bodybuilder Status',
        'description':
            'Update your bodybuilder status in Profile for accurate protein calculations.',
      },
      {
        'icon': '📈',
        'title': 'Monitor Progress',
        'description':
            'Check your Progress page weekly to visualize your fitness journey.',
      },
      {
        'icon': '⚖️',
        'title': 'Balance Your Diet',
        'description':
            'Use calorie and protein goals together for balanced nutrition.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return Container(
          decoration: BoxDecoration(
            color: getCardColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: greenColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: isDarkMode()
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tip['icon'] as String,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                tip['title'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: getTextColor(),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                tip['description'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: getSubtitleColor(),
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
