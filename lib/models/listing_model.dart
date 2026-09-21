class ListingModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;
  final String? sellerId;

  const ListingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
    this.sellerId,
  });

  factory ListingModel.fromMap(Map<String, dynamic> map) {
    return ListingModel(
      id: (map['id'] ?? '').toString(),
      title: (map['title'] ?? map['name'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      price: double.tryParse((map['price'] ?? 0).toString()) ?? 0,
      imageUrl: map['image_url']?.toString(),
      sellerId: map['seller_id']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'image_url': imageUrl,
    'seller_id': sellerId,
  };
}
