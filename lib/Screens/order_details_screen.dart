import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/OrderTracking_Screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xff2D0C8B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "#LH123456",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Delivered",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  // Customer Info
                  buildSectionCard(
                    title: "Customer Information",
                    children: [
                      buildTile(
                        Icons.person_outline,
                        "Customer Name",
                        "John Doe",
                      ),
                      buildTile(
                        Icons.email_outlined,
                        "Email",
                        "john@example.com",
                      ),
                      buildTile(
                        Icons.phone_outlined,
                        "Phone",
                        "+92 300 1234567",
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Order Info
                  buildSectionCard(
                    title: "Order Information",
                    children: [
                      buildTile(
                        Icons.calendar_month_outlined,
                        "Order Date",
                        "26 May 2026",
                      ),
                      buildTile(
                        Icons.payment_outlined,
                        "Payment Status",
                        "Paid",
                      ),
                      buildTile(
                        Icons.local_shipping_outlined,
                        "Shipping",
                        "Express Delivery",
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Product Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.laptop_mac,
                            size: 45,
                            color: Colors.deepPurple,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "MacBook Pro M3",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "16GB RAM • 512GB SSD",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "₹1,25,990",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Total Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        buildPriceRow("Subtotal", "₹1,20,000"),
                        const SizedBox(height: 10),

                        buildPriceRow("Shipping", "₹990"),
                        const SizedBox(height: 10),

                        buildPriceRow("Tax", "₹5,000"),

                        const Divider(height: 30),

                        buildPriceRow("Total", "₹1,25,990", isBold: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                          label: const Text("Invoice"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            elevation: 0,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OrderTrackingScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.local_shipping),
                          label: const Text("Track"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2D0C8B),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECTION CARD
  Widget buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          ...children,
        ],
      ),
    );
  }

  // INFO TILE
  Widget buildTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.deepPurple, size: 22),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PRICE ROW
  Widget buildPriceRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.black : Colors.grey.shade700,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? Colors.deepPurple : Colors.black,
          ),
        ),
      ],
    );
  }
}
