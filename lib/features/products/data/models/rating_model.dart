import 'package:onr_technical_test/features/products/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel({super.rate, super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json['rate'],
        count: json['count'],
      );

  RatingEntity toEntity() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }
}
