import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/presentation/widgets/profile/settings_dialogs.dart';
import 'package:fit_tracker/presentation/widgets/profile/settings_section_widget.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/data/services/notification_service.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _onDarkModeChanged(BuildContext context, bool value) async {
    final appVM = context.read<AppViewModel>();
    final authVM = context.read<AuthViewModel>();
    await appVM.setDarkMode(value);
    await authVM.reloadUser();
  }

  Future<void> _onNotificationsChanged(BuildContext context, bool value) async {
    if (value) {
      final accepted = await showNotificationRationale(context);
      if (!accepted || !context.mounted) return;
    }

    final appVM = context.read<AppViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final success = await appVM.setNotifications(value);
    if (!context.mounted) return;

    if (!success &&
        value &&
        appVM.settingsError == 'Notification permission is blocked.') {
      await showAppSettingsRedirect(context);
      if (!context.mounted) return;
      final retry = await appVM.setNotifications(value);
      if (retry && context.mounted) {
        await context.read<AuthViewModel>().reloadUser();
        messenger.showSnackBar(
          SnackBar(
            content: Text(appVM.successMessage ?? 'Notifications enabled.'),
            backgroundColor: greenColor,
          ),
        );
        return;
      }
    }

    await context.read<AuthViewModel>().reloadUser();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          appVM.successMessage ?? appVM.settingsError ?? 'Settings updated.',
        ),
        backgroundColor: success ? greenColor : redColor,
      ),
    );
    if (!success) {
      appVM.clearMessages();
    }
  }

  String _languageLabel(String code) {
    switch (code) {
      case 'ckb':
        return 'کوردی (سۆرانی)';
      case 'ar':
        return 'العربية';
      case 'es':
        return 'Español';
      default:
        return 'English';
    }
  }

  void _showLanguagePicker(BuildContext context) {
    final appVM = context.read<AppViewModel>();
    final l10n = AppLocalizations.of(context)!;
    final current = appVM.localeCode;
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
        title: Text(l10n.settingsLanguage),
        children: options.map((code) {
          return RadioListTile<String>(
            title: Text(labels[code]!),
            value: code,
            groupValue: current,
            onChanged: (v) {
              if (v != null && v != current) {
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
    final appVM = context.watch<AppViewModel>();
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBarr(
          l10n.settingsTitle, primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildSectionTitle(context, l10n.settingsProfile),
          buildCardSection(context, [
            buildListTile(
                context,
                Icons.edit_outlined,
                l10n.settingsEditProfile,
                l10n.settingsEditProfileSub,
                () => SettingsDialogs.showEditProfileDialog(context, () {})),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, l10n.settingsNotifications),
          buildCardSection(context, [
            buildSwitchTile(
                context,
                Icons.notifications_outlined,
                l10n.settingsReminders,
                l10n.settingsReminderDesc,
                appVM.notificationsEnabled,
                appVM.settingsLoading
                    ? (_) {}
                    : (v) => _onNotificationsChanged(context, v)),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, l10n.settingsAppearance),
          buildCardSection(context, [
            buildSwitchTile(
                context,
                Icons.dark_mode_outlined,
                l10n.settingsDark,
                l10n.settingsToggleTheme,
                appVM.isDarkMode,
                (v) => _onDarkModeChanged(context, v)),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.language_outlined,
                l10n.settingsLanguage,
                _languageLabel(appVM.localeCode),
                () => _showLanguagePicker(context)),
          ]),
          const SizedBox(height: 20),
          buildSectionTitle(context, l10n.settingsMore),
          buildCardSection(context, [
            buildListTile(
                context,
                Icons.privacy_tip_outlined,
                l10n.profilePrivacyPolicy,
                l10n.settingsPrivacyPolicySub,
                () => Navigator.pushNamed(context, '/privacy-policy')),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.description_outlined,
                l10n.profileTermsConditions,
                l10n.settingsTermsSub,
                () => Navigator.pushNamed(context, '/terms-conditions')),
            const Divider(height: 1, indent: 56),
            buildListTile(
                context,
                Icons.delete_forever_outlined,
                l10n.settingsDeleteAccount,
                l10n.settingsDeleteAccountSub,
                () => SettingsDialogs.showDeleteAccountDialog(context),
                isDanger: true),
          ]),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
