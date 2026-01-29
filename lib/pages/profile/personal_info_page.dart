import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    final age = currentUser?['age'] ?? 'N/A';
    final weight = currentUser?['weight'] ?? 'N/A';
    final height = currentUser?['height'] ?? 'N/A';
    final gender = currentUser?['gender'] ?? 'N/A';

    return Scaffold(
      appBar: customAppBarr(
          'Personal Information', primaryColor, getBackgroundColor()),
      backgroundColor: getBackgroundColor(),
      body: Column(
        children: [
          const SizedBox(height: 32),
          _buildProfileCard(context, [
            _buildInfoTile(
                'Username', currentUser?['username'] ?? 'N/A', Icons.person),
            const Divider(),
            _buildInfoTile(
                'Email', currentUser?['email'] ?? 'N/A', Icons.email),
            const Divider(),
            _buildInfoTile('Age', '$age years', Icons.cake),
            const Divider(),
            _buildInfoTile('Height', '$height cm', Icons.height),
            const Divider(),
            _buildInfoTile('Weight', '$weight kg', Icons.monitor_weight),
            const Divider(),
            _buildInfoTile('Gender', '$gender', Icons.wc),
            // REMOVED: Waist tile
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(color: getTextColor())),
      trailing: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, color: getTextColor()),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: getCardColor(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode()
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
