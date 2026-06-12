import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class OnboardingSlide extends StatefulWidget {
  final OnboardingSlideData data;
  const OnboardingSlide({super.key, required this.data});
  @override
  State<OnboardingSlide> createState() => _OnboardingSlideState();
}

class _OnboardingSlideState extends State<OnboardingSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
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
    final s = widget.data;
    final isGold = s.gradient == primaryGradient;
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
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 140, height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textColor.withOpacity(isGold ? 0.08 : 0.15),
                    border: Border.all(color: textColor.withOpacity(isGold ? 0.15 : 0.3), width: 2),
                    boxShadow: [BoxShadow(color: blackColor.withOpacity(0.15), blurRadius: 40, spreadRadius: 10)],
                  ),
                  child: Icon(s.icon, size: 68, color: textColor),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(isGold ? 0.1 : 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: textColor.withOpacity(isGold ? 0.2 : 0.3), width: 1),
                ),
                child: Text(s.tag, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2)),
              ),
              const SizedBox(height: 20),
              Text(s.title, textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontSize: 32, fontWeight: FontWeight.w800, height: 1.15, letterSpacing: -0.5)),
              const SizedBox(height: 16),
              Text(s.subtitle, textAlign: TextAlign.center,
                  style: TextStyle(color: textColor.withOpacity(0.85), fontSize: 15, fontWeight: FontWeight.w500, height: 1.55)),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingSlideData {
  final List<Color> gradient;
  final IconData icon;
  final String tag;
  final String title;
  final String subtitle;
  const OnboardingSlideData({
    required this.gradient, required this.icon,
    required this.tag, required this.title, required this.subtitle,
  });
}
