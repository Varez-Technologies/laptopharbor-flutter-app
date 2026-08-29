import 'package:flutter/material.dart';
import 'coupons_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        children: [
          // Top Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Color(0xff2D0C8B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),

            child: Column(
              children: [
                // Admin Profile
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Laptop Harbor Admin",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Manage your store settings",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // Stats
                Row(
                  children: [
                    Expanded(
                      child: topCard(
                        "Products",
                        "512",
                        Icons.shopping_bag_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: topCard(
                        "Orders",
                        "1.2K",
                        Icons.receipt_long_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: topCard(
                        "Users",
                        "12K",
                        Icons.people_outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Settings Menu
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18),

              children: [
                settingsTile(
                  context,
                  icon: Icons.store_outlined,
                  title: "Store Information",
                  subtitle: "Manage store details",
                  color: Colors.blue,
                ),

                settingsTile(
                  context,
                  icon: Icons.discount_outlined,
                  title: "Coupons",
                  subtitle: "Create & manage discount codes",
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CouponsScreen(),
                      ),
                    );
                  },
                ),

                settingsTile(
                  context,
                  icon: Icons.payment_outlined,
                  title: "Payment Methods",
                  subtitle: "Manage payment gateways",
                  color: Colors.green,
                ),

                settingsTile(
                  context,
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  subtitle: "Update your security password",
                  color: Colors.red,
                ),

                settingsTile(
                  context,
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  subtitle: "Manage app notifications",
                  color: Colors.purple,
                ),

                settingsTile(
                  context,
                  icon: Icons.support_agent_outlined,
                  title: "Support",
                  subtitle: "Help center & customer support",
                  color: Colors.teal,
                ),

                const SizedBox(height: 30),

                // Logout Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: () {},

                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top Card
  Widget topCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Settings Tile
  Widget settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [
            // Icon Box
            Container(
              height: 55,
              width: 55,

              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}