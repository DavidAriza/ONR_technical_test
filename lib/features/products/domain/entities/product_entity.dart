import 'package:equatable/equatable.dart';
import 'package:onr_technical_test/features/products/domain/entities/rating_entity.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingEntity? rating;

  const ProductEntity(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  @override
  List<Object?> get props =>
      <Object?>[id, title, price, description, category, image, rating];
}
