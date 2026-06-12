import 'package:flutter/material.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/presentation/widgets/onboarding/onboarding_slide.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    OnboardingSlideData(gradient: primaryGradient, icon: Icons.fitness_center_rounded, tag: 'WELCOME',
        title: 'Your Personal\nFitness Tracker',
        subtitle: 'Track workouts, monitor progress, and reach your fitness goals — all in one beautifully designed app.'),
    OnboardingSlideData(gradient: greenGradient, icon: Icons.show_chart_rounded, tag: 'PROGRESS',
        title: 'Watch Your\nProgress Soar',
        subtitle: 'Log daily weight measurements and visualize your transformation over time with elegant charts.'),
    OnboardingSlideData(gradient: orangeGradient, icon: Icons.flag_rounded, tag: 'GOALS',
        title: 'Set Goals,\nStay Motivated',
        subtitle: 'Define weight, protein, and calorie targets. Track completion and celebrate every milestone.'),
    OnboardingSlideData(gradient: purpleGradient, icon: Icons.calculate_rounded, tag: 'CALCULATORS',
        title: 'Smart Fitness\nCalculators',
        subtitle: 'Ideal body weight, daily calories, protein intake — science-backed tools right at your fingertips.'),
    OnboardingSlideData(gradient: lightBlueGradient, icon: Icons.person_rounded, tag: 'PERSONALIZED',
        title: 'Tailored Just\nFor You',
        subtitle: 'Guest or registered — start instantly. Create a profile anytime to save your data forever.'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await HiveStorageService.setOnboardingSeen();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentPage];
    final isGold = slide.gradient == primaryGradient;
    final textColor = isGold ? blackColor : Colors.white;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: slide.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _currentPage < _slides.length - 1
                    ? TextButton(
                        onPressed: _finish,
                        child: Text('Skip', style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 15, fontWeight: FontWeight.w600)))
                    : const SizedBox(width: 70),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => OnboardingSlide(data: _slides[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (i) {
                    final isActive = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 28 : 8, height: 8,
                      decoration: BoxDecoration(
                        color: isActive ? textColor : textColor.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGold ? blackColor : Colors.white,
                      foregroundColor: isGold ? primaryColor : slide.gradient[0],
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _next,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_currentPage == _slides.length - 1 ? 'Get Started' : 'Continue',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        Icon(_currentPage == _slides.length - 1 ? Icons.rocket_launch_rounded : Icons.arrow_forward_rounded, size: 20),
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
