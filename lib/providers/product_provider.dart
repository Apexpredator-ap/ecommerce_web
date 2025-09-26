import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_products.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = DummyProducts.products;
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String _sortBy = 'name';

  List<Product> get products => _filteredProducts.isEmpty ? _products : _filteredProducts;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => DummyProducts.categories;

  void setCategory(String category) {
    _selectedCategory = category;
    _filterProducts();
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _filterProducts();
  }

  void sortProducts(String sortBy) {
    _sortBy = sortBy;
    _filterProducts();
  }

  void _filterProducts() {
    List<Product> filtered = DummyProducts.getProductsByCategory(_selectedCategory);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
      product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    switch (_sortBy) {
      case 'price_low':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        filtered.sort((a, b) => a.name.compareTo(b.name));
    }

    _filteredProducts = filtered;
    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}