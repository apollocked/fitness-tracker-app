import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/app_theme.dart';
import 'package:myapp/utils/user_data.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final age = currentUser?['age'] ?? 'N/A';
    final weight = currentUser?['weight'] ?? 'N/A';
    final height = currentUser?['height'] ?? 'N/A';
    final gender = currentUser?['gender'] ?? 'N/A';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: customAppBarr(
          'Personal Information', primaryColor, theme.scaffoldBackgroundColor),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 32),
          _buildProfileCard(context, [
            _buildInfoTile(context, 
                'Username', currentUser?['username'] ?? 'N/A', Icons.person),
            const Divider(),
            _buildInfoTile(context, 
                'Email', currentUser?['email'] ?? 'N/A', Icons.email),
            const Divider(),
            _buildInfoTile(context, 'Age', '$age years', Icons.cake),
            const Divider(),
            _buildInfoTile(context, 'Height', '$height cm', Icons.height),
            const Divider(),
            _buildInfoTile(context, 'Weight', '$weight kg', Icons.monitor_weight),
            const Divider(),
            _buildInfoTile(context, 'Gender', '$gender', Icons.wc),
            // REMOVED: Waist tile
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String title, String value, IconData icon) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(color: colors.textColor)),
      trailing: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, color: colors.textColor),
      ),
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
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
