import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_dialog_text_field.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/auth_viewmodel.dart';
import 'package:fit_tracker/logic/app_viewmodel.dart';
import 'package:fit_tracker/l10n/app_localizations.dart';

String settingsErrorMsg(
    AppLocalizations l10n, String? errorCode, String fallback) {
  switch (errorCode) {
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
    case 'usernameTaken':
      return l10n.errorUsernameTaken;
    case 'profileUpdate':
      return l10n.errorProfileUpdate;
    case 'profileUpdated':
      return l10n.successProfileUpdated;
    default:
      return fallback;
  }
}

class EditProfileDialog {
  static void show(BuildContext context, Function onSave) {
    final user = context.read<AuthViewModel>().currentUser;
    if (user == null) return;
    final usernameController = TextEditingController(text: user.username);
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.cardColor,
        title: Text(l10n.settingsEditProfile,
            style: TextStyle(color: colors.textColor)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDialogTextField(
                controller: usernameController, text: l10n.profileUsername),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.commonCancel)),
          TextButton(
            onPressed: () async {
              if (usernameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(l10n.settingsPleaseFillFields),
                    backgroundColor: redColor));
                return;
              }
              final appVM = dialogContext.read<AppViewModel>();
              final success =
                  await appVM.updateProfile(usernameController.text, l10n);
              if (success) {
                await context.read<AuthViewModel>().reloadUser();
                onSave();
                Navigator.pop(dialogContext);
              }
              final msg = appVM.errorCode != null
                  ? settingsErrorMsg(l10n, appVM.errorCode, l10n.commonDone)
                  : l10n.commonDone;
              final isSuccess = appVM.errorCode == 'profileUpdated';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: isSuccess ? greenColor : redColor,
                ),
              );
            },
            child: Text(l10n.settingsUpdateButton),
          ),
        ],
      ),
    );
  }
}
