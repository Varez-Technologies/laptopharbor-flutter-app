import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/detail_screen.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final Set<int> _wishlist = {};
  String _selectedBrand = 'All';
  String _sortBy = 'default';
  int _selectedNavIndex = 1;

  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': 1,
      'name': 'Dell XPS 13',
      'brand': 'Dell',
      'price': 99990,
      'displayPrice': '₹99,990',
      'rating': 4.5,
      'color': Color(0xFF1A2A4A),
      'image': 'assets/image/laptop05.webp',
    },
    {
      'id': 2,
      'name': 'HP Pavilion 15',
      'brand': 'HP',
      'price': 56990,
      'displayPrice': '₹56,990',
      'rating': 4.2,
      'color': Color(0xFF0D47A1),
      'image': 'assets/image/laptop06.webp',
    },
    {
      'id': 3,
      'name': 'Lenovo IdeaPad 3',
      'brand': 'Lenovo',
      'price': 45990,
      'displayPrice': '₹45,990',
      'rating': 4.1,
      'color': Color(0xFFB71C1C),
      'image': 'assets/image/laptop07.webp',
    },
    {
      'id': 4,
      'name': 'Apple MacBook Air',
      'brand': 'Apple',
      'price': 109990,
      'displayPrice': '₹1,09,990',
      'rating': 4.8,
      'color': Color(0xFF2C2C2C),
      'image': 'assets/image/laptop08.webp',
    },
    {
      'id': 5,
      'name': 'Asus VivoBook 15',
      'brand': 'Asus',
      'price': 52990,
      'displayPrice': '₹52,990',
      'rating': 4.0,
      'color': Color(0xFF1B5E20),
      'image': 'assets/image/laptop01.webp',
    },
    {
      'id': 6,
      'name': 'HP Spectre x360',
      'brand': 'HP',
      'price': 139990,
      'displayPrice': '₹1,39,990',
      'rating': 4.7,
      'image': 'assets/image/laptop02.webp',
      'color': Color(0xFF0D47A1),
    },
  ];

  final List<String> _brands = ['All', 'Dell', 'HP', 'Lenovo', 'Apple', 'Asus'];

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> list = _selectedBrand == 'All'
        ? List.from(_allProducts)
        : _allProducts.where((p) => p['brand'] == _selectedBrand).toList();

    if (_sortBy == 'price-asc')
      list.sort((a, b) => (a['price'] as int).compareTo(b['price'] as int));
    if (_sortBy == 'price-desc')
      list.sort((a, b) => (b['price'] as int).compareTo(a['price'] as int));
    if (_sortBy == 'rating')
      list.sort(
        (a, b) => (b['rating'] as double).compareTo(a['rating'] as double),
      );

    return list;
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
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
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
    final products = _filteredProducts;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterBar(),
          _buildBrandFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${products.length * 20}',
                      style: const TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const TextSpan(
                      text: ' Results Found',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _buildProductCard(products[index]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1565C0),
      child: SafeArea(
        bottom: false,
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
              const Expanded(
                child: Text(
                  'Laptops',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 26),
                onPressed: () {},
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {},
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
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    final chips = [
      {'label': 'Filter', 'icon': Icons.tune},
      {'label': 'Sort', 'icon': Icons.sort, 'action': 'sort'},
      {'label': 'Price', 'icon': Icons.keyboard_arrow_down},
      {'label': 'Brand', 'icon': Icons.keyboard_arrow_down},
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: chips.map((chip) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: chip['action'] == 'sort' ? _showSortBottomSheet : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
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
                      chip['label'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      chip['icon'] as IconData,
                      size: 16,
                      color: const Color(0xFF666666),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBrandFilter() {
    return Container(
      height: 44,
      color: const Color(0xFFF8F9FA),
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
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final id = product['id'] as int;
    final isWishlisted = _wishlist.contains(id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
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
                    child: Image.asset(
                      product['image'],
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['brand'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF888888),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        product['name'] as String,
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
                        product['displayPrice'] as String,
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
                            size: 13,
                          ),

                          const SizedBox(width: 3),

                          Text(
                            '${product['rating']}',
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
                    isWishlisted ? _wishlist.remove(id) : _wishlist.add(id);
                  });
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
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    size: 16,
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
                onTap: () => setState(() => _selectedNavIndex = i),
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
