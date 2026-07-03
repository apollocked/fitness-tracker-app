import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';
import 'package:fit_tracker/presentation/pages/home_page.dart';
import 'package:fit_tracker/presentation/pages/progress_page.dart';
import 'package:fit_tracker/presentation/pages/profile_page.dart';
import 'package:fit_tracker/presentation/pages/calculators/add_measurement_page.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/logic/progress_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/guest_banner.dart';
import 'package:fit_tracker/presentation/widgets/shared/dock_nav_bar.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  void _showExitDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.exitTitle),
        content: Text(l10n.exitMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.exitStay,
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
            child: Text(l10n.exitConfirm,
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
                      child: DockNavBar(
                        currentIndex: appVM.currentIndex,
                        onTap: (i, wasOnProgress) async {
                          if (wasOnProgress) {
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
