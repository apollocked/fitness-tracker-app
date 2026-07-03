import 'package:fit_tracker/presentation/widgets/profile/delete_account_dialog.dart';
import 'package:fit_tracker/presentation/widgets/profile/edit_profile_dialog.dart';
import 'package:flutter/material.dart';

export 'delete_account_dialog.dart';
export 'edit_profile_dialog.dart';

class SettingsDialogs {
  static void showEditProfileDialog(BuildContext context, Function onSave) =>
      EditProfileDialog.show(context, onSave);

  static void showDeleteAccountDialog(BuildContext context) =>
      DeleteAccountDialog.show(context);
}
