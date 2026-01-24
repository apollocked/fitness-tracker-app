import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        'Profile',
        primaryColor,
        backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 60, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _buildProfileCard(
              context,
              [
                _buildListTile(
                  Icons.person,
                  'Personal Info',
                  'Edit your details',
                  () {},
                ),
                _buildListTile(
                  Icons.flag,
                  'Goals',
                  'Set your fitness goals',
                  () {},
                ),
                _buildListTile(
                  Icons.notifications,
                  'Reminders',
                  'Manage notifications',
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              context,
              [
                _buildListTile(
                  Icons.help_outline,
                  'Help & Support',
                  'Get assistance',
                  () {},
                ),
                _buildListTile(
                  Icons.info_outline,
                  'About',
                  'App information',
                  () {},
                ),
              ],
            ),
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
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
