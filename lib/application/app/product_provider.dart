import 'package:dxh_test/application/core/dio_provider.dart';
import 'package:dxh_test/domain/app/i_product_repo.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:dxh_test/infrastructure/app/product_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productRepoProvider = FutureProvider<IProductRepo>((ref) async {
  final dio = ref.watch(dioProvider);
  return ProductRepo(dio: dio);
});

final productListProvider =
    FutureProvider.family<IList<ProductModel>, String>((ref, search) async {
  final repo = await ref.read(productRepoProvider.future);
  return repo.getAllProduct(search: search);
});

final productDetailsProvider =
    FutureProvider.family<ProductModel, int>((ref, id) async {
  final repo = await ref.read(productRepoProvider.future);
  return repo.getProductDetails(id: id);
});
