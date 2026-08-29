import 'package:flutter/material.dart';
import 'package:laptopharbor01/Screens/Cart_Screen.dart';
import 'package:laptopharbor01/Screens/Checkout_Screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductDetailScreen({super.key, this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _activeImage = 0;
  bool _inWishlist = false;
  bool _addedToCart = false;
  bool _showFullDesc = false;
  int _quantity = 1;

  late Map<String, dynamic> _p;

  @override
  void initState() {
    super.initState();
    _p = widget.product ??
        {
          'id': 'dell-xps-13',
          'name': 'Dell XPS 13',
          'brand': 'Dell',
          'price': 99990,
          'discountPrice': 94990,
          'rating': 4.5,
          'image': 'assets/image/laptop05.webp',
          'images': [
            'assets/image/laptop05.webp',
            'assets/image/laptop01.webp',
            'assets/image/laptop09.webp',
          ],
          'description':
              'The Dell XPS 13 is a high-performance ultrabook that combines power, portability, and elegance. Featuring 12th Gen Intel Core i7 processor and near-borderless InfinityEdge display.',
          'specs': {
            'display': '13.4-inch FHD+ InfinityEdge',
            'cpu': 'Intel Core i7 12th Gen',
            'ram': '16GB LPDDR5 | 512GB NVMe SSD',
            'gpu': 'Intel Iris Xe Graphics',
            'os': 'Windows 11 Home',
            'battery': 'Up to 12 Hours Battery Life',
          },
        };
  }

  List<String> _getImages() {
    List<String> list = [];
    if (_p['images'] is List && (_p['images'] as List).isNotEmpty) {
      for (var item in (_p['images'] as List)) {
        list.add(item.toString());
      }
    } else if (_p['image'] != null) {
      list.add(_p['image'].toString());
    }
    if (list.isEmpty) {
      list.add('assets/image/Laptopphoto.png');
    }
    return list;
  }

  Widget _buildCarouselImage(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        height: 180,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.laptop_mac, size: 100, color: Color(0xFF1565C0)),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF1565C0),
            ),
          );
        },
      );
    } else if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        height: 180,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.laptop_mac, size: 100, color: Color(0xFF1565C0)),
      );
    }
    return const Icon(Icons.laptop_mac, size: 100, color: Color(0xFF1565C0));
  }

  List<Map<String, String>> _getSpecsList() {
    if (_p['specs'] is Map) {
      final m = _p['specs'] as Map;
      List<Map<String, String>> result = [];
      m.forEach((k, v) {
        result.add({'icon': k.toString(), 'text': v.toString()});
      });
      return result;
    }
    final name = (_p['name'] ?? '').toString();
    if (name.contains('Apple') || name.contains('MacBook')) {
      return [
        {'icon': 'display', 'text': '13.6" Liquid Retina True Tone Display'},
        {'icon': 'cpu', 'text': 'Apple M2 8-Core CPU'},
        {'icon': 'memory', 'text': '8GB Unified RAM | 256GB / 512GB SSD'},
        {'icon': 'gpu', 'text': 'Apple 8-Core / 10-Core GPU'},
        {'icon': 'os', 'text': 'macOS Sequoia'},
      ];
    }
    return [
      {'icon': 'display', 'text': '15.6" FHD Anti-Glare Display (1920x1080)'},
      {'icon': 'cpu', 'text': 'Intel Core i5 / AMD Ryzen 5 High Performance'},
      {'icon': 'memory', 'text': '16GB High Speed DDR4 | 512GB PCIe SSD'},
      {'icon': 'gpu', 'text': 'Intel Iris Xe / AMD Radeon Graphics'},
      {'icon': 'os', 'text': 'Windows 11 Home 64-bit'},
    ];
  }

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Hamza A.',
      'rating': 5,
      'comment':
          'Exceptional build quality and crystal clear screen! Best purchase for my work.',
      'date': '2 days ago',
    },
    {
      'name': 'Ali Raza',
      'rating': 5,
      'comment':
          'Super fast shipping and product is 100% genuine with warranty support.',
      'date': '1 week ago',
    },
    {
      'name': 'Sarah Khan',
      'rating': 4,
      'comment':
          'Very sleek and lightweight design. Battery easily lasts full day.',
      'date': '2 weeks ago',
    },
  ];

  IconData _specIcon(String key) {
    key = key.toLowerCase();
    if (key.contains('display') || key.contains('screen')) return Icons.monitor;
    if (key.contains('cpu') || key.contains('processor')) return Icons.memory;
    if (key.contains('memory') ||
        key.contains('ram') ||
        key.contains('storage')) return Icons.storage;
    if (key.contains('gpu') || key.contains('graphics')) return Icons.image;
    if (key.contains('os') || key.contains('operating')) return Icons.window;
    if (key.contains('battery')) return Icons.battery_charging_full;
    return Icons.check_circle_outline;
  }

  void _handleAddToCart() async {
    setState(() => _addedToCart = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${_p['name']} (x$_quantity) added to cart!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _addedToCart = false);
  }

  @override
  Widget build(BuildContext context) {
    final images = _getImages();
    final specs = _getSpecsList();

    String priceStr = '';
    if (_p['price'] != null) {
      priceStr = '₹${_p['price']}';
    } else if (_p['displayPrice'] != null) {
      priceStr = _p['displayPrice'].toString();
    } else {
      priceStr = '₹79,990';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildTopNav()),
              SliverToBoxAdapter(child: _buildImageCarousel(images)),
              SliverToBoxAdapter(child: _buildProductInfo(priceStr)),
              SliverToBoxAdapter(child: _buildQuantityRow()),
              SliverToBoxAdapter(child: _buildSpecs(specs)),
              SliverToBoxAdapter(child: _buildDescription()),
              SliverToBoxAdapter(child: _buildReviews()),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNav() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            _circleButton(
              Icons.arrow_back,
              () => Navigator.maybePop(context),
            ),
            const Spacer(),
            _circleButton(
              _inWishlist ? Icons.favorite : Icons.favorite_border,
              () {
                setState(() => _inWishlist = !_inWishlist);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _inWishlist
                          ? 'Added to your Wishlist'
                          : 'Removed from Wishlist',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              iconColor: _inWishlist ? Colors.red : null,
            ),
            const SizedBox(width: 10),
            _circleButton(
              Icons.shopping_cart_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap, {Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF0F4F8),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Center(
            child: _buildCarouselImage(images[_activeImage % images.length]),
          ),
          if (images.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  final isActive = _activeImage == i;
                  return GestureDetector(
                    onTap: () => setState(() => _activeImage = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFC5D5EA),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(String priceStr) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_p['brand'] != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F0FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _p['brand'].toString().toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF1565C0),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Text(
                      _p['name']?.toString() ?? 'Laptop',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'In Stock',
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                priceStr,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1565C0),
                ),
              ),
              if (_p['discountPrice'] != null) ...[
                const SizedBox(width: 10),
                Text(
                  '₹${_p['discountPrice']}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 20),
              const SizedBox(width: 4),
              Text(
                '${_p['rating'] ?? 4.5}',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              const SizedBox(width: 6),
              Text(
                '(120 Verified Customer Reviews)',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: Color(0xFFF0F0F0)),
          ),
        ),
        child: Row(
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF555555),
              ),
            ),
            const SizedBox(width: 16),
            _qtyButton(
              Icons.remove,
              () => setState(() {
                if (_quantity > 1) _quantity--;
              }),
              filled: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$_quantity',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _qtyButton(
              Icons.add,
              () => setState(() => _quantity++),
              filled: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, {required bool filled}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? const Color(0xFF1565C0) : Colors.white,
          border: Border.all(
            color: filled ? const Color(0xFF1565C0) : const Color(0xFFD0D5DD),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildSpecs(List<Map<String, String>> specs) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Key Specifications',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 12),
          ...specs.map((spec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F0FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _specIcon(spec['icon'] ?? ''),
                      size: 18,
                      color: const Color(0xFF1565C0),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      spec['text'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    final desc = _p['description']?.toString() ??
        'Experience high-performance computing, vibrant crystal display, long battery life, and lightweight portable ergonomics with this premium laptop.';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF555555),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Write Review',
                  style: TextStyle(
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ..._reviews.map(
            (review) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        review['date'] as String,
                        style: const TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < (review['rating'] as int)
                            ? Icons.star
                            : Icons.star_border,
                        size: 14,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    review['comment'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE8EAF0))),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1565C0),
                side: const BorderSide(color: Color(0xFF1565C0), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _addedToCart ? null : _handleAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: _addedToCart
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _addedToCart ? Icons.check : Icons.shopping_cart_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _addedToCart ? 'Added!' : 'Add to Cart',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
