import 'package:flutter/material.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "id": "#LH123456",
        "customer": "John Doe",
        "price": "₹1,25,990",
        "status": "Delivered",
        "date": "26 May 2026",
      },
      {
        "id": "#LH123457",
        "customer": "Sarah Khan",
        "price": "₹89,990",
        "status": "Pending",
        "date": "25 May 2026",
      },
      {
        "id": "#LH123458",
        "customer": "Ali Ahmed",
        "price": "₹54,500",
        "status": "Cancelled",
        "date": "24 May 2026",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
          // Top Summary Cards
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Color(0xff2D0C8B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: summaryCard(
                    "Total Orders",
                    "512",
                    Icons.shopping_bag_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: summaryCard("Revenue", "₹12.5L", Icons.currency_rupee),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Search Box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade500),
                  const SizedBox(width: 10),
                  Text(
                    "Search orders...",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderDetailsScreen(),
                      ),
                    );
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Row(
                      children: [
                        // Icon
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.deepPurple,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Order Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order["id"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 5),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const OrderDetailsScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  order["customer"]!,
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                order["date"]!,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price + Status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              order["price"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(
                                  order["status"]!,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order["status"]!,
                                style: TextStyle(
                                  color: getStatusColor(order["status"]!),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Summary Card
  Widget summaryCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Status Color
  Color getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }
}
