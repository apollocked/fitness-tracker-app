import 'package:flutter/material.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

typedef NavTapCallback = void Function(int index, bool wasOnProgress);

class DockNavBar extends StatelessWidget {
  final int currentIndex;
  final NavTapCallback onTap;
  const DockNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / 3;
        final onProgress = currentIndex == 1;
        final isRtl = Directionality.of(context) == TextDirection.rtl;
        final indicatorLeft =
            6 + (isRtl ? 2 - currentIndex : currentIndex) * itemWidth;
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              left: indicatorLeft,
              top: 6,
              width: itemWidth - 12,
              height: 56,
              child: AnimatedOpacity(
                opacity: onProgress ? 0.0 : 1.0,
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
              left: 6 + itemWidth,
              top: onProgress ? 4 : 80,
              width: itemWidth - 12,
              height: 60,
              child: AnimatedOpacity(
                opacity: onProgress ? 1.0 : 0.0,
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
                _dockItem(0, Icons.home_rounded, l10n.navHome, primaryColor,
                    colors.subtitleColor, itemWidth, context),
                _dockItem(
                    1,
                    onProgress ? Icons.add_rounded : Icons.show_chart_rounded,
                    onProgress ? l10n.navAddMeasurement : l10n.navProgress,
                    onProgress ? Colors.white : primaryColor,
                    colors.subtitleColor,
                    itemWidth,
                    context),
                _dockItem(2, Icons.person_rounded, l10n.navProfile,
                    primaryColor, colors.subtitleColor, itemWidth, context),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _dockItem(int index, IconData icon, String label, Color activeColor,
      Color inactiveColor, double width, BuildContext context) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index, currentIndex == 1 && index == 1),
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
