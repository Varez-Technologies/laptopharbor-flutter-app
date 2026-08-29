import 'package:flutter/foundation.dart';

class WishlistManager {
  static final WishlistManager instance = WishlistManager._internal();
  WishlistManager._internal();

  final List<Map<String, dynamic>> items = [
    {
      'id': 'apple-macbook-air-m2',
      'name': 'MacBook Air M2',
      'price': 109990,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    },
    {
      'id': 'dell-xps-13',
      'name': 'Dell XPS 13',
      'price': 99990,
      'rating': 4.5,
      'image': 'assets/image/laptop05.webp',
    },
  ];

  final ValueNotifier<int> wishlistCountNotifier = ValueNotifier<int>(2);

  bool isInWishlist(String id, String name) {
    return items.any((item) => item['id']?.toString() == id || item['name']?.toString() == name);
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final id = product['id']?.toString() ?? product['name']?.toString() ?? '';
    final name = product['name']?.toString() ?? '';

    final index = items.indexWhere((item) => item['id']?.toString() == id || item['name']?.toString() == name);
    if (index >= 0) {
      items.removeAt(index);
    } else {
      String image = 'assets/image/laptop01.webp';
      if (product['images'] is List && (product['images'] as List).isNotEmpty) {
        image = (product['images'] as List).first.toString();
      } else if (product['image'] != null) {
        image = product['image'].toString();
      }

      items.add({
        'id': id,
        'name': name,
        'price': product['price'] ?? 69990,
        'rating': product['rating'] ?? 4.5,
        'image': image,
      });
    }
    wishlistCountNotifier.value = items.length;
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      wishlistCountNotifier.value = items.length;
    }
  }

  void removeById(String id) {
    items.removeWhere((item) => item['id']?.toString() == id || item['name']?.toString() == id);
    wishlistCountNotifier.value = items.length;
  }
}
