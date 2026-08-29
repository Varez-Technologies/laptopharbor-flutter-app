import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final name = _nameController.text.trim();
      final brand = _brandController.text.trim();
      final price = double.tryParse(_priceController.text.trim()) ?? 49990;
      final stock = int.tryParse(_stockController.text.trim()) ?? 10;
      final desc = _descController.text.trim();
      String imageUrl = _imageUrlController.text.trim();
      if (imageUrl.isEmpty) {
        imageUrl = 'assets/image/laptop01.webp';
      }

      final docId = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '-');

      await FirebaseFirestore.instance.collection('products').doc(docId).set({
        'name': name,
        'brand': brand.isNotEmpty ? brand : 'Dell',
        'categoryId': brand.toLowerCase(),
        'price': price,
        'discountPrice': price * 0.95,
        'stock': stock,
        'rating': 4.5,
        'isActive': true,
        'image': imageUrl,
        'images': [imageUrl],
        'description': desc.isNotEmpty ? desc : 'High performance laptop with advanced processor and display.',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully to Firestore!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2D0C8B),
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                child: const Column(
                  children: [
                    Text(
                      'Create New Product',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Directly adds product to Cloud Firestore catalog',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    _buildField(_nameController, 'Product Name (e.g. Dell XPS 15)', Icons.shopping_bag_outlined),
                    const SizedBox(height: 16),
                    _buildField(_brandController, 'Brand (e.g. Dell, HP, Apple, Lenovo, Asus)', Icons.category_outlined),
                    const SizedBox(height: 16),
                    _buildField(_priceController, 'Price (INR)', Icons.currency_rupee, isNumber: true),
                    const SizedBox(height: 16),
                    _buildField(_stockController, 'Stock Quantity', Icons.inventory_2_outlined, isNumber: true),
                    const SizedBox(height: 16),
                    _buildField(_imageUrlController, 'Image URL (or leave blank for asset)', Icons.image_outlined, isRequired: false),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextFormField(
                        controller: _descController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Product Description & Specifications',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2D0C8B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: _isLoading ? null : _saveProduct,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save_outlined, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    'Save to Firestore',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String hint, IconData icon, {bool isNumber = false, bool isRequired = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (v) {
          if (isRequired && (v == null || v.trim().isEmpty)) {
            return 'Please enter value';
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.deepPurple),
          hintText: hint,
        ),
      ),
    );
  }
}