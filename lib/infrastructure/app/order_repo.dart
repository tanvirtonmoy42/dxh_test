import 'package:dxh_test/domain/app/order/i_order_repo.dart';
import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OrderRepo extends IOrderRepo {
  @override
  placeOrder({required OrderModel order}) async {
    final box = await Hive.openBox<OrderModel>('orders');
    box.add(order);
  }

  @override
  Future<IList<OrderModel>> getAllOrder() async {
    final box = await Hive.openBox<OrderModel>('orders');
    return box.values.toIList();
  }
}
