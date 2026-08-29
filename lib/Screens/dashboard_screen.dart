import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/notification_screen.dart';
import 'package:laptopharbor01/Screens/settings_screen.dart';
import 'products_screen.dart';
import 'orders_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final String adminName;

  const AdminDashboardScreen({super.key, required this.adminName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductManagementScreen(),
              ),
            );
          }

          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UsersScreen()),
            );
          }

          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Users",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
      ),
      body: Column(
        children: [
          // Top Purple Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 55,
              left: 18,
              right: 18,
              bottom: 25,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff2D0C8B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.menu, color: Colors.white),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "LaptopHarbor",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Welcome, $adminName",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen(),
                              ),
                            );
                          },

                          child: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 18),
                          SizedBox(width: 10),
                          Text(
                            "01 May - 20 May 2024",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: dashboardCard(
                          title: "Total Orders",
                          value: "1,245",
                          percent: "12.5%",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: dashboardCard(
                          title: "Total Users",
                          value: "3,456",
                          percent: "8.2%",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: dashboardCard(
                          title: "Total Products",
                          value: "512",
                          percent: "5.4%",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: dashboardCard(
                          title: "Total Revenue",
                          value: "₹25,68,000",
                          percent: "15.3%",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Sales Overview
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sales Overview",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          height: 180,
                          child: CustomPaint(
                            painter: LineChartPainter(),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Top Selling Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1496181133206-80ce9b88a853",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            "Dell XPS 13",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const Text(
                          "1250 Units",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboardCard({
    required String title,
    required String value,
    required String percent,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.arrow_upward, color: Colors.green, size: 16),
              const SizedBox(width: 4),
              Text(
                percent,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          const Text(
            "vs last month",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// Custom Chart Painter
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Path path = Path();

    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.15, size.height * 0.6);
    path.lineTo(size.width * 0.35, size.height * 0.45);
    path.lineTo(size.width * 0.55, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height * 0.25);
    path.lineTo(size.width * 0.85, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.1);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
