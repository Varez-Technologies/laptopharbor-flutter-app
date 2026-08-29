import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "New Order Received",
        "message":
            "A new laptop order has been placed by John Doe.",
        "time": "2 min ago",
        "icon": Icons.shopping_bag_outlined,
        "color": Colors.green,
        "read": false,
      },
      {
        "title": "Payment Successful",
        "message":
            "Payment of ₹1,25,000 received successfully.",
        "time": "10 min ago",
        "icon": Icons.payment_outlined,
        "color": Colors.blue,
        "read": false,
      },
      {
        "title": "Product Out of Stock",
        "message":
            "Dell XPS 13 stock is running low.",
        "time": "1 hour ago",
        "icon": Icons.warning_amber_rounded,
        "color": Colors.orange,
        "read": true,
      },
      {
        "title": "New User Registered",
        "message":
            "Sarah Khan created a new account.",
        "time": "3 hours ago",
        "icon": Icons.person_outline,
        "color": Colors.purple,
        "read": true,
      },
      {
        "title": "Coupon Expiring Soon",
        "message":
            "SUMMER20 coupon will expire tomorrow.",
        "time": "5 hours ago",
        "icon": Icons.discount_outlined,
        "color": Colors.red,
        "read": true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),

        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {},

            child: const Text(
              "Mark all read",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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

            child: Row(
              children: [
                Expanded(
                  child: topCard(
                    "Unread",
                    "12",
                    Icons.notifications_active_outlined,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: topCard(
                    "Today",
                    "28",
                    Icons.today_outlined,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Notification List
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18),

              itemCount: notifications.length,

              itemBuilder: (context, index) {
                final notification = notifications[index];

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape:
                          const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),

                      builder: (context) {
                        return Padding(
                          padding:
                              const EdgeInsets.all(24),

                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [
                              Container(
                                height: 80,
                                width: 80,

                                decoration: BoxDecoration(
                                  color: notification[
                                          "color"]
                                      .withOpacity(0.1),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    22,
                                  ),
                                ),

                                child: Icon(
                                  notification["icon"],
                                  color:
                                      notification[
                                          "color"],
                                  size: 40,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                notification["title"],
                                textAlign:
                                    TextAlign.center,

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                notification["message"],
                                textAlign:
                                    TextAlign.center,

                                style: TextStyle(
                                  color: Colors
                                      .grey.shade700,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Text(
                                notification["time"],
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade500,
                                ),
                              ),

                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                height: 55,

                                child: ElevatedButton(
                                  style:
                                      ElevatedButton
                                          .styleFrom(
                                    backgroundColor:
                                        const Color(
                                      0xff2D0C8B,
                                    ),

                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        18,
                                      ),
                                    ),
                                  ),

                                  onPressed: () {
                                    Navigator.pop(
                                        context);
                                  },

                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },

                  child: Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 16,
                    ),

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: notification["read"]
                          ? Colors.white
                          : Colors.deepPurple
                              .withOpacity(0.06),

                      borderRadius:
                          BorderRadius.circular(22),
                    ),

                    child: Row(
                      children: [
                        // Icon Box
                        Container(
                          height: 60,
                          width: 60,

                          decoration: BoxDecoration(
                            color: notification[
                                    "color"]
                                .withOpacity(0.1),

                            borderRadius:
                                BorderRadius
                                    .circular(18),
                          ),

                          child: Icon(
                            notification["icon"],
                            color:
                                notification["color"],
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification[
                                          "title"],
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                  if (!notification[
                                      "read"])
                                    Container(
                                      height: 10,
                                      width: 10,

                                      decoration:
                                          const BoxDecoration(
                                        color:
                                            Colors.red,
                                        shape: BoxShape
                                            .circle,
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                notification[
                                    "message"],
                                maxLines: 2,
                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style: TextStyle(
                                  color: Colors
                                      .grey.shade700,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                notification["time"],
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
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

  // Top Cards
  Widget topCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
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
              fontSize: 24,
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