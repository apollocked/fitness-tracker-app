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
    final l10n = AppLocalizations.of(context)!;
    if (value) {
      final accepted = await showNotificationRationale(context);
      if (!accepted || !context.mounted) return;
    }

    final appVM = context.read<AppViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final success = await appVM.setNotifications(value);
    if (!context.mounted) return;

    if (!success && value && appVM.errorCode == 'notificationBlocked') {
      await showAppSettingsRedirect(context);
      if (!context.mounted) return;
      final retry = await appVM.setNotifications(value);
      if (retry && context.mounted) {
        await context.read<AuthViewModel>().reloadUser();
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.settingsNotificationsEnabled),
            backgroundColor: greenColor,
          ),
        );
        return;
      }
    }

    await context.read<AuthViewModel>().reloadUser();
    final snackMsg = appVM.errorCode != null
        ? _errorMessage(appVM.errorCode!, l10n)
        : (success ? l10n.settingsNotificationsEnabled : l10n.settingsUpdated);
    if (appVM.errorCode == 'notificationsDisabled') {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.settingsNotificationsEnabled),
          backgroundColor: greenColor,
        ),
      );
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(snackMsg),
        backgroundColor: success ? greenColor : redColor,
      ),
    );
    if (!success) {
      appVM.clearMessages();
    }
  }

  String _errorMessage(String code, AppLocalizations l10n) {
    switch (code) {
      case 'notificationBlocked':
        return l10n.errorNotificationBlocked;
      case 'notificationDenied':
        return l10n.errorNotificationDenied;
      case 'notificationSchedule':
        return l10n.errorNotificationSchedule;
      case 'notificationUpdate':
        return l10n.errorNotificationUpdate;
      case 'noUserLoggedIn':
        return l10n.errorNoUserLoggedIn;
      case 'profileUpdate':
        return l10n.errorProfileUpdate;
      case 'usernameTaken':
        return l10n.errorUsernameTaken;
      case 'profileUpdated':
        return l10n.successProfileUpdated;
      default:
        return l10n.settingsUpdated;
    }
  }

  String _languageLabel(String code, AppLocalizations l10n) {
    switch (code) {
      case 'ckb':
        return l10n.settingsLanguageNativeCkb;
      case 'ar':
        return l10n.settingsLanguageNativeAr;
      case 'es':
        return l10n.settingsLanguageNativeEs;
      default:
        return l10n.settingsLanguageNativeEn;
    }
  }

  void _showLanguagePicker(BuildContext context) {
    final appVM = context.read<AppViewModel>();
    final l10n = AppLocalizations.of(context)!;
    final current = appVM.localeCode;
    final options = ['en', 'ckb', 'ar', 'es'];
    final labels = {
      'en': l10n.settingsLanguageNativeEn,
      'ckb': l10n.settingsLanguageNativeCkb,
      'ar': l10n.settingsLanguageNativeAr,
      'es': l10n.settingsLanguageNativeEs,
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
                _languageLabel(appVM.localeCode, l10n),
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
