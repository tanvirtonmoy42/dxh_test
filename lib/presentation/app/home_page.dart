import 'package:dxh_test/application/app/product_provider.dart';
import 'package:dxh_test/presentation/app/cart/cart_screen.dart';
import 'package:dxh_test/presentation/app/product/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final products = ref.watch(productListProvider(''));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: products.maybeWhen(
        data: (data) => GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.w,
            mainAxisSpacing: 5.w,
            childAspectRatio: .72,
          ),
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ProductCart(product: data[index]),
        ),
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static const path = '/homepage';
  static const name = 'homepage';
}
