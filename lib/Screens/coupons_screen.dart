import 'package:flutter/material.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> coupons = [
      {
        "code": "WELCOME20",
        "discount": "20% OFF",
        "status": "Active",
        "expiry": "30 Jun 2026",
        "color": Colors.green,
      },
      {
        "code": "SUMMER15",
        "discount": "15% OFF",
        "status": "Active",
        "expiry": "15 Jul 2026",
        "color": Colors.orange,
      },
      {
        "code": "MEGA50",
        "discount": "50% OFF",
        "status": "Expired",
        "expiry": "01 May 2026",
        "color": Colors.red,
      },
      {
        "code": "NEWUSER10",
        "discount": "10% OFF",
        "status": "Active",
        "expiry": "10 Aug 2026",
        "color": Colors.blue,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Coupons",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add , color: Colors.white),
          ),
        ],
      ),

      body: Column(
        children: [
          // Top Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),

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
                        "Active Coupons",
                        "24",
                        Icons.discount_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: topCard(
                        "Total Savings",
                        "₹1.2L",
                        Icons.currency_rupee,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Search Box
                Container(
                  height: 55,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Search coupons...",
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

          const SizedBox(height: 20),

          // Coupon List
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              itemCount: coupons.length,

              itemBuilder: (context, index) {
                final coupon = coupons[index];

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 16),

                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(22),
                  ),

                  child: Row(
                    children: [
                      // Discount Box
                      Container(
                        height: 75,
                        width: 75,

                        decoration: BoxDecoration(
                          color: coupon["color"]
                              .withOpacity(0.1),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: Center(
                          child: Text(
                            coupon["discount"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: coupon["color"],
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Coupon Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              coupon["code"],
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Expires: ${coupon["expiry"]}",
                              style: TextStyle(
                                color:
                                    Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),

                              decoration: BoxDecoration(
                                color: coupon["status"] ==
                                        "Active"
                                    ? Colors.green
                                        .withOpacity(
                                        0.1,
                                      )
                                    : Colors.red
                                        .withOpacity(
                                        0.1,
                                      ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  30,
                                ),
                              ),

                              child: Text(
                                coupon["status"],
                                style: TextStyle(
                                  color: coupon[
                                              "status"] ==
                                          "Active"
                                      ? Colors.green
                                      : Colors.red,

                                  fontWeight:
                                      FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff2D0C8B),

        onPressed: () {},

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: const Text(
          "Add Coupon",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Top Card
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
}