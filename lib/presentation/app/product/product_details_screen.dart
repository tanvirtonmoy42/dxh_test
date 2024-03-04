import 'package:cached_network_image/cached_network_image.dart';
import 'package:dxh_test/application/app/cart_provider.dart';
import 'package:dxh_test/application/app/order_provider.dart';
import 'package:dxh_test/application/app/product_provider.dart';
import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:dxh_test/domain/app/order/order_product_model.dart';
import 'package:dxh_test/presentation/app/cart/cart_screen.dart';
import 'package:dxh_test/presentation/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class ProductDetailsScreen extends HookConsumerWidget {
  final int id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, ref) {
    final product = ref.watch(productDetailsProvider(id));
    final activeIndex = useState(0);
    final pageController = usePageController(initialPage: 0);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: SizedBox(
            width: double.infinity,
            height: 6.h,
            child: product.maybeWhen(
                data: (data) => Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            child: const Text('Add to Card'),
                            onPressed: () async {
                              final repo =
                                  await ref.read(cartRepoProvider.future);
                              final response =
                                  await repo.addToCart(product: data);
                              if (context.mounted) {
                                if (response) {
                                  ref.invalidate(cartListProvider);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Product Added to Cart!'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Product Already exists in cart!'),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: CustomButton(
                            child: const Text('Place Order'),
                            onPressed: () async {
                              const uuid = Uuid();
                              final uId = uuid.v1();
                              final model = [
                                OrderProductModel(product: data, count: 1)
                              ];
                              final repo =
                                  await ref.read(orderRepoProvider.future);
                              await repo.placeOrder(
                                order: OrderModel(
                                    id: uId,
                                    products: model,
                                    createdAt: DateTime.now(),
                                    status: 'processing'),
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Order Placed Successful!'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ))),
      ),
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: 17.5.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: product.maybeWhen(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 44.h,
                              width: double.infinity,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: data.images.length,
                                onPageChanged: (value) {
                                  activeIndex.value = value;
                                },
                                itemBuilder: (context, index) =>
                                    CachedNetworkImage(
                                  imageUrl: data.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (data.images.length > 1)
                        Container(
                          margin: EdgeInsets.only(left: 2.w),
                          width: 10.w,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.images.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                pageController.jumpToPage(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: activeIndex.value == index
                                        ? Colors.red
                                        : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: data.images[index],
                                  height: 10.w,
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 1.w),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(height: 1.h),
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color(0xff4BB198),
                        size: 20.sp,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${data.rating}',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${data.price}\$",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "${(data.price - data.price * data.discountPercentage / 100).toStringAsFixed(2)}\$",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.5.sp,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Text(
                        'In stock:',
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        data.stock.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${data.discountPercentage}% Off",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Brand',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16.5.sp,
                    ),
                  ),
                  Divider(
                    height: 2.h,
                    thickness: 2,
                  ),
                  SizedBox(height: .5.h),
                  Text(
                    data.brand,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Product Category',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16.5.sp,
                    ),
                  ),
                  Divider(
                    height: 2.h,
                    thickness: 2,
                  ),
                  SizedBox(height: .5.h),
                  Text(
                    data.category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16.5.sp,
                    ),
                  ),
                  Divider(
                    height: 2.h,
                    thickness: 2,
                  ),
                  SizedBox(height: .5.h),
                  Text(
                    data.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5.sp,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          );
        },
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
