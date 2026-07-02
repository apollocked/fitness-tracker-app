import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/presentation/widgets/onboarding/onboarding_slide.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/l10n/app_localizations.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingSlideData> _slides(AppLocalizations l10n) => [
        OnboardingSlideData(
            gradient: primaryGradient,
            icon: Icons.fitness_center_rounded,
            tag: 'WELCOME',
            title: l10n.appTitle,
            subtitle: l10n.appDescriptionLocal),
        OnboardingSlideData(
            gradient: greenGradient,
            icon: Icons.show_chart_rounded,
            tag: 'PROGRESS',
            title: 'Watch Your\nProgress Soar',
            subtitle:
                'Log daily weight measurements and visualize your transformation over time with elegant charts.'),
        OnboardingSlideData(
            gradient: orangeGradient,
            icon: Icons.flag_rounded,
            tag: 'GOALS',
            title: 'Set Goals,\nStay Motivated',
            subtitle:
                'Define weight, protein, and calorie targets. Track completion and celebrate every milestone.'),
        OnboardingSlideData(
            gradient: purpleGradient,
            icon: Icons.calculate_rounded,
            tag: 'CALCULATORS',
            title: 'Smart Fitness\nCalculators',
            subtitle:
                'Ideal body weight, daily calories, protein intake — science-backed tools right at your fingertips.'),
        OnboardingSlideData(
            gradient: lightBlueGradient,
            icon: Icons.person_rounded,
            tag: 'PERSONALIZED',
            title: 'Tailored Just\nFor You',
            subtitle: l10n.appNoAccountNeeded),
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    final l10n = AppLocalizations.of(context)!;
    if (_currentPage < _slides(l10n).length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await HiveStorageService.setOnboardingSeen();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);
  }

  void _showLanguagePicker() {
    final appVM = context.read<AppViewModel>();
    final options = ['en', 'ckb', 'ar', 'es'];
    final labels = {
      'en': 'English',
      'ckb': 'کوردی (سۆرانی)',
      'ar': 'العربية',
      'es': 'Español',
    };
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(AppLocalizations.of(context)!.settingsLanguage),
        children: options.map((code) {
          final selected = code == appVM.localeCode;
          return RadioListTile<String>(
            title: Text(labels[code]!,
                style: TextStyle(
                    fontWeight:
                        selected ? FontWeight.bold : FontWeight.normal)),
            value: code,
            groupValue: appVM.localeCode,
            onChanged: (v) {
              if (v != null && v != appVM.localeCode) {
                appVM.setLocale(v);
              }
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slide = _slides(l10n)[_currentPage];
    final isGold = slide.gradient == primaryGradient;
    final textColor = isGold ? blackColor : Colors.white;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: slide.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: _showLanguagePicker,
                    icon: Icon(Icons.language_rounded,
                        size: 18, color: textColor.withOpacity(0.7)),
                    label: Text(l10n.settingsLanguage,
                        style: TextStyle(
                            color: textColor.withOpacity(0.7), fontSize: 13)),
                  ),
                  const Spacer(),
                  _currentPage < _slides(l10n).length - 1
                      ? TextButton(
                          onPressed: _finish,
                          child: Text(l10n.commonGotIt,
                              style: TextStyle(
                                  color: textColor.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)))
                      : const SizedBox(width: 70),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides(l10n).length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => OnboardingSlide(data: _slides(l10n)[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides(l10n).length, (i) {
                    final isActive = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            isActive ? textColor : textColor.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGold ? blackColor : Colors.white,
                      foregroundColor:
                          isGold ? primaryColor : slide.gradient[0],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _next,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            _currentPage == _slides(l10n).length - 1
                                ? l10n.commonDone
                                : l10n.commonNext,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        Icon(
                            _currentPage == _slides(l10n).length - 1
                                ? Icons.rocket_launch_rounded
                                : Icons.arrow_forward_rounded,
                            size: 20),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
