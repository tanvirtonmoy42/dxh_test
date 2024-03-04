import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:dxh_test/domain/app/order/order_product_model.dart';
import 'package:dxh_test/presentation/app/cart/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12.sp),
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsPage(order: order))),
        title: Text(
          "Id: ${order.id}",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Text(
              'Items: ${order.products.length}',
              style: TextStyle(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              'Price: ${getTotal(order.products).toStringAsFixed(2)}\$',
              style: TextStyle(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getTotal(List<OrderProductModel> products) {
    double x = 0;
    for (OrderProductModel pro in products) {
      x = x +
          (pro.product.price -
                  pro.product.price * pro.product.discountPercentage / 100) *
              pro.count;
    }
    return x;
  }
}
