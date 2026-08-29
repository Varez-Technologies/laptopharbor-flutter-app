import 'package:flutter/foundation.dart';

class CartProduct {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartManager {
  static final CartManager instance = CartManager._internal();
  CartManager._internal();

  final List<CartProduct> items = [
    CartProduct(
      id: 'macbook-air-m2',
      name: 'MacBook Air M2',
      price: 109990,
      image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      quantity: 1,
    ),
  ];

  final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(1);

  void addItem(Map<String, dynamic> product, {int quantity = 1}) {
    final id = product['id']?.toString() ?? product['name']?.toString() ?? 'item-${DateTime.now().millisecondsSinceEpoch}';
    final name = product['name']?.toString() ?? 'Laptop';
    
    double price = 69990;
    if (product['price'] != null) {
      if (product['price'] is num) {
        price = (product['price'] as num).toDouble();
      } else {
        price = double.tryParse(product['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 69990;
      }
    }

    String image = 'assets/image/laptop01.webp';
    if (product['images'] is List && (product['images'] as List).isNotEmpty) {
      image = (product['images'] as List).first.toString();
    } else if (product['image'] != null) {
      image = product['image'].toString();
    }

    final existingIndex = items.indexWhere((item) => item.id == id || item.name == name);
    if (existingIndex >= 0) {
      items[existingIndex].quantity += quantity;
    } else {
      items.add(CartProduct(
        id: id,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
      ));
    }
    _updateCount();
  }

  void updateQuantity(int index, int newQty) {
    if (index >= 0 && index < items.length) {
      if (newQty <= 0) {
        items.removeAt(index);
      } else {
        items[index].quantity = newQty;
      }
      _updateCount();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      _updateCount();
    }
  }

  void clearCart() {
    items.clear();
    _updateCount();
  }

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get taxAmount {
    return subtotal * 0.18;
  }

  double get shippingCharges {
    return items.isEmpty ? 0.0 : (subtotal > 50000 ? 0.0 : 50.0);
  }

  double get totalAmount {
    if (items.isEmpty) return 0.0;
    return subtotal + shippingCharges + taxAmount;
  }

  int get totalItemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  void _updateCount() {
    cartCountNotifier.value = totalItemsCount;
  }
}
