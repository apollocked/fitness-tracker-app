import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatelessWidget {
  final DateTime currentMonth;
  final bool canGoBack;
  final bool canGoForward;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const MonthSelector({
    super.key,
    required this.currentMonth,
    required this.canGoBack,
    required this.canGoForward,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final monthYear = DateFormat.yMMMM().format(currentMonth);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: canGoBack ? onPrevious : null,
          ),
          Text(monthYear,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: canGoForward ? onNext : null,
          ),
        ],
      ),
    );
  }
}
