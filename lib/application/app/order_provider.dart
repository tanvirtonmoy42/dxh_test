import 'package:dxh_test/domain/app/order/i_order_repo.dart';
import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:dxh_test/infrastructure/app/order_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orderRepoProvider = FutureProvider<IOrderRepo>((ref) async {
  return OrderRepo();
});

final orderListProvider = FutureProvider<IList<OrderModel>>((ref) async {
  final repo = await ref.read(orderRepoProvider.future);
  return repo.getAllOrder();
});
