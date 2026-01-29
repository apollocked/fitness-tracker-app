import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Cards/add_measurement_page.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        'Home',
        primaryColor,
        getBackgroundColor(),
      ),
      backgroundColor: getBackgroundColor(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: getTextColor()),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your fitness journey',
              style: TextStyle(fontSize: 16, color: getSubtitleColor()),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // Update each calculator card
                  _buildDashboardCard(
                    context,
                    'Ideal Body Weight',
                    Icons.monitor_weight,
                    blueColor,
                    'Calculate',
                    () {
                      Navigator.pushNamed(context, '/ideal-weight');
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Protein Intake',
                    Icons.restaurant,
                    orangeColor,
                    'Calculate',
                    () {
                      Navigator.pushNamed(context, '/protein-intake');
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Daily Calorie Needs',
                    Icons.local_fire_department,
                    redColor,
                    'Calculate',
                    () {
                      Navigator.pushNamed(context, '/daily-calories');
                    },
                  ),

                  _buildDashboardCard(
                    context,
                    'Update Weight',
                    Icons.straighten,
                    greenColor,
                    'Track Weight',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddMeasurementPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String value,
    VoidCallback onTap,
  ) {
    return Card(
      color: getCardColor(),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: getTextColor()),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
