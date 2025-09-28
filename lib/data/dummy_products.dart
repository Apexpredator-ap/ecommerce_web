import '../models/product.dart';

class DummyProducts {
  static List<Product> products = [
    // Necklaces
    Product(
      id: '1',
      name: 'Gold Pendant Necklace',
      description: 'Elegant 18k gold pendant necklace for all occasions',
      price: 249.99,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.7,
      reviews: 120,
    ),
    Product(
      id: '2',
      name: 'Pearl Choker Necklace',
      description: 'Classic pearl choker necklace with adjustable clasp',
      price: 179.99,
      imageUrl: 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.5,
      reviews: 95,
    ),
    Product(
      id: '3',
      name: 'Diamond Heart Necklace',
      description: 'Sparkling diamond heart pendant on a sterling silver chain',
      price: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.8,
      reviews: 80,
    ),
    Product(
      id: '4',
      name: 'Layered Gold Necklace',
      description: 'Trendy layered gold necklace set for everyday wear',
      price: 129.99,
      imageUrl: 'https://images.unsplash.com/photo-1602751584552-8ba73aad10e1?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.6,
      reviews: 65,
    ),
    Product(
      id: '5',
      name: 'Silver Infinity Necklace',
      description: 'Infinity symbol necklace in sterling silver',
      price: 99.99,
      imageUrl: 'https://images.unsplash.com/photo-1611652022419-a9419f74343d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.4,
      reviews: 72,
    ),

    // Earrings
    Product(
      id: '6',
      name: 'Gold Hoop Earrings',
      description: 'Classic medium-sized gold hoop earrings',
      price: 79.99,
      imageUrl: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.5,
      reviews: 88,
    ),
    Product(
      id: '7',
      name: 'Silver Stud Earrings',
      description: 'Elegant silver stud earrings with crystal detail',
      price: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.6,
      reviews: 60,
    ),
    Product(
      id: '8',
      name: 'Pearl Drop Earrings',
      description: 'Beautiful pearl drop earrings for formal occasions',
      price: 99.99,
      imageUrl: 'https://images.unsplash.com/photo-1588444837495-c6cfeb53f32d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.7,
      reviews: 55,
    ),
    Product(
      id: '9',
      name: 'Diamond Stud Earrings',
      description: 'Classic sparkling diamond stud earrings',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1603561591411-07134e71a2a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.9,
      reviews: 48,
    ),
    Product(
      id: '10',
      name: 'Gold Huggie Earrings',
      description: 'Small gold huggie earrings perfect for everyday wear',
      price: 69.99,
      imageUrl: 'https://images.unsplash.com/photo-1611652022471-9dfb65faa9d1?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.5,
      reviews: 52,
    ),

    // More Necklaces
    Product(
      id: '11',
      name: 'Rose Gold Necklace',
      description: 'Stylish rose gold necklace with minimalist pendant',
      price: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.6,
      reviews: 44,
    ),
    Product(
      id: '12',
      name: 'Charm Necklace Set',
      description: 'Set of 3 charm necklaces for layering',
      price: 139.99,
      imageUrl: 'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Necklaces',
      rating: 4.5,
      reviews: 33,
    ),

    // More Earrings
    Product(
      id: '13',
      name: 'Crystal Drop Earrings',
      description: 'Elegant crystal drop earrings for parties',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1588444837495-c6cfeb53f32d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.4,
      reviews: 29,
    ),
    Product(
      id: '14',
      name: 'Gold Pearl Earrings',
      description: 'Pearl earrings with gold trim for classy look',
      price: 109.99,
      imageUrl: 'https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.6,
      reviews: 31,
    ),
    Product(
      id: '15',
      name: 'Silver Hoop Earrings',
      description: 'Thin silver hoop earrings for casual wear',
      price: 59.99,
      imageUrl: 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
      category: 'Earrings',
      rating: 4.3,
      reviews: 40,
    ),
  ];

  static List<String> categories = [
    'All',
    'Necklaces',
    'Earrings',
  ];

  static List<Product> getProductsByCategory(String category) {
    if (category == 'All') return products;
    return products.where((product) => product.category == category).toList();
  }
}