import 'package:flutter/material.dart';
import 'package:laptopharbor01/services/order_service.dart';

enum TrackingStatus { completed, current, pending }

class TrackingStep {
  final String title;
  final String dateTime;
  final TrackingStatus status;

  const TrackingStep({
    required this.title,
    required this.dateTime,
    required this.status,
  });
}

class OrderTrackingScreen extends StatelessWidget {
  final OrderItem? order;

  const OrderTrackingScreen({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final o = order ?? OrderManager.instance.orders.first;

    final List<TrackingStep> steps = [
      TrackingStep(
        title: 'Order Placed',
        dateTime: '${o.date} • 10:30 AM',
        status: TrackingStatus.completed,
      ),
      TrackingStep(
        title: 'Order Confirmed & Packed',
        dateTime: '${o.date} • 11:15 AM',
        status: TrackingStatus.completed,
      ),
      TrackingStep(
        title: 'Dispatched from Warehouse',
        dateTime: '${o.date} • 02:45 PM',
        status: TrackingStatus.completed,
      ),
      TrackingStep(
        title: 'Out for Doorstep Delivery',
        dateTime: 'Today • 08:30 AM',
        status: o.status.toLowerCase() == 'delivered'
            ? TrackingStatus.completed
            : TrackingStatus.current,
      ),
      TrackingStep(
        title: 'Delivered to Customer',
        dateTime: o.status.toLowerCase() == 'delivered' ? 'Completed' : 'Expected by Evening',
        status: o.status.toLowerCase() == 'delivered'
            ? TrackingStatus.completed
            : TrackingStatus.pending,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        centerTitle: true,
        title: const Text(
          "Live Order Tracking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      // TOP ORDER CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff2D0C8B),
                              Color(0xff5B3FD8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.local_shipping_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              o.id,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Delivery for ${o.customerName}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _infoCard(
                                    "Total Payable",
                                    "₹${o.totalAmount.toStringAsFixed(0)}",
                                    Icons.currency_rupee,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _infoCard(
                                    "Live Status",
                                    o.status,
                                    Icons.check_circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // DELIVERY PERSON CARD
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Color(0xffEDE9FE),
                              child: Icon(
                                Icons.person,
                                color: Color(0xff2D0C8B),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Assigned Delivery Partner",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Ahmed Ali",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "LaptopHarbor Express Logistics",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xff2D0C8B),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TIMELINE CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Shipment Progress",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: steps.length,
                              itemBuilder: (context, index) {
                                final step = steps[index];
                                return _TrackingStepTile(
                                  step: step,
                                  isLast: index == steps.length - 1,
                                );
                              },
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
        ),
      ),
    );
  }

  static Widget _infoCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingStepTile extends StatelessWidget {
  final TrackingStep step;
  final bool isLast;

  const _TrackingStepTile({
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                _buildIcon(),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.5,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: step.status == TrackingStatus.completed
                            ? Colors.green
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: step.status == TrackingStatus.current
                      ? const Color(0xffEEF2FF)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: step.status == TrackingStatus.current
                        ? const Color(0xff2D0C8B)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: step.status == TrackingStatus.pending
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.dateTime,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    switch (step.status) {
      case TrackingStatus.completed:
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
        );

      case TrackingStatus.current:
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xff2D0C8B),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.local_shipping,
            color: Colors.white,
            size: 14,
          ),
        );

      case TrackingStatus.pending:
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
        );
    }
  }
}