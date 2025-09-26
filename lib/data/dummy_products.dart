import '../models/product.dart';

class DummyProducts {
  static List<Product> products = [
    // Electronics
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium quality wireless headphones with noise cancellation',
      price: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      category: 'Electronics',
      rating: 4.5,
      reviews: 120,
    ),
    Product(
      id: '2',
      name: 'Smartphone',
      description: 'Latest flagship smartphone with advanced camera',
      price: 799.99,
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
      category: 'Electronics',
      rating: 4.3,
      reviews: 89,
    ),
    Product(
      id: '3',
      name: 'Laptop',
      description: 'High-performance laptop for work and gaming',
      price: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
      category: 'Electronics',
      rating: 4.7,
      reviews: 156,
    ),

    // Fashion
    Product(
      id: '4',
      name: 'Designer Jacket',
      description: 'Stylish winter jacket with premium materials',
      price: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500',
      category: 'Fashion',
      rating: 4.2,
      reviews: 67,
    ),
    Product(
      id: '5',
      name: 'Running Shoes',
      description: 'Comfortable running shoes for daily exercise',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
      category: 'Fashion',
      rating: 4.4,
      reviews: 203,
    ),
    Product(
      id: '6',
      name: 'Sunglasses',
      description: 'UV protection sunglasses with stylish design',
      price: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500',
      category: 'Fashion',
      rating: 4.1,
      reviews: 45,
    ),

    // Home & Garden
    Product(
      id: '7',
      name: 'Coffee Maker',
      description: 'Automatic coffee maker for perfect morning brew',
      price: 129.99,
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500',
      category: 'Home & Garden',
      rating: 4.6,
      reviews: 134,
    ),
    Product(
      id: '8',
      name: 'Indoor Plant',
      description: 'Beautiful indoor plant to brighten your space',
      price: 24.99,
      imageUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=500',
      category: 'Home & Garden',
      rating: 4.3,
      reviews: 78,
    ),
    Product(
      id: '9',
      name: 'Table Lamp',
      description: 'Modern LED table lamp with adjustable brightness',
      price: 79.99,
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500',
      category: 'Home & Garden',
      rating: 4.5,
      reviews: 92,
    ),

    // Sports
    Product(
      id: '10',
      name: 'Yoga Mat',
      description: 'Premium yoga mat for comfortable practice',
      price: 39.99,
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500',
      category: 'Sports',
      rating: 4.4,
      reviews: 167,
    ),
    Product(
      id: '11',
      name: 'Dumbbells Set',
      description: 'Adjustable dumbbells for home workout',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=500',
      category: 'Sports',
      rating: 4.6,
      reviews: 234,
    ),
    Product(
      id: '12',
      name: 'Tennis Racket',
      description: 'Professional tennis racket for advanced players',
      price: 149.99,
      imageUrl: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=500',
      category: 'Sports',
      rating: 4.3,
      reviews: 56,
    ),
  ];

  static List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Sports',
  ];

  static List<Product> getProductsByCategory(String category) {
    if (category == 'All') return products;
    return products.where((product) => product.category == category).toList();
  }
}