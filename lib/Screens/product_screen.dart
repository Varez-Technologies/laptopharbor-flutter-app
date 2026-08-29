import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopharbor01/Screens/detail_screen.dart';
import 'package:laptopharbor01/Screens/Cart_Screen.dart';
import 'package:laptopharbor01/Screens/wishlist_screen.dart';
import 'package:laptopharbor01/Screens/Profile_Screen.dart';
import 'package:laptopharbor01/services/wishlist_service.dart';
import 'package:laptopharbor01/services/cart_service.dart';

class ProductListingScreen extends StatefulWidget {
  final String? initialBrand;
  final String? initialQuery;

  const ProductListingScreen({
    super.key,
    this.initialBrand,
    this.initialQuery,
  });

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late String _selectedBrand;
  String _sortBy = 'default';
  int _selectedNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _brands = ['All', 'Dell', 'HP', 'Lenovo', 'Apple', 'Asus'];

  final List<Map<String, dynamic>> _fallbackProducts = [
    {
      'id': 'apple-macbook-air-m2',
      'name': 'MacBook Air M2',
      'brand': 'Apple',
      'price': 109990,
      'discountPrice': 104990,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      'images': ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8'],
      'description':
          'Thin, light and fast. Apple M2 chip brings incredible battery life and Liquid Retina display.',
      'specs': {
        'display': '13.6" Liquid Retina Display',
        'cpu': 'Apple M2 Chip 8-Core',
        'ram': '8GB Memory | 256GB SSD',
        'gpu': '8-Core GPU',
        'os': 'macOS Sequoia',
      },
    },
    {
      'id': 'dell-xps-13',
      'name': 'Dell XPS 13',
      'brand': 'Dell',
      'price': 99990,
      'discountPrice': 94990,
      'rating': 4.5,
      'image': 'assets/image/laptop05.webp',
      'images': ['assets/image/laptop05.webp'],
      'description':
          'Dell XPS 13 is an exceptional ultrabook featuring Intel Core i7 12th Gen with 13.4-inch InfinityEdge display.',
      'specs': {
        'display': '13.4" FHD+ Display',
        'cpu': 'Intel Core i7 12th Gen',
        'ram': '16GB RAM | 512GB SSD',
        'gpu': 'Intel Iris Xe Graphics',
        'os': 'Windows 11 Home',
      },
    },
    {
      'id': 'hp-pavilion-15',
      'name': 'HP Pavilion 15',
      'brand': 'HP',
      'price': 56990,
      'discountPrice': 52990,
      'rating': 4.2,
      'image': 'assets/image/laptop06.webp',
      'images': ['assets/image/laptop06.webp'],
      'description':
          'HP Pavilion 15 brings great performance with AMD Ryzen 5 processor and micro-edge anti-glare screen.',
      'specs': {
        'display': '15.6" FHD IPS Display',
        'cpu': 'AMD Ryzen 5 5625U',
        'ram': '16GB RAM | 512GB SSD',
        'gpu': 'AMD Radeon Graphics',
        'os': 'Windows 11 Home',
      },
    },
    {
      'id': 'lenovo-ideapad-3',
      'name': 'Lenovo IdeaPad 3',
      'brand': 'Lenovo',
      'price': 45990,
      'discountPrice': 42990,
      'rating': 4.1,
      'image': 'assets/image/laptop07.webp',
      'images': ['assets/image/laptop07.webp'],
      'description':
          'Everyday computing made easy with Lenovo IdeaPad 3, featuring rapid charge and Dolby Audio.',
      'specs': {
        'display': '15.6" FHD Display',
        'cpu': 'Intel Core i3 11th Gen',
        'ram': '8GB RAM | 512GB SSD',
        'gpu': 'Intel UHD Graphics',
        'os': 'Windows 11 Home',
      },
    },
    {
      'id': 'asus-vivobook-15',
      'name': 'Asus VivoBook 15',
      'brand': 'Asus',
      'price': 52990,
      'discountPrice': 49990,
      'rating': 4.3,
      'image': 'assets/image/laptop01.webp',
      'images': ['assets/image/laptop01.webp'],
      'description':
          'Asus VivoBook 15 delivers compact portable design with vibrant visuals and fingerprint security.',
      'specs': {
        'display': '15.6" NanoEdge FHD',
        'cpu': 'Intel Core i5 11th Gen',
        'ram': '16GB RAM | 512GB SSD',
        'gpu': 'Intel Iris Xe Graphics',
        'os': 'Windows 11 Home',
      },
    },
    {
      'id': 'hp-spectre-x360',
      'name': 'HP Spectre x360',
      'brand': 'HP',
      'price': 139990,
      'discountPrice': 132990,
      'rating': 4.7,
      'image': 'assets/image/laptop02.webp',
      'images': ['assets/image/laptop02.webp'],
      'description':
          'Premium 2-in-1 convertible laptop with OLED touch display, stylus support, and gem-cut luxury build.',
      'specs': {
        'display': '13.5" 3K2K OLED Touch Screen',
        'cpu': 'Intel Core i7 12th Gen Evo',
        'ram': '16GB LPDDR4x | 1TB SSD',
        'gpu': 'Intel Iris Xe Graphics',
        'os': 'Windows 11 Pro',
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedBrand = widget.initialBrand ?? 'All';
    _searchQuery = widget.initialQuery ?? '';
    _searchController.text = _searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildProductImage(dynamic imageSource, {double height = 120}) {
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
        errorBuilder: (_, __, ___) => _fallbackImageIcon(height),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
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
        errorBuilder: (_, __, ___) => _fallbackImageIcon(height),
      );
    }

    return _fallbackImageIcon(height);
  }

  Widget _fallbackImageIcon(double height) {
    return Container(
      height: height,
      color: const Color(0xFFE8EEF5),
      child: const Center(
        child: Icon(Icons.laptop_mac, size: 44, color: Color(0xFF1565C0)),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final options = [
          {'label': 'Default', 'value': 'default'},
          {'label': 'Price: Low to High', 'value': 'price-asc'},
          {'label': 'Price: High to Low', 'value': 'price-desc'},
          {'label': 'Top Rated', 'value': 'rating'},
        ];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sort By',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              ...options.map((opt) {
                final isSelected = _sortBy == opt['value'];
                return ListTile(
                  title: Text(
                    opt['label']!,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected ? const Color(0xFF1565C0) : null,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Color(0xFF1565C0))
                      : null,
                  onTap: () {
                    setState(() => _sortBy = opt['value']!);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 950 ? 4 : (screenWidth > 600 ? 3 : 2);
    final childAspectRatio = screenWidth > 600 ? 0.76 : 0.72;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          List<Map<String, dynamic>> productList = [];

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            for (var doc in snapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              if (!data.containsKey('brand') && data.containsKey('categoryId')) {
                data['brand'] = data['categoryId'].toString().toUpperCase();
              }
              productList.add(data);
            }
          }

          if (productList.isEmpty) {
            productList = _fallbackProducts;
          }

          List<Map<String, dynamic>> filtered = _selectedBrand == 'All'
              ? List.from(productList)
              : productList
                  .where((p) =>
                      (p['brand'] ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(_selectedBrand.toLowerCase()) ||
                      (p['name'] ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(_selectedBrand.toLowerCase()))
                  .toList();

          if (_searchQuery.isNotEmpty) {
            filtered = filtered
                .where((p) =>
                    (p['name'] ?? '')
                        .toString()
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                    (p['brand'] ?? '')
                        .toString()
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                    (p['description'] ?? '')
                        .toString()
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                .toList();
          }

          if (_sortBy == 'price-asc') {
            filtered.sort((a, b) {
              final num pA = a['price'] is num ? a['price'] : 0;
              final num pB = b['price'] is num ? b['price'] : 0;
              return pA.compareTo(pB);
            });
          } else if (_sortBy == 'price-desc') {
            filtered.sort((a, b) {
              final num pA = a['price'] is num ? a['price'] : 0;
              final num pB = b['price'] is num ? b['price'] : 0;
              return pB.compareTo(pA);
            });
          } else if (_sortBy == 'rating') {
            filtered.sort((a, b) {
              final num rA = a['rating'] is num ? a['rating'] : 0;
              final num rB = b['rating'] is num ? b['rating'] : 0;
              return rB.compareTo(rA);
            });
          }

          return Column(
            children: [
              _buildHeader(),
              _buildFilterBar(),
              _buildBrandFilter(),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${filtered.length}',
                              style: const TextStyle(
                                color: Color(0xFF1A1A2E),
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            const TextSpan(
                              text: ' Results Found',
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off, size: 64, color: Colors.grey),
                            const SizedBox(height: 12),
                            const Text(
                              'No matching laptops found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedBrand = 'All';
                                  _searchQuery = '';
                                  _searchController.clear();
                                });
                              },
                              child: const Text('Reset Filters'),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) =>
                                _buildProductCard(filtered[index]),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1565C0),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() => _searchQuery = val.trim());
                        },
                        decoration: InputDecoration(
                          hintText: 'Search laptops, brands...',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFAAAAAA),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF1565C0),
                            size: 20,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<int>(
                    valueListenable: CartManager.instance.cartCountNotifier,
                    builder: (context, count, child) {
                      return Stack(
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
                                MaterialPageRoute(builder: (_) => const CartScreen()),
                              );
                            },
                          ),
                          if (count > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF5252),
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$count',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              GestureDetector(
                onTap: _showSortBottomSheet,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F0FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF1565C0),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Sort By',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.sort, size: 16, color: Color(0xFF1565C0)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD0D5DD),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Brand: $_selectedBrand',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandFilter() {
    return Container(
      height: 44,
      color: const Color(0xFFF8F9FA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            itemCount: _brands.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final brand = _brands[index];
              final isSelected = _selectedBrand == brand;
              return GestureDetector(
                onTap: () => setState(() => _selectedBrand = brand),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1565C0) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1565C0)
                          : const Color(0xFFD0D5DD),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    brand,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF555555),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final String id = product['id']?.toString() ?? product['name'] ?? '';
    final String name = product['name']?.toString() ?? 'Laptop';
    final isWishlisted = WishlistManager.instance.isInWishlist(id, name);

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
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8EAF0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F7FA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: _buildProductImage(
                      product['images'] ?? product['image'],
                      height: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (product['brand'] ?? 'Laptop').toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        priceStr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFF59E0B),
                            size: 13,
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
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    WishlistManager.instance.toggleWishlist(product);
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                  width: 32,
                  height: 32,
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
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    size: 17,
                    color: isWishlisted ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.grid_view_outlined, 'label': 'Categories'},
      {'icon': Icons.favorite_border, 'label': 'Wishlist'},
      {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
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
                    Navigator.pop(context);
                  } else if (i == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WishlistScreen()),
                    );
                  } else if (i == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  } else if (i == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
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
