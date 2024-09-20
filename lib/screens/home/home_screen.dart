import 'package:flutter/material.dart';
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:satest_app/widgets/product_widgets/category_tabs.dart';
import 'package:satest_app/widgets/product_widgets/filter_tabs.dart';
import 'package:satest_app/widgets/product_widgets/product_list.dart';

class HomeScreen extends StatefulWidget {
  final String? username;

  const HomeScreen({super.key, this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  String _selectedFilter = 'Popular';
  String _selectedSubCategory = 'All';
  String? _username;

  String _categoryImage = 'assets/images/default_category.png';

  final List<String> _mainCategories = ['Women', 'Men', 'Accessories'];
  final List<String> _filters = ['Popular', 'New', 'Promotions'];
  final Map<String, List<String>> _subCategories = {
    'Women': ['All', 'T-Shirt', 'Sweat', 'Dress'],
    'Men': ['All', 'T-Shirt', 'Sweat', 'Jogger'],
    'Accessories': ['All', 'Bag', 'Bottle', 'Hat'],
  };

  List<String> get currentSubCategories => _subCategories[_mainCategories[_selectedCategoryIndex]] ?? [];

  final Map<String, Map<String, List<Map<String, String>>>> _products = {
    'Women': {
      'All': [
        {'title': 'Dress', 'price': '50', 'image': 'lib/assets/images/product_image.png'},
      ],
      'T-Shirt': [
        {'title': 'T-Shirt', 'price': '20', 'image': 'lib/assets/images/product_image.png'},
      ],
    },
    'Men': {
      'All': [
        {'title': 'Jacket', 'price': '100', 'image': 'lib/assets/images/product_image.png'},
      ],
      'Sweat': [
        {'title': 'Sweatshirt', 'price': '40', 'image': 'lib/assets/images/product_image.png'},
      ],
    },
    'Accessories': {
      'All': [
        {'title': 'Bag', 'price': '30', 'image': 'lib/assets/images/product_image.png'},
      ],
      'Hat': [
        {'title': 'Hat', 'price': '15', 'image': 'lib/assets/images/product_image.png'},
      ],
    },
  };

  final Set<String> _favorites = {};
  final Set<String> _basket = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = widget.username ?? prefs.getString('username');
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _selectedSubCategory = 'All';

      switch (_mainCategories[_selectedCategoryIndex]) {
        case 'Women':
          _categoryImage = 'lib/assets/images/product_image.png'; // Correct path
          break;
        case 'Men':
          _categoryImage = 'lib/assets/images/product_image.png'; // Correct path
          break;
        case 'Accessories':
          _categoryImage = 'lib/assets/images/product_image.png'; // Correct path
          break;
        default:
          _categoryImage = 'lib/assets/images/product_image.png'; // Default path
          break;
      }
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onProductTap(String productName, double productPrice, String productImage) {
    if (_username != null) {
      Navigator.pushNamed(
        context,
        '/product_detail',
        arguments: {
          'name': productName,
          'price': productPrice,
          'image': productImage,
        },
      );
    } else {
      Navigator.pushNamed(context, '/sign_in');
    }
  }

  void _toggleFavorite(String productName) {
    setState(() {
      if (_favorites.contains(productName)) {
        _favorites.remove(productName);
      } else {
        _favorites.add(productName);
      }
    });
  }

  void _toggleBasket(String productName) {
    setState(() {
      if (_basket.contains(productName)) {
        _basket.remove(productName);
      } else {
        _basket.add(productName);
      }
    });
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        if (_username != null) {
          Navigator.pushNamed(context, '/favorites');
        } else {
          Navigator.pushNamed(context, '/sign_in');
        }
        break;
      case 3:
        if (_username != null) {
          Navigator.pushNamed(context, '/basket');
        } else {
          Navigator.pushNamed(context, '/sign_in');
        }
        break;
      case 4:
        if (_username != null) {
          Navigator.pushNamed(context, '/profile', arguments: _username);
        } else {
          Navigator.pushNamed(context, '/sign_in');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = _mainCategories[_selectedCategoryIndex];
    List<Map<String, String>> selectedProducts = _getFilteredProducts(selectedCategory, _selectedSubCategory);

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryTabs(
              selectedCategoryIndex: _selectedCategoryIndex,
              onCategorySelected: _onCategorySelected,
              categories: _mainCategories,
            ),
            if (_categoryImage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Image.asset(
                  _categoryImage,
                  fit: BoxFit.cover,
                ),
              ),
            FilterTabs(
              selectedFilter: _selectedFilter,
              onFilterSelected: _onFilterSelected,
              filters: _filters,
            ),
            ProductList(
              products: selectedProducts,
              onProductTap: _onProductTap,
              favorites: _favorites,
              basket: _basket,
              toggleFavorite: _toggleFavorite,
              toggleBasket: _toggleBasket,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        username: _username,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  List<Map<String, String>> _getFilteredProducts(String category, String subCategory) {
    final categoryProducts = _products[category];

    if (categoryProducts == null) {
      return []; // Return empty list if categoryProducts is null
    }

    if (subCategory == 'All') {
      return categoryProducts.values.expand((e) => e).toList();
    } else {
      return categoryProducts[subCategory] ?? [];
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(Icons.shop, color: Colors.orange),
      title: Text(
        _username != null ? 'Welcome, $_username!' : 'Welcome',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
