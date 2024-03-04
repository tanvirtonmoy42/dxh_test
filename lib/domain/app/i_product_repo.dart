import 'package:dxh_test/domain/app/product_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class IProductRepo {
  Future<IList<ProductModel>> getAllProduct({required String search});
  Future<ProductModel> getProductDetails({required int id});
}
