import 'package:flutter/material.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';
import 'package:fit_tracker/presentation/pages/auth/login_page.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    _SlideData(
      gradient: primaryGradient,
      icon: Icons.fitness_center_rounded,
      tag: 'WELCOME',
      title: 'Your Personal\nFitness Tracker',
      subtitle:
          'Track workouts, monitor progress, and reach your fitness goals — all in one beautifully designed app.',
    ),
    _SlideData(
      gradient: greenGradient,
      icon: Icons.show_chart_rounded,
      tag: 'PROGRESS',
      title: 'Watch Your\nProgress Soar',
      subtitle:
          'Log daily weight measurements and visualize your transformation over time with elegant charts.',
    ),
    _SlideData(
      gradient: orangeGradient,
      icon: Icons.flag_rounded,
      tag: 'GOALS',
      title: 'Set Goals,\nStay Motivated',
      subtitle:
          'Define weight, protein, and calorie targets. Track completion and celebrate every milestone.',
    ),
    _SlideData(
      gradient: purpleGradient,
      icon: Icons.calculate_rounded,
      tag: 'CALCULATORS',
      title: 'Smart Fitness\nCalculators',
      subtitle:
          'Ideal body weight, daily calories, protein intake — science-backed tools right at your fingertips.',
    ),
    _SlideData(
      gradient: lightBlueGradient,
      icon: Icons.person_rounded,
      tag: 'PERSONALIZED',
      title: 'Tailored Just\nFor You',
      subtitle:
          'Guest or registered — start instantly. Create an account anytime to save your data forever.',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await HiveStorageService.setOnboardingSeen();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
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
          gradient: LinearGradient(
            colors: slide.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _currentPage < _slides.length - 1
                    ? TextButton(
                        onPressed: _finish,
                        child: Text('Skip',
                            style: TextStyle(
                                color: textColor.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      )
                    : const SizedBox(width: 70),
              ),
            ),
            // Page view content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _SlideContent(slide: _slides[i]),
              ),
            ),
            // Bottom controls
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(children: [
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (i) {
                    final isActive = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? textColor
                            : textColor.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                // Next / Get Started button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGold ? blackColor : Colors.white,
                      foregroundColor: isGold ? primaryColor : slide.gradient[0],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _next,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _slides.length - 1
                              ? 'Get Started'
                              : 'Continue',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          _currentPage == _slides.length - 1
                              ? Icons.rocket_launch_rounded
                              : Icons.arrow_forward_rounded,
                          size: 20,
                        ),
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

class _SlideContent extends StatefulWidget {
  final _SlideData slide;
  const _SlideContent({required this.slide});
  @override
  State<_SlideContent> createState() => _SlideContentState();
}

class _SlideContentState extends State<_SlideContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _slideAnim = Tween<Offset>(
            begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGold = widget.slide.gradient == primaryGradient;
    final textColor = isGold ? blackColor : Colors.white;

    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _ctrl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon circle with glow
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textColor.withOpacity(isGold ? 0.08 : 0.15),
                    border: Border.all(
                        color: textColor.withOpacity(isGold ? 0.15 : 0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.15),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(widget.slide.icon,
                      size: 68, color: textColor),
                ),
              ),
              const SizedBox(height: 40),
              // Tag chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(isGold ? 0.1 : 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: textColor.withOpacity(isGold ? 0.2 : 0.3), width: 1),
                ),
                child: Text(
                  widget.slide.tag,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                widget.slide.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                widget.slide.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor.withOpacity(0.85),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideData {
  final List<Color> gradient;
  final IconData icon;
  final String tag;
  final String title;
  final String subtitle;
  const _SlideData({
    required this.gradient,
    required this.icon,
    required this.tag,
    required this.title,
    required this.subtitle,
  });
}
