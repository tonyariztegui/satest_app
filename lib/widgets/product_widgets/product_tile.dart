import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int quantity; // Utilisé pour la page panier
  final bool isInFavorites; // Pour vérifier si le produit est dans les favoris
  final VoidCallback? onTap; // Action lorsqu'on appuie sur le produit
  final VoidCallback? onCartPressed; // Ajouter au panier
  final VoidCallback? onFavoritePressed; // Ajouter ou retirer des favoris
  final ValueChanged<int>? onQuantityChange; // Changer la quantité dans le panier
  final VoidCallback? onDeletePressed; // Supprimer l'article du panier

  const ProductTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity = 1,
    this.isInFavorites = false,
    this.onTap,
    this.onCartPressed,
    this.onFavoritePressed,
    this.onQuantityChange,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Image du produit
              Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              // Détails du produit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    if (onQuantityChange != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                onQuantityChange!(quantity - 1);
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              onQuantityChange!(quantity + 1);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Actions pour ajouter au panier, aimer ou supprimer
              Column(
                children: [
                  if (onCartPressed != null)
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: onCartPressed,
                    ),
                  if (onFavoritePressed != null)
                    IconButton(
                      icon: Icon(
                        isInFavorites ? Icons.favorite : Icons.favorite_border,
                        color: isInFavorites ? Colors.red : null,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  if (onDeletePressed != null)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDeletePressed,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
