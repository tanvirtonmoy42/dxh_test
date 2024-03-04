import 'package:dio/dio.dart';
import 'package:dxh_test/domain/app/i_product_repo.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class ProductRepo extends IProductRepo {
  final Dio dio;

  ProductRepo({required this.dio});

  @override
  Future<IList<ProductModel>> getAllProduct({required String search}) async {
    final response = await dio.get('/products/search?q=$search');
    final list = (response.data['products'] as List)
        .map((e) => ProductModel.fromMap(e))
        .toList(growable: false);
    return list.toIList();
  }

  @override
  Future<ProductModel> getProductDetails({required int id}) async {
    final response = await dio.get('/products/$id');
    final data = ProductModel.fromMap(response.data);
    return data;
  }
}
