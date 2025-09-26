import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../providers/product_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
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
              onChanged: (value) {
                Provider.of<ProductProvider>(context, listen: false)
                    .searchProducts(value);
              },
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 800;

          return Row(
            children: [
              if (isWeb) ...[
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  child: _buildFilters(),
                ),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                child: Column(
                  children: [
                    _buildSortAndFilter(isWeb),
                    Expanded(child: _buildProductGrid(isWeb)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...productProvider.categories.map((category) {
              return ListTile(
                title: Text(category),
                leading: Radio<String>(
                  value: category,
                  groupValue: productProvider.selectedCategory,
                  onChanged: (value) {
                    if (value != null) {
                      productProvider.setCategory(value);
                    }
                  },
                ),
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildSortAndFilter(bool isWeb) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (!isWeb) ...[
            OutlinedButton.icon(
              onPressed: _showFilterBottomSheet,
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return DropdownButton<String>(
                  value: 'name',
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'name', child: Text('Sort by Name')),
                    DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                    DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                    DropdownMenuItem(value: 'rating', child: Text('Highest Rated')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      productProvider.sortProducts(value);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(bool isWeb) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final products = productProvider.products;

        if (products.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppColors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No products found',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWeb ? 3 : 2,
            ),
            itemCount: products.length,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        product: products[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter by Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildFilters(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
