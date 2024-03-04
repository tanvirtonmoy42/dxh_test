import 'package:dxh_test/domain/app/cart/i_cart_repo.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartRepo extends ICartRepo {
  @override
  Future<bool> addToCart({required ProductModel product}) async {
    final box = await Hive.openBox<ProductModel>('all_cart');
    List<ProductModel> data = box.values.toList();

    if (!data.contains(product)) {
      box.add(product);
      return true;
    }
    return false;
  }

  @override
  Future<IList<ProductModel>> getCartList() async {
    final box = await Hive.openBox<ProductModel>('all_cart');
    return box.values.toIList();
  }

  @override
  removeFromCart({required int index}) async {
    final box = await Hive.openBox<ProductModel>('all_cart');
    box.deleteAt(index);
  }
}
