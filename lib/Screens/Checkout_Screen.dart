import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  String selectedPaymentMethod = 'Credit / Debit Card';

  // Order summary data
  final double subtotal = 156980;
  final double shippingCharges = 50;
  final double taxRate = 0.18;

  double get taxAmount => subtotal * taxRate;
  double get totalAmount => subtotal + shippingCharges + taxAmount;

  final List<String> paymentMethods = [
    'Credit / Debit Card',
    'UPI',
    'Net Banking',
    'Cash on Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
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
                    color: currentStep >= 1 ? Colors.blue.shade700 : Colors.grey.shade300,
                  ),
                ),
                _buildStepIndicator(2, 'Payment', currentStep >= 1),
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep >= 2 ? Colors.blue.shade700 : Colors.grey.shade300,
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
                  // Step 1: Shipping Address
                  if (currentStep == 0) ...[
                    _buildShippingAddressSection(),
                  ],
                  // Step 2: Payment Method
                  if (currentStep == 1) ...[
                    _buildPaymentMethodSection(),
                  ],
                  // Step 3: Confirm Order
                  if (currentStep == 2) ...[
                    _buildConfirmOrderSection(),
                  ],
                  const SizedBox(height: 20),
                  // Order Summary (Always visible)
                  _buildOrderSummary(),
                ],
              ),
            ),
          ),
          // Next/Place Order Button
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
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep++;
                    });
                  } else {
                    // Place Order
                    _showOrderConfirmation();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentStep == 2 ? 'Place Order' : 'Next',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
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
            color: isActive ? Colors.blue.shade700 : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
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
            color: isActive ? Colors.blue.shade700 : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingAddressSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Change address
                  },
                  child: const Text('Change'),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'John Doe',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '123, Green Street,\nMumbai, Maharashtra - 400001',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '+91 9876543210',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            ...paymentMethods.map((method) => RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: selectedPaymentMethod,
                  activeColor: Colors.blue.shade700,
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

  Widget _buildConfirmOrderSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Order',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
            const Divider(),
            const SizedBox(height: 12),
            _buildConfirmDetail('Shipping Address', 'John Doe, 123, Green Street, Mumbai - 400001'),
            const SizedBox(height: 12),
            _buildConfirmDetail('Payment Method', selectedPaymentMethod),
            const SizedBox(height: 12),
            _buildConfirmDetail('Items', '2 items'),
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
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            _buildSummaryRow('Subtotal (2 items)', '₹${_formatPrice(subtotal)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Shipping Charges', shippingCharges == 0 ? 'Free' : '₹${_formatPrice(shippingCharges)}'),
            const SizedBox(height: 12),
            _buildSummaryRow('Tax (18%)', '₹${_formatPrice(taxAmount)}'),
            const Divider(height: 24),
            _buildSummaryRow(
              'Total Amount',
              '₹${_formatPrice(totalAmount)}',
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
            fontSize: isTotal ? 15 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black87 : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.normal,
            color: isTotal ? Colors.blue.shade700 : Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0);
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your order has been confirmed',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}