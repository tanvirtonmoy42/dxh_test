import 'package:cached_network_image/cached_network_image.dart';
import 'package:dxh_test/application/app/cart_provider.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:dxh_test/presentation/app/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartTile extends HookConsumerWidget {
  final ProductModel item;
  final int index;
  const CartTile({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context, ref) {
    final count = useState(1);
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12.sp),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(id: item.id)));
        },
        leading: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: item.thumbnail,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${((item.price - item.price * item.discountPercentage / 100) * count.value).toStringAsFixed(2)}\$",
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                final repo = await ref.read(cartRepoProvider.future);
                await repo.removeFromCart(index: index);
                ref.invalidate(cartListProvider);
              },
              child: Icon(
                Icons.delete_outlined,
                color: Colors.red,
                size: 16.sp,
              ),
            ),
            SizedBox(height: 2.w),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (count.value > 1) {
                      count.value = count.value - 1;
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 18.sp,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 10.w,
                  height: 2.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).hintColor, width: .5),
                  ),
                  child: Text(count.value.toString()),
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: () {
                    count.value = count.value + 1;
                  },
                  child: Icon(
                    Icons.add,
                    size: 18.sp,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
