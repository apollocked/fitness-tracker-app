import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Calculators/add_measurement_page.dart';
import 'package:myapp/pages/Calculators/daily_calorie_page.dart';
import 'package:myapp/pages/Calculators/ideal_bw_page.dart';
import 'package:myapp/pages/Calculators/protien_intake_page.dart';
import 'package:myapp/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        'Home',
        primaryColor,
        backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your fitness journey',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    context,
                    'Ideal Body Weight',
                    Icons.monitor_weight,
                    Colors.blue,
                    'Calculate',
                    () {
                      // Navigate to IdealBodyWeightPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IdealBodyWeightPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Protein Intake',
                    Icons.restaurant,
                    Colors.orange,
                    'Calculate',
                    () {
                      // Navigate to ProteinIntakePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProtienIntakePage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Measurements',
                    Icons.straighten,
                    greenColor,
                    'Track',
                    () {
                      // Navigate to Add Measurement
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddMeasurementPage(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    'Daily Calorie Needs',
                    Icons.local_fire_department,
                    Colors.red,
                    'Calculate',
                    () {
                      // Navigate to Daily Calorie Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DailyCaloriePage(),
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
