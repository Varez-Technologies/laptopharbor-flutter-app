import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/add_product_screen.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "More",
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Top Purple Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xff2D0C8B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Products",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
      ),
    );
  },
  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 10,
    ),
    decoration: BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.add,
          color: Colors.white,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          "Add",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search + Filter
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Search products...",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.deepPurple.shade700,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Filter",
                              style: TextStyle(
                                color: Colors.deepPurple.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  tabItem("All (512)", true),
                  tabItem("Active (490)", false),
                  tabItem("Inactive (22)", false),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Product List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children:  [
                  ProductTile(
                    image:
                        "assets/image/Laptopphoto.png",
                        
                    title: "Dell XPS 13",
                    price: "₹99,990",
                    active: true,
                  ),
                  ProductTile(
                    image:
                        "assets/image/Laptopphoto.png",
                    title: "HP Pavilion 15",
                    price: "₹56,990",
                    active: true,
                  ),
                  ProductTile(
                    image:
                        "assets/image/Laptopphoto.png",
                    title: "MacBook Air M2",
                    price: "₹1,09,990",
                    active: true,
                  ),
                  ProductTile(
                    image:
                        "assets/image/Laptopphoto.png",
                    title: "Lenovo IdeaPad 3",
                    price: "₹45,990",
                    active: true,
                  ),
                  ProductTile(
                    image:
                        "assets/image/Laptopphoto.png",
                    title: "Asus Vivobook 15",
                    price: "₹49,990",
                    active: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabItem(String title, bool selected) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: selected ? Colors.deepPurple : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 3,
          width: 70,
          color: selected ? Colors.deepPurple : Colors.transparent,
        ),
      ],
    );
  }
}

// Product Tile Widget
class ProductTile extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final bool active;

  const ProductTile({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: active
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              active ? "Active" : "Inactive",
              style: TextStyle(
                color: active ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 10),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}