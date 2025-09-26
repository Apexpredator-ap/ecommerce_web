import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  List<String> _wishlistIds = [];

  List<String> get wishlistIds => _wishlistIds;

  void toggleWishlist(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  bool isInWishlist(String productId) {
    return _wishlistIds.contains(productId);
  }

  void removeFromWishlist(String productId) {
    _wishlistIds.remove(productId);
    notifyListeners();
  }
}