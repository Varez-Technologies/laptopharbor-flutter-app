import 'package:flutter/material.dart';
import 'package:laptopharbor01/services/order_service.dart';
import 'package:laptopharbor01/Screens/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final orderManager = OrderManager.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: orderManager.ordersCountNotifier,
        builder: (context, count, child) {
          final allOrders = orderManager.orders;
          final orders = _searchQuery.isEmpty
              ? allOrders
              : allOrders
                  .where((o) =>
                      o.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      o.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      o.status.toLowerCase().contains(_searchQuery.toLowerCase()))
                  .toList();

          double totalRevenue = allOrders.fold(0.0, (sum, o) => sum + o.totalAmount);

          return Column(
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
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Row(
                      children: [
                        Expanded(
                          child: summaryCard(
                            "Total Orders",
                            "${allOrders.length}",
                            Icons.shopping_bag_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: summaryCard(
                            "Total Spent",
                            "₹${(totalRevenue / 1000).toStringAsFixed(1)}k",
                            Icons.currency_rupee,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Search Box
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (v) => setState(() => _searchQuery = v.trim()),
                              decoration: const InputDecoration(
                                hintText: "Search orders by ID, name, status...",
                                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Orders List
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            const Text(
                              "No orders found",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final order = orders[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderDetailsScreen(order: order),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.grey.shade200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.03),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 54,
                                        width: 54,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff2D0C8B).withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: const Icon(
                                          Icons.shopping_bag,
                                          color: Color(0xff2D0C8B),
                                          size: 26,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.id,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF1A1A2E),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              order.customerName,
                                              style: TextStyle(
                                                color: Colors.blue.shade800,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              order.date,
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₹${order.totalAmount.toStringAsFixed(0)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xFF1A1A2E),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: getStatusColor(order.status).withOpacity(0.12),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              order.status,
                                              style: TextStyle(
                                                color: getStatusColor(order.status),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
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
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget summaryCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "delivered":
        return Colors.green;
      case "pending":
      case "order placed":
      case "confirmed":
        return Colors.orange.shade800;
      case "out for delivery":
        return Colors.blue.shade700;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
