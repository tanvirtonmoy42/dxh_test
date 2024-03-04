import 'package:cached_network_image/cached_network_image.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:dxh_test/presentation/app/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductCart extends HookWidget {
  final ProductModel product;
  const ProductCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(id: product.id)));
      },
      child: SizedBox(
        width: 42.5.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                height: 14.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.stock.toString(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).hintColor.withOpacity(.8),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color(0xff4BB198),
                        size: 17.sp,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${product.rating}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "${(product.price - product.price * product.discountPercentage / 100).toStringAsFixed(2)}\$",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xff4BB198),
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
