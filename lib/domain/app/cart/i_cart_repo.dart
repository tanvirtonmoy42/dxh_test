import 'package:dxh_test/domain/app/product_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class ICartRepo {
  Future<bool> addToCart({required ProductModel product});
  Future<IList<ProductModel>> getCartList();
  removeFromCart({required int index});
}
