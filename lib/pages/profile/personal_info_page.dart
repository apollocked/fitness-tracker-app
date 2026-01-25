import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/utils/user_data.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final age = currentUser?['age'] ?? 'N/A';
    final waist = currentUser?['waist'] ?? 'N/A';
    final weight = currentUser?['weight'] ?? 'N/A';
    final height = currentUser?['height'] ?? 'N/A';
    final gender = currentUser?['gender'] ?? 'N/A';
    return Scaffold(
        appBar:
            customAppBarr('Personal Information', Colors.blue, Colors.white),
        body: // Personal Information Card
            Column(children: [
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
            _buildInfoTile('Waist', '$waist cm', Icons.straighten),
            const Divider(),
            _buildInfoTile('Gender', gender, Icons.wc),
          ]),
        ]));
  }
}

Widget _buildInfoTile(String title, String value, IconData icon) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(title),
    trailing: Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
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
