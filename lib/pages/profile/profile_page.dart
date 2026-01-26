import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Profile/about_page.dart';
import 'package:myapp/pages/Profile/help_support_page.dart';
import 'package:myapp/pages/Profile/logout_dialog.dart';
import 'package:myapp/pages/Profile/personal_info_page.dart';
import 'package:myapp/pages/Profile/settings_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: customAppBarr('Profile', primaryColor, backgroundColor),
        body: const Center(child: Text('No user logged in')),
      );
    }

    return Scaffold(
      appBar: customAppBarr('Profile', primaryColor, backgroundColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: primaryColor,
              child: Icon(Icons.person, size: 60, color: backgroundColor),
            ),
            const SizedBox(height: 10),
            Text(
              currentUser?['username'] ?? 'User Profile',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              currentUser?['email'] ?? 'Email',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            _buildProfileCard(context, [
              _buildListTile(Icons.person, 'Personal Info', 'View your info',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalInfoPage()));
              }),
              _buildListTile(
                  Icons.flag, 'Goals', 'Set your fitness goals', () {}),
              _buildListTile(Icons.notifications, 'Reminders',
                  'Manage notifications', () {}),
            ]),
            const SizedBox(height: 5),
            _buildProfileCard(context, [
              _buildListTile(Icons.settings, 'Settings', 'App preferences', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }),
              _buildListTile(
                  Icons.help_outline, 'Help & Support', 'Get assistance', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpAndSupportPage()));
              }),
              _buildListTile(Icons.info_outline, 'About', 'App information',
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              }),
            ]),
            const SizedBox(height: 5),
            _buildProfileCard(context, [
              _buildListTile(
                  Icons.logout, 'Logout', 'Sign out from your account', () {
                LogoutDialog.show(context);
              }, isLogout: true),
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.blue),
      title: Text(title,
          style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
