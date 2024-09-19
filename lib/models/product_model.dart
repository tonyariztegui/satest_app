class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final int quantity;
  final bool isInFavorites;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.quantity = 1, // Valeur par défaut
    this.isInFavorites = false, // Valeur par défaut
  });

  // Méthode pour cloner le produit avec de nouveaux paramètres, utile pour mettre à jour
  ProductModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? category,
    int? quantity,
    bool? isInFavorites,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      isInFavorites: isInFavorites ?? this.isInFavorites,
    );
  }
}
