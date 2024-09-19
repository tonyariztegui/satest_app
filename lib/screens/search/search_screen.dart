import 'package:flutter/material.dart';
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Importer le widget
import 'package:satest_app/screens/search/product_detail_screen.dart'; // Assurez-vous que le chemin est correct

class SearchScreen extends StatefulWidget {
  final String? username; // Ajouter cette variable pour vérifier si l'utilisateur est connecté

  SearchScreen({this.username});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';
  String selectedFilter = 'All'; // Définir la variable selectedFilter
  List<String> categories = ['Women', 'Men', 'Accessories'];

  // Exemple de produits
  List<Map<String, dynamic>> products = [
    {
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'name': 'T-Shirt',
      'price': 20.00,
      'category': 'Women',
      'brand': 'Nike',
    },
    {
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'name': 'Sneakers',
      'price': 50.00,
      'category': 'Men',
      'brand': 'Adidas',
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // Au début, tous les produits sont affichés
    filteredProducts = products;
  }

  void _filterProducts(String query) {
    List<Map<String, dynamic>> tempProducts = products.where((product) {
      return product['name'].toLowerCase().contains(query.toLowerCase()) ||
             product['category'].toLowerCase().contains(query.toLowerCase()) ||
             product['brand'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = tempProducts;
    });
  }

  void _navigateToProductDescription(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDescriptionScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products',
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  _filterProducts(query); // Mise à jour de la recherche
                },
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Enlève le bouton "Back"
      ),

      body: Column(
        children: [
          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                      _filterProducts(category); // Filtrer par catégorie
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedCategory == category
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: selectedCategory == category
                            ? Colors.white
                            : Colors.black,
                        fontWeight: selectedCategory == category
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Filters Section
          ExpansionTile(
            title: Text(
              'Filter',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              _buildFilterOption('Brand'),
              _buildFilterOption('Type of item'),
              _buildFilterOption('Size'),
              _buildFilterOption('Color'),
              _buildFilterOption('Price (Low to High)'),
              _buildFilterOption('Price (High to Low)'),
              _buildFilterOption('Promotions'),
              _buildFilterOption('New Arrivals'),
            ],
          ),

          // Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Adjust height to fit buttons
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _navigateToProductDescription(filteredProducts[index]),
                  child: _buildProductTile(filteredProducts[index]),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavigationBar(username: widget.username), // Utiliser le widget personnalisé
    );
  }

  Widget _buildProductTile(Map<String, dynamic> product) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  product['image'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product['name'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '€${product['price']}',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Action pour ajouter au panier
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Action pour ajouter aux favoris
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String filterName) {
    return ListTile(
      title: Text(filterName),
      onTap: () {
        setState(() {
          selectedFilter = filterName; // Mise à jour du filtre sélectionné
          // Logique de filtrage à ajouter
        });
      },
    );
  }
}
