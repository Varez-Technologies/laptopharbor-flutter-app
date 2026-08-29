import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _activeImage = 0;
  bool _inWishlist = false;
  bool _addedToCart = false;
  bool _showFullDesc = false;
  int _quantity = 1;

  final List<Map<String, String>> _specs = [
    {'icon': 'display', 'text': '13.4-inch FHD+ Display'},
    {'icon': 'cpu', 'text': 'Intel Core i7 12th Gen'},
    {'icon': 'memory', 'text': '16GB RAM | 512GB SSD'},
    {'icon': 'gpu', 'text': 'Intel Iris Xe Graphics'},
    {'icon': 'os', 'text': 'Windows 11 Home'},
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Rahul M.',
      'rating': 5,
      'comment':
          'Excellent build quality and display! Best laptop I have owned.',
      'date': '2 days ago',
    },
    {
      'name': 'Priya S.',
      'rating': 4,
      'comment': 'Great performance but battery could be better.',
      'date': '1 week ago',
    },
    {
      'name': 'Amit K.',
      'rating': 5,
      'comment': 'Superb ultrabook. Very fast and sleek design.',
      'date': '2 weeks ago',
    },
  ];

  IconData _specIcon(String key) {
    switch (key) {
      case 'display':
        return Icons.monitor;
      case 'cpu':
        return Icons.memory;
      case 'memory':
        return Icons.storage;
      case 'gpu':
        return Icons.image;
      case 'os':
        return Icons.window;
      default:
        return Icons.check_circle_outline;
    }
  }

  void _handleAddToCart() async {
    setState(() => _addedToCart = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _addedToCart = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildTopNav()),
              SliverToBoxAdapter(child: _buildImageCarousel()),
              SliverToBoxAdapter(child: _buildProductInfo()),
              SliverToBoxAdapter(child: _buildQuantityRow()),
              SliverToBoxAdapter(child: _buildSpecs()),
              SliverToBoxAdapter(child: _buildDescription()),
              SliverToBoxAdapter(child: _buildReviews()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
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
            _circleButton(Icons.arrow_back, () => Navigator.maybePop(context)),
            const Spacer(),
            _circleButton(
              _inWishlist ? Icons.favorite : Icons.favorite_border,
              () => setState(() => _inWishlist = !_inWishlist),
              iconColor: _inWishlist ? Colors.red : null,
            ),
            const SizedBox(width: 10),
            _circleButton(Icons.share_outlined, () {}),
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
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4F8),
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

  Widget _buildImageCarousel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 210,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.laptop_mac,
              size: 160,
              color: const Color(0xFF1A2A4A),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
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

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Dell XPS 13',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    height: 1.2,
                  ),
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
          const Text(
            '₹99,990',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 20),
              const SizedBox(width: 4),
              const Text(
                '4.5',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              const SizedBox(width: 6),
              Text(
                '(120 Reviews)',
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

  Widget _buildSpecs() {
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

          ..._specs.map((spec) {
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    const fullText =
        'The Dell XPS 13 is a high-performance laptop that combines power, portability, and elegance. Featuring the latest 12th Gen Intel Core i7 processor, this ultrabook delivers exceptional speed and responsiveness for both work and creative tasks. The stunning 13.4-inch FHD+ display provides an immersive viewing experience with near-borderless design.';
    const shortText =
        'The Dell XPS 13 is a high-performance laptop that combines power, portability, and elegance...';

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
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
                height: 1.7,
              ),
              children: [
                TextSpan(text: _showFullDesc ? fullText : shortText),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => setState(() => _showFullDesc = !_showFullDesc),
                    child: Text(
                      _showFullDesc ? ' less' : ' more',
                      style: const TextStyle(
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
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
                  'View All',
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
              onPressed: () => setState(() => _inWishlist = !_inWishlist),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1565C0),
                side: const BorderSide(color: Color(0xFF1565C0), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _inWishlist ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _inWishlist ? 'Wishlisted' : 'Add to Wishlist',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
          ),
        ],
      ),
    );
  }
}
