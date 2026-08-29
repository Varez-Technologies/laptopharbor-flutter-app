import 'package:flutter/material.dart';
import 'package:laptopharbor01/services/cart_service.dart';
import 'package:laptopharbor01/Screens/OrderTracking_Screen.dart';
import 'package:laptopharbor01/Screens/home_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  String selectedPaymentMethod = 'Credit / Debit Card';

  final cartManager = CartManager.instance;

  final List<String> paymentMethods = [
    'Credit / Debit Card',
    'UPI',
    'Net Banking',
    'Cash on Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    final subtotal = cartManager.subtotal;
    final shippingCharges = cartManager.shippingCharges;
    final taxAmount = cartManager.taxAmount;
    final totalAmount = cartManager.totalAmount;
    final totalItems = cartManager.totalItemsCount;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Step Indicator
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                _buildStepIndicator(1, 'Address', currentStep >= 0),
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep >= 1 ? const Color(0xFF1565C0) : Colors.grey.shade300,
                  ),
                ),
                _buildStepIndicator(2, 'Payment', currentStep >= 1),
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep >= 2 ? const Color(0xFF1565C0) : Colors.grey.shade300,
                  ),
                ),
                _buildStepIndicator(3, 'Confirm', currentStep >= 2),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentStep == 0) _buildShippingAddressSection(),
                  if (currentStep == 1) _buildPaymentMethodSection(),
                  if (currentStep == 2) _buildConfirmOrderSection(totalItems),
                  const SizedBox(height: 16),
                  _buildOrderSummary(subtotal, shippingCharges, taxAmount, totalAmount, totalItems),
                ],
              ),
            ),
          ),
          // Action Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep++;
                    });
                  } else {
                    _processPlaceOrder();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentStep == 2 ? 'Place Order (₹${totalAmount.toStringAsFixed(0)})' : 'Proceed to Payment →',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _processPlaceOrder() {
    // Generate Order ID and clear cart
    final orderId = "LH${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}";
    
    // Clear cart immediately
    cartManager.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 48),
            ),
            const SizedBox(height: 18),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: #$orderId',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1565C0),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your order has been confirmed. You will receive a tracking update shortly.',
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                  );
                },
                icon: const Icon(Icons.local_shipping, size: 18),
                label: const Text('Track Order Status', style: TextStyle(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1565C0) : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? const Color(0xFF1565C0) : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingAddressSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1565C0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Default', style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 20),
            const Text(
              'Muhammad Hammad',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Suite 402, Business Bay, Tech Avenue,\nKarachi, Pakistan',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact: +92 300 1234567',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1565C0),
              ),
            ),
            const Divider(height: 20),
            ...paymentMethods.map((method) => RadioListTile<String>(
                  title: Text(method, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  value: method,
                  groupValue: selectedPaymentMethod,
                  activeColor: const Color(0xFF1565C0),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmOrderSection(int totalItems) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Order Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1565C0),
              ),
            ),
            const Divider(height: 20),
            _buildConfirmDetail('Delivery To', 'Muhammad Hammad, Karachi'),
            const SizedBox(height: 10),
            _buildConfirmDetail('Payment', selectedPaymentMethod),
            const SizedBox(height: 10),
            _buildConfirmDetail('Total Items', '$totalItems Laptops in Cart'),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(double subtotal, double shippingCharges, double taxAmount, double totalAmount, int totalItems) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const Divider(height: 20),
            _buildSummaryRow('Subtotal ($totalItems items)', '₹${subtotal.toStringAsFixed(0)}'),
            const SizedBox(height: 10),
            _buildSummaryRow('Shipping Charges', shippingCharges == 0 ? 'FREE' : '₹${shippingCharges.toStringAsFixed(0)}'),
            const SizedBox(height: 10),
            _buildSummaryRow('Tax (18%)', '₹${taxAmount.toStringAsFixed(0)}'),
            const Divider(height: 22),
            _buildSummaryRow(
              'Total Payable',
              '₹${totalAmount.toStringAsFixed(0)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            color: isTotal ? const Color(0xFF1A1A2E) : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isTotal ? const Color(0xFF1565C0) : Colors.black87,
          ),
        ),
      ],
    );
  }
}