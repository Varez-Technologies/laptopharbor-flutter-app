import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  final List<Map<String, dynamic>> reviews = const [
    {
      "title": "Great laptop! Super fast performance",
      "product": "Dell XPS 13",
      "rating": 5,
      "user": "John Doe",
    },
    {
      "title": "Excellent performance and battery life",
      "product": "MacBook Air",
      "rating": 4,
      "user": "Jane Smith",
    },
    {
      "title": "Good but a bit expensive",
      "product": "HP Spectre x360",
      "rating": 4,
      "user": "Mike Brown",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: const Color(0xff2D0C8B),
        elevation: 0,
        title: const Text(
          "Reviews",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Row
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Colors.deepPurple.withOpacity(0.1),
                      child: Text(
                        review["user"][0],
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            review["user"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            review["product"],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Rating
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < review["rating"]
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Review Text
                Text(
                  review["title"],
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                // Bottom Row
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Verified Purchase",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}