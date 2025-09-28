import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/carousal.dart';
import '../profile/profile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = HomeScreenController();
    _controller.loadProducts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.lightGrey,
        endDrawer: const ProfileDrawer(),
        appBar: _buildAppBar(),
        body: Consumer<HomeScreenController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(),
                  const SizedBox(height: 25),
                  _buildFeaturedSection(),
                  const SizedBox(height: 30),
                  _buildCategoriesSection(),
                  const SizedBox(height: 30),
                  _buildNecklacesSection(),
                  const SizedBox(height: 30),
                  _buildEarringsSection(),
                  const SizedBox(height: 30),
                  _buildCustomerReviewsSection(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [AppColors.accent, AppColors.primary],
        ).createShader(bounds),
        child: const Text(
          'Samridhi Jewelry',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.primary,
              ),
            ),
            onPressed: _controller.onNotificationsTap,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.search,
                color: AppColors.accent,
              ),
            ),
            onPressed: _controller.onSearchTap,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: auth.userName != null
                        ? Center(
                      child: Text(
                        auth.userName!.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                        : const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, AppColors.lightGreen],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        auth.userName ?? 'Jewelry Lover',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accent, Color(0xFFFFD700)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.diamond,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.background],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Exclusive Collection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Handcrafted jewelry pieces\njust for you',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: _controller.onExploreNowTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Explore Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppColors.accent,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Consumer<HomeScreenController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HomeWidgetFactory.buildSectionHeader(
                title: 'Featured Collection',
                icon: Icons.star,
                gradient: const LinearGradient(
                  colors: [AppColors.accent, Color(0xFFFFD700)],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 160,
              child: FeaturedCarousel(products: controller.featuredProducts),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    return Consumer<HomeScreenController>(
      builder: (context, controller, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeWidgetFactory.buildSectionHeader(
                title: 'Shop by Category',
                icon: Icons.category,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.background],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: HomeWidgetFactory.buildCategoryCard(
                      'Necklaces',
                      Icons.favorite,
                      const LinearGradient(
                        colors: [Color(0xFFFF6B9D), Color(0xFFF06292)],
                      ),
                      controller.necklaces.length,
                          () => controller.onCategoryTap('Necklaces'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: HomeWidgetFactory.buildCategoryCard(
                      'Earrings',
                      Icons.diamond,
                      const LinearGradient(
                        colors: [AppColors.accent, Color(0xFFFFD700)],
                      ),
                      controller.earrings.length,
                          () => controller.onCategoryTap('Earrings'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNecklacesSection() {
    return Consumer<HomeScreenController>(
      builder: (context, controller, child) {
        return HomeWidgetFactory.buildProductSection(
          title: 'Elegant Necklaces',
          icon: Icons.favorite,
          products: controller.necklaces,
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B9D), Color(0xFFF06292)],
          ),
          onViewAllTap: () => controller.onCategoryTap('Necklaces'),
          onProductTap: controller.onProductTap,
          onFavoriteTap: controller.toggleFavorite,
          onAddToCartTap: controller.addToCart,
        );
      },
    );
  }

  Widget _buildEarringsSection() {
    return Consumer<HomeScreenController>(
      builder: (context, controller, child) {
        return HomeWidgetFactory.buildProductSection(
          title: 'Beautiful Earrings',
          icon: Icons.diamond,
          products: controller.earrings,
          gradient: const LinearGradient(
            colors: [AppColors.accent, Color(0xFFFFD700)],
          ),
          onViewAllTap: () => controller.onCategoryTap('Earrings'),
          onProductTap: controller.onProductTap,
          onFavoriteTap: controller.toggleFavorite,
          onAddToCartTap: controller.addToCart,
        );
      },
    );
  }

  Widget _buildCustomerReviewsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeWidgetFactory.buildSectionHeader(
            title: 'Customer Reviews',
            icon: Icons.reviews,
            gradient: const LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, AppColors.lightGreen],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.accent,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aarti Sharma',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                                  (index) => const Icon(
                                Icons.star,
                                color: AppColors.accent,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  '"Amazing quality jewelry! The necklace I bought is absolutely stunning and the craftsmanship is excellent. Highly recommend!"',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}