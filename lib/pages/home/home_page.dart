import 'package:flutter/material.dart';
import 'package:myapp/pages/Ideal_bodyweight_page/ideal_bw_page.dart';
import 'package:myapp/pages/Protien_intake_page/protien_intake_page.dart';
import 'package:myapp/pages/measurements/add_measurement_page.dart';
import 'package:myapp/pages/progress/progress_page.dart';
import 'package:myapp/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const ProgressPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
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
                    Colors.green,
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
                    'BMI',
                    Icons.calculate,
                    Colors.purple,
                    'Calculate',
                    () {
                      // You can add BMI calculator page here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('BMI Calculator - Coming Soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMeasurementPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Measurement'),
        backgroundColor: Colors.blue,
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
