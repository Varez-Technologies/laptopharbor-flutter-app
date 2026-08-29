import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(
                color: Color(0xff2D0C8B),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  // Upload Image Box
                  Container(
                    height: 120,
                    width: 120,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(25),
                    ),

                    child: const Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.white,
                          size: 40,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Create New Product",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Add product details for your store",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Form Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18),

              child: Column(
                children: [
                  // Product Name
                  buildTextField(
                    "Product Name",
                    Icons.shopping_bag_outlined,
                  ),

                  const SizedBox(height: 18),

                  // Price
                  buildTextField(
                    "Price",
                    Icons.currency_rupee,
                  ),

                  const SizedBox(height: 18),

                  // Stock
                  buildTextField(
                    "Stock Quantity",
                    Icons.inventory_2_outlined,
                  ),

                  const SizedBox(height: 18),

                  // Category
                  buildTextField(
                    "Category",
                    Icons.category_outlined,
                  ),

                  const SizedBox(height: 18),

                  // Description
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    child: const TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            "Product Description",
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff2D0C8B),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),

                      onPressed: () {},

                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.save_outlined,
                            color: Colors.white,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Save Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom TextField
  Widget buildTextField(
    String hint,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,

          icon: Icon(
            icon,
            color: Colors.deepPurple,
          ),

          hintText: hint,
        ),
      ),
    );
  }
}