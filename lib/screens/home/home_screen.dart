import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail.dart';
import '../shop/shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerController = PageController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 800;

          return CustomScrollView(
            slivers: [
              _buildAppBar(isWeb),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroBanner(),
                    const SizedBox(height: 30),
                    _buildCategories(),
                    const SizedBox(height: 30),
                    _buildFeaturedProducts(isWeb),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(bool isWeb) {
    return SliverAppBar(
      expandedHeight: isWeb ? 80 : 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(16),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.spa,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            if (isWeb) ...[
              const Text(
                'Samridhi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              _buildWebNavigation(),
            ] else
              const Text(
                'Samridhi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.lightGrey,
            ),
            onSubmitted: (value) {
              Provider.of<ProductProvider>(context, listen: false).searchProducts(value);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopScreen()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWebNavigation() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Home', style: TextStyle(color: AppColors.primary)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ShopScreen()),
            );
          },
          child: const Text('Shop', style: TextStyle(color: AppColors.primary)),
        ),
        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return IconButton(
              onPressed: () {
                // Navigate to cart
              },
              icon: cart.itemCount > 0
                  ? Badge.count(
                count: cart.itemCount,
                child: const Icon(Icons.shopping_cart_outlined),
              )
                  : const Icon(Icons.shopping_cart_outlined),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    final banners = [
      {
        'title': 'Summer Sale',
        'subtitle': 'Up to 50% off on selected items',
        'color': AppColors.primary,
        'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
      },
      {
        'title': 'New Arrivals',
        'subtitle': 'Discover the latest trends',
        'color': AppColors.darkGreen,
        'image': 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=800',
      },
    ];

    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: banner['color'] as Color,
                  image: DecorationImage(
                    image: NetworkImage(banner['image'] as String),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      (banner['color'] as Color).withOpacity(0.7),
                      BlendMode.multiply,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      banner['title'] as String,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      banner['subtitle'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ShopScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _bannerController,
                count: banners.length,
                effect: const WormEffect(
                  dotColor: Colors.white30,
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: productProvider.categories.length - 1, // Exclude 'All'
                itemBuilder: (context, index) {
                  final category = productProvider.categories[index + 1];
                  final icons = {
                    'Electronics': Icons.devices,
                    'Fashion': Icons.checkroom,
                    'Home & Garden': Icons.home,
                    'Sports': Icons.sports_soccer,
                  };

                  return GestureDetector(
                    onTap: () {
                      productProvider.setCategory(category);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ShopScreen()),
                      );
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              icons[category] ?? Icons.category,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ShopScreen()),
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            final featuredProducts = productProvider.products.take(6).toList();

            if (isWeb) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: featuredProducts[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              product: featuredProducts[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }

            return SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    child: ProductCard(
                      product: featuredProducts[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              product: featuredProducts[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}