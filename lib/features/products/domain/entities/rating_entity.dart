import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final num? rate;
  final int? count;

  const RatingEntity({this.rate, this.count});

  @override
  List<Object?> get props => <Object?>[rate, count];
}
