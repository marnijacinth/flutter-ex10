import 'package:flutter/material.dart';
import 'login_page.dart';

class DashboardPage extends StatelessWidget {
  final String userName;

  const DashboardPage({super.key, required this.userName});

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_circle,
                      size: 80, color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome, $userName!',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'You are successfully logged in to the Product Inventory System.',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 1.2),
                  const SizedBox(height: 12),

                  // 🔹 Future expansion section (for experiments 8–9)
                  const Text(
                    'Available Actions:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _DashboardButton(
                        label: 'Search Products',
                        icon: Icons.search,
                        onPressed: () {
                          // Navigate to product search page (Exercise 8)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Navigate to Product Search Page')),
                          );
                        },
                      ),
                      _DashboardButton(
                        label: 'Update Products',
                        icon: Icons.edit_note,
                        onPressed: () {
                          // Navigate to product update page (Exercise 9)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Navigate to Product Update Page')),
                          );
                        },
                      ),
                      _DashboardButton(
                        label: 'Manage Inventory',
                        icon: Icons.inventory_2_outlined,
                        onPressed: () {
                          // Future: Navigate to inventory dashboard
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Navigate to Inventory Dashboard')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔹 Reusable button widget for dashboard actions
class _DashboardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _DashboardButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        backgroundColor: Colors.indigo.shade400,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
