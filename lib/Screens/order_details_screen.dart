import 'package:flutter/material.dart';
import 'package:laptopharbor01/services/order_service.dart';
import 'package:laptopharbor01/Screens/OrderTracking_Screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderItem? order;

  const OrderDetailsScreen({super.key, this.order});

  Widget _buildProductImage(String imageSource) {
    if (imageSource.startsWith('http://') || imageSource.startsWith('https://')) {
      return Image.network(
        imageSource,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.laptop_mac, size: 36, color: Color(0xFF1565C0)),
      );
    } else if (imageSource.startsWith('assets/')) {
      return Image.asset(
        imageSource,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.laptop_mac, size: 36, color: Color(0xFF1565C0)),
      );
    }
    return const Icon(Icons.laptop_mac, size: 36, color: Color(0xFF1565C0));
  }

  @override
  Widget build(BuildContext context) {
    final o = order ?? OrderManager.instance.orders.first;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
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
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 38,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        o.id,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          o.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Customer Info
                      buildSectionCard(
                        title: "Customer & Shipping Information",
                        children: [
                          buildTile(Icons.person_outline, "Customer Name", o.customerName),
                          buildTile(Icons.email_outlined, "Email Address", o.customerEmail),
                          buildTile(Icons.phone_outlined, "Phone Number", o.customerPhone),
                          buildTile(Icons.location_on_outlined, "Delivery Address", o.shippingAddress),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Order Info
                      buildSectionCard(
                        title: "Order & Payment Info",
                        children: [
                          buildTile(Icons.calendar_month_outlined, "Order Date", o.date),
                          buildTile(Icons.payment_outlined, "Payment Method", o.paymentMethod),
                          buildTile(Icons.local_shipping_outlined, "Delivery Type", "Express Doorstep Delivery"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Products Section
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Purchased Items",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 14),
                            ...o.items.map((item) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: _buildProductImage(item.image),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Quantity: ${item.quantity}",
                                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "₹${item.price.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            color: Color(0xFF1565C0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Total Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            buildPriceRow("Subtotal", "₹${o.subtotal.toStringAsFixed(0)}"),
                            const SizedBox(height: 10),
                            buildPriceRow("Shipping Charges", o.shippingCharges == 0 ? "FREE" : "₹${o.shippingCharges.toStringAsFixed(0)}"),
                            const SizedBox(height: 10),
                            buildPriceRow("Tax (18%)", "₹${o.taxAmount.toStringAsFixed(0)}"),
                            const Divider(height: 26),
                            buildPriceRow("Total Amount", "₹${o.totalAmount.toStringAsFixed(0)}", isBold: true),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action Track Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderTrackingScreen(order: o),
                              ),
                            );
                          },
                          icon: const Icon(Icons.local_shipping, color: Colors.white),
                          label: const Text(
                            "Live Order Tracking",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2D0C8B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
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

  Widget buildTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: const Color(0xff2D0C8B).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xff2D0C8B), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? const Color(0xFF1565C0) : Colors.black,
          ),
        ),
      ],
    );
  }
}
