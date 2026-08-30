import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopharbor01/services/cart_service.dart';

class OrderItem {
  final String id;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String shippingAddress;
  final String paymentMethod;
  final List<CartProduct> items;
  final double subtotal;
  final double shippingCharges;
  final double taxAmount;
  final double totalAmount;
  String status;
  final String date;

  OrderItem({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.shippingCharges,
    required this.taxAmount,
    required this.totalAmount,
    this.status = 'Order Placed',
    required this.date,
  });
}

class OrderManager {
  static final OrderManager instance = OrderManager._internal();
  OrderManager._internal();

  final List<OrderItem> orders = [
    OrderItem(
      id: '#LH884210',
      customerName: 'Muhammad Hammad',
      customerEmail: 'customer@laptopharbor.com',
      customerPhone: '+92 300 1234567',
      shippingAddress: 'Suite 402, Business Bay, Tech Avenue, Karachi',
      paymentMethod: 'Credit / Debit Card',
      items: [
        CartProduct(
          id: 'apple-macbook-air-m2',
          name: 'MacBook Air M2',
          price: 109990,
          image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
          quantity: 1,
        ),
      ],
      subtotal: 109990,
      shippingCharges: 0,
      taxAmount: 19798,
      totalAmount: 129788,
      status: 'Out for Delivery',
      date: '30 Aug 2026',
    ),
  ];

  final ValueNotifier<int> ordersCountNotifier = ValueNotifier<int>(1);

  OrderItem createOrder({
    required List<CartProduct> cartItems,
    required String paymentMethod,
    required double subtotal,
    required double shippingCharges,
    required double taxAmount,
    required double totalAmount,
    String? address,
    String? phone,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? 'Muhammad Hammad';
    final email = user?.email ?? 'customer@laptopharbor.com';
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';
    final orderId = '#LH${now.millisecondsSinceEpoch.toString().substring(7)}';

    final newOrder = OrderItem(
      id: orderId,
      customerName: name,
      customerEmail: email,
      customerPhone: phone ?? '+92 300 1234567',
      shippingAddress: address ?? 'Suite 402, Business Bay, Tech Avenue, Karachi',
      paymentMethod: paymentMethod,
      items: List.from(cartItems),
      subtotal: subtotal,
      shippingCharges: shippingCharges,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
      status: 'Order Placed',
      date: dateStr,
    );

    // Insert at the beginning so latest order is on top
    orders.insert(0, newOrder);
    ordersCountNotifier.value = orders.length;

    return newOrder;
  }

  OrderItem? getOrderById(String id) {
    try {
      return orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return orders.isNotEmpty ? orders.first : null;
    }
  }
}
