import 'package:dxh_test/domain/app/cart/i_cart_repo.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:dxh_test/infrastructure/app/cart_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartRepoProvider = FutureProvider<ICartRepo>((ref) async {
  return CartRepo();
});

final cartListProvider = FutureProvider<IList<ProductModel>>((ref) async {
  final repo = await ref.read(cartRepoProvider.future);
  return repo.getCartList();
});
