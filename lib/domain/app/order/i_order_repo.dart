import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class IOrderRepo {
  placeOrder({required OrderModel order});
  Future<IList<OrderModel>> getAllOrder();
}
