import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:dxh_test/domain/app/product_model.dart';
part 'order_product_model.g.dart';

@HiveType(typeId: 1)
class OrderProductModel extends Equatable {
  @HiveField(0)
  final ProductModel product;
  @HiveField(1)
  final int count;
  const OrderProductModel({
    required this.product,
    required this.count,
  });

  OrderProductModel copyWith({
    ProductModel? product,
    int? count,
  }) {
    return OrderProductModel(
      product: product ?? this.product,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'count': count,
    };
  }

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      product: ProductModel.fromMap(map['product']),
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductModel.fromJson(String source) =>
      OrderProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'OrderProductModel(product: $product, count: $count)';

  @override
  List<Object> get props => [product, count];
}
