import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: customAppBarr('Profile', primaryColor, backgroundColor),
        body: const Center(child: Text('No user logged in')),
      );
    }

    final user = currentUser!;
    final age = user['age'] ?? 'N/A';
    final weight = user['weight'] ?? 'N/A';
    final height = user['height'] ?? 'N/A';
    final gender = user['gender'] ?? 'N/A';

    return Scaffold(
      appBar: customAppBarr('Profile', primaryColor, backgroundColor),
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
            Text(
              user['username'] ?? 'User Profile',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user['email'] ?? '',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // Personal Information Card
            _buildProfileCard(context, [
              _buildInfoTile('Age', '$age years', Icons.cake),
              const Divider(),
              _buildInfoTile('Weight', '$weight kg', Icons.monitor_weight),
              const Divider(),
              _buildInfoTile('Height', '$height cm', Icons.height),
              const Divider(),
              _buildInfoTile('Gender', gender, Icons.wc),
            ]),
            const SizedBox(height: 16),

            // Settings Card
            _buildProfileCard(context, [
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
            ]),
            const SizedBox(height: 16),

            // Support Card
            _buildProfileCard(context, [
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
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 12),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
