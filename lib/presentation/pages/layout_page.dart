import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/pages/home_page.dart';
import 'package:fit_tracker/presentation/pages/progress_page.dart';
import 'package:fit_tracker/presentation/pages/profile_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/guest_banner.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: TextStyle(
                    color: Theme.of(context)
                        .extension<AppColorsExtension>()!
                        .subtitleColor)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              SystemNavigator.pop();
            },
            child: const Text('Exit',
                style: TextStyle(
                    color: primaryColor, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appVM = context.watch<AppViewModel>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _showExitDialog(context);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            SafeArea(
                top: true,
                bottom: false,
                child: Column(children: [
                  const GuestBanner(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 58),
                      child: IndexedStack(
                        index: appVM.currentIndex,
                        children: const [
                          HomePage(),
                          ProgressPage(),
                          ProfilePage(),
                        ],
                      ),
                    ),
                  )
                ])),
            Positioned(
              left: 20,
              right: 20,
              bottom: bottomInset + 8,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadowColor,
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.cardColor.withOpacity(0.75),
                        border: Border.all(
                          color: (isDark ? Colors.white : blackColor)
                              .withOpacity(0.08),
                        ),
                      ),
                      child: _DockNavBar(
                        currentIndex: appVM.currentIndex,
                        onTap: (i) async {
                          if (i == 1 && appVM.currentIndex == 1) {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddMeasurementPage()),
                            );
                            if (result == true && context.mounted) {
                              context
                                  .read<ProgressViewModel>()
                                  .loadMeasurements();
                            }
                          } else {
                            appVM.setIndex(i);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DockNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _DockNavBar({required this.currentIndex, required this.onTap});
  @override
  State<_DockNavBar> createState() => _DockNavBarState();
}

class _DockNavBarState extends State<_DockNavBar> {
  bool _showAdd = false;

  @override
  void didUpdateWidget(_DockNavBar old) {
    super.didUpdateWidget(old);
    if (widget.currentIndex != old.currentIndex) {
      setState(() => _showAdd = widget.currentIndex == 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / 3;
        final showPlus = _showAdd && widget.currentIndex == 1;
        final progressIcon = showPlus ? Icons.add_rounded : Icons.show_chart_rounded;
        final progressLabel = showPlus ? 'Add' : 'Progress';
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              left: 6 + widget.currentIndex * itemWidth,
              top: 6,
              width: itemWidth - 12,
              height: 56,
              child: AnimatedOpacity(
                opacity: widget.currentIndex == 1 ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              left: 6 + 1 * itemWidth,
              top: widget.currentIndex == 1 ? 4 : 80,
              width: itemWidth - 12,
              height: 60,
              child: AnimatedOpacity(
                opacity: widget.currentIndex == 1 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _dockItem(0, Icons.home_rounded, 'Home', primaryColor,
                    colors.subtitleColor, itemWidth),
                _animatedDockItem(1, showPlus, progressIcon, progressLabel,
                    Colors.white, colors.subtitleColor, itemWidth),
                _dockItem(2, Icons.person_rounded, 'Profile', primaryColor,
                    colors.subtitleColor, itemWidth),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _animatedDockItem(int index, bool showAdd, IconData icon, String label,
      Color activeColor, Color inactiveColor, double width) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (child, anim) => RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
              child: Icon(
                key: ValueKey('progress_${showAdd ? 'add' : 'chart'}'),
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: isSelected ? 26 : 23,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Text(
                key: ValueKey('label_${showAdd ? 'add' : 'progress'}'),
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dockItem(int index, IconData icon, String label, Color activeColor,
      Color inactiveColor, double width) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: isSelected ? 26 : 23,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? activeColor : inactiveColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
