import 'package:flutter/material.dart';
import '../../data/dummy_products.dart';
import '../../models/product.dart';
import '../../utils/colors.dart';

class HomeScreenController with ChangeNotifier {
  String _selectedCategory = 'All';
  List<Product> _featuredProducts = [];
  List<Product> _necklaces = [];
  List<Product> _earrings = [];
  bool _isLoading = false;

  // Getters
  String get selectedCategory => _selectedCategory;
  List<Product> get featuredProducts => _featuredProducts;
  List<Product> get necklaces => _necklaces;
  List<Product> get earrings => _earrings;
  bool get isLoading => _isLoading;

  // Initialize data
  void loadProducts() {
    _setLoading(true);

    try {
      _featuredProducts = DummyProducts.products.take(6).toList();
      _necklaces = DummyProducts.getProductsByCategory('Necklaces').take(5).toList();
      _earrings = DummyProducts.getProductsByCategory('Earrings').take(5).toList();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update selected category
  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Private method to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Handle category tap
  void onCategoryTap(String categoryName) {
    // Navigate to category page or filter products
    print('Category tapped: $categoryName');
    // TODO: Implement navigation to category page
  }

  // Handle product tap
  void onProductTap(Product product) {
    print('Product tapped: ${product.name}');
    // TODO: Implement navigation to product detail page
  }

  // Handle search
  void onSearchTap() {
    print('Search tapped');
    // TODO: Implement search functionality
  }

  // Handle notifications
  void onNotificationsTap() {
    print('Notifications tapped');
    // TODO: Implement notifications page
  }

  // Handle favorite toggle
  void toggleFavorite(Product product) {
    print('Toggling favorite for: ${product.name}');
    // TODO: Implement favorite functionality
  }

  // Handle add to cart
  void addToCart(Product product) {
    print('Adding to cart: ${product.name}');
    // TODO: Implement add to cart functionality
  }

  // Handle explore now button
  void onExploreNowTap() {
    print('Explore now tapped');
    // TODO: Navigate to featured collection or products page
  }
}

// Widget Factory for building UI components
class HomeWidgetFactory {
  static Widget buildCategoryCard(
      String title,
      IconData icon,
      Gradient gradient,
      int itemCount,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.3),
                size: 60,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$itemCount items',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildProductCard(
      Product product,
      Gradient gradient,
      {
        required VoidCallback onTap,
        required VoidCallback onFavoriteTap,
        required VoidCallback onAddToCartTap,
      }
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image section
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Favorite icon
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.accent,
                          size: 14,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${product.rating}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          ' (${product.reviews})',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddToCartTap,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildProductSection({
    required String title,
    required IconData icon,
    required List<Product> products,
    required Gradient gradient,
    required VoidCallback onViewAllTap,
    required Function(Product) onProductTap,
    required Function(Product) onFavoriteTap,
    required Function(Product) onAddToCartTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onViewAllTap,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return buildProductCard(
                product,
                gradient,
                onTap: () => onProductTap(product),
                onFavoriteTap: () => onFavoriteTap(product),
                onAddToCartTap: () => onAddToCartTap(product),
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget buildSectionHeader({
    required String title,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}