import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:dxh_test/domain/app/order/order_product_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<OrderProductModel> products;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final String status;
  const OrderModel({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.status,
  });

  OrderModel copyWith({
    String? id,
    List<OrderProductModel>? products,
    DateTime? createdAt,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      products: List<OrderProductModel>.from(
          map['products']?.map((x) => OrderProductModel.fromMap(x))),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, products: $products, createdAt: $createdAt, status: $status)';
  }

  @override
  List<Object> get props => [id, products, createdAt, status];
}
