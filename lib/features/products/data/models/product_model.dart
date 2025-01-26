import 'package:onr_technical_test/features/products/data/models/rating_model.dart';
import 'package:onr_technical_test/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    super.title,
    super.description,
    super.rating,
    super.image,
    super.category,
    super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
      description: json['description'],
      rating: RatingModel.fromJson(json['rating']));

  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        title: title,
        image: image,
        description: description,
        price: price,
        category: category,
        rating: rating);
  }
}
