import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  static const List<TrackingStep> _steps = [
    TrackingStep(
      title: 'Order Placed',
      dateTime: '20 May, 2026 • 10:30 AM',
      status: TrackingStatus.completed,
    ),
    TrackingStep(
      title: 'Order Confirmed',
      dateTime: '20 May, 2026 • 11:15 AM',
      status: TrackingStatus.completed,
    ),
    TrackingStep(
      title: 'Package Shipped',
      dateTime: '21 May, 2026 • 09:45 AM',
      status: TrackingStatus.completed,
    ),
    TrackingStep(
      title: 'Out for Delivery',
      dateTime: '27 May, 2026 • 08:30 AM',
      status: TrackingStatus.current,
    ),
    TrackingStep(
      title: 'Delivered',
      dateTime: 'Pending',
      status: TrackingStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        centerTitle: true,
        title: const Text(
          "Track Order",
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
          ),
        ),
      ),

      body: Column(
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
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_shipping_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "#LH12345678",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Your package is on the way 🚚",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _infoCard(
                                "Estimated",
                                "28 May",
                                Icons.calendar_month,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: _infoCard(
                                "Status",
                                "Shipping",
                                Icons.check_circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // DELIVERY PERSON CARD
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffEDE9FE),
                          child: Icon(
                            Icons.person,
                            color: Color(0xff2D0C8B),
                            size: 32,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Delivery Partner",
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
                                  fontSize: 17,
                                ),
                              ),

                              SizedBox(height: 3),

                              Text(
                                "Fast Express Delivery",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff2D0C8B),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TIMELINE CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tracking Timeline",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 24),

                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: _steps.length,
                          itemBuilder: (context, index) {
                            final step = _steps[index];

                            return _TrackingStepTile(
                              step: step,
                              isLast:
                                  index == _steps.length - 1,
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

          // BOTTOM BUTTON
          Container(
            padding: const EdgeInsets.fromLTRB(
              18,
              10,
              18,
              24,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Opening live tracking map...",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.location_on),
                label: const Text(
                  "Track Live Location",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2D0C8B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INFO CARD
  static Widget _infoCard(
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
          Icon(icon, color: Colors.white),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
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
}

// ─────────────────────────────────────────────────────────────
// TIMELINE TILE
// ─────────────────────────────────────────────────────────────

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
          // LEFT ICON + LINE
          SizedBox(
            width: 40,
            child: Column(
              children: [
                _buildIcon(),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin:
                          const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            step.status ==
                                    TrackingStatus.completed
                                ? Colors.green
                                : Colors.grey.shade300,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // RIGHT CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      step.status ==
                              TrackingStatus.current
                          ? const Color(0xffEEF2FF)
                          : Colors.grey.shade50,
                  borderRadius:
                      BorderRadius.circular(18),
                  border: Border.all(
                    color:
                        step.status ==
                                TrackingStatus.current
                            ? const Color(0xff2D0C8B)
                            : Colors.transparent,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color:
                            step.status ==
                                    TrackingStatus.pending
                                ? Colors.grey
                                : Colors.black,
                      ),
                    ),

                    const SizedBox(height: 6),

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
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 18,
          ),
        );

      case TrackingStatus.current:
        return Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xff2D0C8B),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.local_shipping,
            color: Colors.white,
            size: 16,
          ),
        );

      case TrackingStatus.pending:
        return Container(
          width: 30,
          height: 30,
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