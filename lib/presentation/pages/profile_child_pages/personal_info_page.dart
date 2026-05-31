import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_tracker/presentation/widgets/shared/custom_appbar.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/logic/porviders/auth_viewmodel.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().currentUser;
    final theme = Theme.of(context);
    if (user == null) {
      return Scaffold(
        appBar: customAppBarr('Personal Information', primaryColor,
            theme.scaffoldBackgroundColor),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const Center(child: Text('No user data')),
      );
    }
    return Scaffold(
      appBar: customAppBarr(
          'Personal Information', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 32),
          _buildProfileCard(context, [
            _buildInfoTile(context, 'Username', user.username, Icons.person),
            const Divider(),
            _buildInfoTile(context, 'Email', user.email, Icons.email),
            const Divider(),
            _buildInfoTile(context, 'Age', '${user.age} years', Icons.cake),
            const Divider(),
            _buildInfoTile(
                context, 'Height', '${user.height} cm', Icons.height),
            const Divider(),
            _buildInfoTile(
                context, 'Weight', '${user.weight} kg', Icons.monitor_weight),
            const Divider(),
            _buildInfoTile(context, 'Gender', user.gender, Icons.wc),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
      BuildContext context, String title, String value, IconData icon) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(color: colors.textColor)),
      trailing: Text(value,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: colors.textColor)),
    );
  }

  Widget _buildProfileCard(BuildContext context, List<Widget> children) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5),
        ],
      ),
      child: Column(children: children),
    );
  }
}
