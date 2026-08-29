import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopharbor01/Screens/Cart_Screen.dart';
import 'package:laptopharbor01/Screens/Profile_Screen.dart';
import 'package:laptopharbor01/Screens/Support_Screen.dart';
import 'package:laptopharbor01/Screens/detail_screen.dart';
import 'package:laptopharbor01/Screens/product_screen.dart';
import 'package:laptopharbor01/Screens/wishlist_screen.dart';
import 'package:laptopharbor01/Screens/orders_screen.dart';
import 'package:laptopharbor01/Screens/Login_Screen.dart';
import 'package:laptopharbor01/Screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  int _selectedNavIndex = 0;
  final Set<String> _wishlist = {};
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'Dell', 'icon': Icons.laptop},
    {'name': 'HP', 'icon': Icons.laptop_chromebook},
    {'name': 'Lenovo', 'icon': Icons.laptop_mac},
    {'name': 'Apple', 'icon': Icons.apple},
    {'name': 'Asus', 'icon': Icons.computer},
  ];

  // Fallback products if Firestore is slow or offline
  final List<Map<String, dynamic>> _fallbackProducts = [
    {
      'id': 'dell-xps-13',
      'name': 'Dell XPS 13',
      'brand': 'Dell',
      'price': 99990,
      'discountPrice': 94990,
      'rating': 4.5,
      'badge': 'Best Seller',
      'image': 'assets/image/laptop05.webp',
      'images': ['assets/image/laptop05.webp', 'assets/image/laptop01.webp'],
      'description':
          'Dell XPS 13 combines high performance with an ultra-thin InfinityEdge display and 12th Gen Intel Core i7.',
      'specs': {
        'display': '13.4" FHD+ InfinityEdge (1920x1200)',
        'cpu': 'Intel Core i7-1250U 12th Gen',
        'ram': '16GB LPDDR5 | 512GB NVMe SSD',
        'gpu': 'Intel Iris Xe Graphics',
        'os': 'Windows 11 Home',
        'battery': 'Up to 12 Hours Battery Life',
      },
    },
    {
      'id': 'hp-pavilion-15',
      'name': 'HP Pavilion 15',
      'brand': 'HP',
      'price': 56990,
      'discountPrice': 52990,
      'rating': 4.2,
      'badge': 'Popular',
      'image': 'assets/image/laptop06.webp',
      'images': ['assets/image/laptop06.webp', 'assets/image/laptop02.webp'],
      'description':
          'HP Pavilion 15 offers dependable performance for work and study with AMD Ryzen 5 and audio by B&O.',
      'specs': {
        'display': '15.6" FHD IPS Micro-Edge (1920x1080)',
        'cpu': 'AMD Ryzen 5 5625U 6-Core',
        'ram': '16GB DDR4 | 512GB PCIe NVMe SSD',
        'gpu': 'AMD Radeon Graphics',
        'os': 'Windows 11 Home',
        'battery': 'Up to 8.5 Hours Battery Life',
      },
    },
    {
      'id': 'apple-macbook-air-m2',
      'name': 'MacBook Air M2',
      'brand': 'Apple',
      'price': 109990,
      'discountPrice': 104990,
      'rating': 4.8,
      'badge': 'Featured',
      'image': 'assets/image/laptop08.webp',
      'images': ['assets/image/laptop08.webp', 'assets/image/laptop04.webp'],
      'description':
          'Supercharged by Apple M2 chip. Incredible thin fanless design with up to 18 hours battery life.',
      'specs': {
        'display': '13.6" Liquid Retina Display True Tone',
        'cpu': 'Apple M2 8-Core CPU',
        'ram': '8GB Unified Memory | 256GB SSD',
        'gpu': '8-Core GPU & 16-Core Neural Engine',
        'os': 'macOS Sequoia',
        'battery': 'Up to 18 Hours Battery Life',
      },
    },
    {
      'id': 'lenovo-ideapad-3',
      'name': 'Lenovo IdeaPad 3',
      'brand': 'Lenovo',
      'price': 45990,
      'discountPrice': 42990,
      'rating': 4.1,
      'badge': 'Budget Pick',
      'image': 'assets/image/laptop07.webp',
      'images': ['assets/image/laptop07.webp', 'assets/image/laptop03.webp'],
      'description':
          'Lenovo IdeaPad 3 is designed for everyday multitasking, online classes, and entertainment.',
      'specs': {
        'display': '15.6" FHD Anti-Glare 250 nits',
        'cpu': 'Intel Core i3-1115G4 11th Gen',
        'ram': '8GB RAM | 512GB SSD',
        'gpu': 'Integrated Intel UHD Graphics',
        'os': 'Windows 11 Home',
        'battery': 'Up to 7 Hours Battery Life',
      },
    },
    {
      'id': 'asus-vivobook-15',
      'name': 'Asus VivoBook 15',
      'brand': 'Asus',
      'price': 52990,
      'discountPrice': 49990,
      'rating': 4.3,
      'badge': 'Best Value',
      'image': 'assets/image/laptop01.webp',
      'images': ['assets/image/laptop01.webp', 'assets/image/laptop05.webp'],
      'description':
          'Asus VivoBook 15 with NanoEdge bezel display and lightweight portable chassis.',
      'specs': {
        'display': '15.6" FHD NanoEdge Slim Bezel',
        'cpu': 'Intel Core i5-1135G7 11th Gen',
        'ram': '16GB DDR4 | 512GB NVMe SSD',
        'gpu': 'Intel Iris Xe Graphics',
        'os': 'Windows 11 Home',
        'battery': 'Up to 6 Hours Fast Charging',
      },
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildProductImage(dynamic imageSource, {double height = 90}) {
    String url = '';
    if (imageSource is List && imageSource.isNotEmpty) {
      url = imageSource.first.toString();
    } else if (imageSource is String) {
      url = imageSource;
    }

    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            _fallbackImageIcon(height),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: const Color(0xFF1565C0),
              ),
            ),
          );
        },
      );
    } else if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            _fallbackImageIcon(height),
      );
    }

    return _fallbackImageIcon(height);
  }

  Widget _fallbackImageIcon(double height) {
    return Container(
      height: height,
      color: const Color(0xFFE8EEF5),
      child: const Center(
        child: Icon(
          Icons.laptop_mac,
          size: 40,
          color: Color(0xFF1565C0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: _buildAppDrawer(),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBanner(),
                    _buildCategories(),
                    _buildFirestoreFeaturedProducts(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppDrawer() {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              user?.displayName ?? 'Valued Customer',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(user?.email ?? 'customer@laptopharbor.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                (user?.displayName ?? 'LH').substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: Color(0xFF1565C0)),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading:
                const Icon(Icons.grid_view_outlined, color: Color(0xFF1565C0)),
            title: const Text('Browse All Laptops'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProductListingScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined,
                color: Color(0xFF1565C0)),
            title: const Text('My Cart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border, color: Color(0xFF1565C0)),
            title: const Text('Wishlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined,
                color: Color(0xFF1565C0)),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent_outlined,
                color: Color(0xFF1565C0)),
            title: const Text('Customer Support & Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SupportFeedbackScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title:
                const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1565C0),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Builder(
                    builder: (btnContext) => IconButton(
                      icon:
                          const Icon(Icons.menu, color: Colors.white, size: 26),
                      onPressed: () => Scaffold.of(btnContext).openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'LaptopHarbor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SupportFeedbackScreen(),
                        ),
                      );
                    },
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CartScreen()),
                          );
                        },
                      ),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF5252),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductListingScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search for laptops, brands...',
                          style: TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Icon(Icons.tune, color: Color(0xFFAAAAAA), size: 20),
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

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF7B1FA2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5252),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'SUMMER SALE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Up to 30% OFF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductListingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1565C0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Shop Now →',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildProductImage('assets/image/laptop09.webp', height: 90),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProductListingScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isActive = _selectedCategory == index;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = index);
                  },
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFE3F0FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isActive
                                ? const Color(0xFF1565C0)
                                : const Color(0xFFE8EAF0),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          _categories[index]['icon'] as IconData,
                          color: const Color(0xFF1565C0),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _categories[index]['name'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color(0xFF555555),
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirestoreFeaturedProducts() {
    final selectedBrand = _categories[_selectedCategory]['name'] as String;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        List<Map<String, dynamic>> productList = [];

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            // Normalize fields
            if (!data.containsKey('brand') && data.containsKey('categoryId')) {
              data['brand'] = data['categoryId'].toString().toUpperCase();
            }
            productList.add(data);
          }
        }

        // If firestore is empty or loading failed, use fallback products
        if (productList.isEmpty) {
          productList = _fallbackProducts;
        }

        // Filter by selected category
        List<Map<String, dynamic>> displayed = productList;
        if (selectedBrand != 'All') {
          displayed = productList
              .where((p) =>
                  (p['brand'] ?? '')
                      .toString()
                      .toLowerCase()
                      .contains(selectedBrand.toLowerCase()) ||
                  (p['name'] ?? '')
                      .toString()
                      .toLowerCase()
                      .contains(selectedBrand.toLowerCase()))
              .toList();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedBrand == 'All'
                        ? 'Featured Products'
                        : '$selectedBrand Laptops',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListingScreen(
                            initialBrand:
                                selectedBrand == 'All' ? null : selectedBrand,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (displayed.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: const Text(
                    'No products found in this category.',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.74,
                  ),
                  itemCount: displayed.length,
                  itemBuilder: (context, index) {
                    final product = displayed[index];
                    final String id = product['id']?.toString() ?? '$index';
                    final bool isWishlisted = _wishlist.contains(id);

                    // Formatted Price string
                    String priceStr = '';
                    if (product['price'] != null) {
                      priceStr = '₹${product['price']}';
                    } else if (product['displayPrice'] != null) {
                      priceStr = product['displayPrice'].toString();
                    } else {
                      priceStr = '₹69,990';
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 115,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF0F4F8),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                  ),
                                  child: Center(
                                    child: _buildProductImage(
                                      product['images'] ?? product['image'],
                                      height: 85,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name']?.toString() ?? 'Laptop',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        priceStr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF1565C0),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFF59E0B),
                                            size: 14,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '${product['rating'] ?? 4.5}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (product['badge'] != null)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1565C0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product['badge'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 6,
                              right: 6,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWishlisted
                                        ? _wishlist.remove(id)
                                        : _wishlist.add(id);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isWishlisted
                                            ? 'Removed from Wishlist'
                                            : 'Added to Wishlist!',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isWishlisted
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 16,
                                    color:
                                        isWishlisted ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {
        'icon': Icons.grid_view_outlined,
        'label': 'Categories',
        'page': const ProductListingScreen(),
      },
      {
        'icon': Icons.favorite_border,
        'label': 'Wishlist',
        'page': const WishlistScreen(),
      },
      {
        'icon': Icons.shopping_cart_outlined,
        'label': 'Cart',
        'page': const CartScreen(),
      },
      {
        'icon': Icons.person_outline,
        'label': 'Profile',
        'page': const ProfileScreen(),
      },
    ];
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8EAF0))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final active = _selectedNavIndex == i;
              return GestureDetector(
                onTap: () {
                  if (i == 0) {
                    setState(() => _selectedNavIndex = 0);
                    return;
                  }
                  if (items[i].containsKey('page')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => items[i]['page'] as Widget,
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i]['icon'] as IconData,
                      color: active
                          ? const Color(0xFF1565C0)
                          : const Color(0xFF999999),
                      size: 24,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i]['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: active
                            ? const Color(0xFF1565C0)
                            : const Color(0xFF999999),
                        fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
