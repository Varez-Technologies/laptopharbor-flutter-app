import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/reviews_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> users = [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "role": "Admin",
        "status": "Active",
        "orders": "128",
      },
      {
        "name": "Jane Smith",
        "email": "jane@example.com",
        "role": "Customer",
        "status": "Active",
        "orders": "64",
      },
      {
        "name": "Mike Brown",
        "email": "mike@example.com",
        "role": "Seller",
        "status": "Inactive",
        "orders": "32",
      },
      {
        "name": "Sarah Khan",
        "email": "sarah@example.com",
        "role": "Customer",
        "status": "Active",
        "orders": "87",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Users",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        children: [
          // Top Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xff2D0C8B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),

            child: Column(
              children: [
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: topCard(
                        "Total Users",
                        "12.5K",
                        Icons.people_outline,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: topCard(
                        "Active",
                        "11.2K",
                        Icons.verified_user_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Search Box
                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Search users...",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // User List
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18),

              itemCount: users.length,

              itemBuilder: (context, index) {
                final user = users[index];

                return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewsScreen(
          
        ),
      ),
    );
  },

  child: Container(

                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Colors.deepPurple.withOpacity(0.1),

                        child: Text(
                          user["name"][0],
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              user["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              user["email"],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                infoChip(
                                  user["role"],
                                  Icons.work_outline,
                                  Colors.blue,
                                ),

                                const SizedBox(width: 8),

                                infoChip(
                                  "${user["orders"]} Orders",
                                  Icons.shopping_bag_outlined,
                                  Colors.orange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Status
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,

                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: user["status"] == "Active"
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),

                              borderRadius:
                                  BorderRadius.circular(30),
                            ),

                            child: Text(
                              user["status"],
                              style: TextStyle(
                                color:
                                    user["status"] == "Active"
                                        ? Colors.green
                                        : Colors.red,

                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Top Cards
  Widget topCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // Info Chip
  Widget infoChip(
    String text,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14,
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}