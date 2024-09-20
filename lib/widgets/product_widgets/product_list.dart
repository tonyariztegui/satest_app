import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function(String, double, String) onProductTap;
  final Set<String> favorites;
  final Set<String> basket;
  final Function(String) toggleFavorite;
  final Function(String) toggleBasket;

  ProductList({
    required this.products,
    required this.onProductTap,
    required this.favorites,
    required this.basket,
    required this.toggleFavorite,
    required this.toggleBasket,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final product = products[index];
        final productName = product['title']!;
        final productPrice = product['price']!;
        final productImage = product['image']!;

        return GestureDetector(
          onTap: () => onProductTap(
              productName, double.parse(productPrice.replaceAll('€', '').trim()), productImage),
          child: GridTile(
            child: Image.asset(productImage, fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(productName),
              subtitle: Text(productPrice),
              trailing: IconButton(
                icon: Icon(
                  favorites.contains(productName)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => toggleFavorite(productName),
              ),
              leading: IconButton(
                icon: Icon(
                  basket.contains(productName)
                      ? Icons.shopping_cart
                      : Icons.add_shopping_cart,
                  color: Colors.orange,
                ),
                onPressed: () => toggleBasket(productName),
              ),
            ),
          ),
        );
      },
    );
  }
}
