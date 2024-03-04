import 'package:cached_network_image/cached_network_image.dart';
import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:dxh_test/domain/app/order/order_product_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 17.5.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Id: ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(order.id)
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = order.products[index].product;
                  return Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(12.sp),
                    child: ListTile(
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
                        "${((item.price - item.price * item.discountPercentage / 100) * order.products[index].count).toStringAsFixed(2)}\$",
                      ),
                      trailing: Text(
                        'X${order.products[index].count}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 2.h),
                itemCount: order.products.length,
              ),
              SizedBox(height: 2.h),
              Divider(
                height: 2.h,
                thickness: 2,
              ),
              SizedBox(height: .5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Text(
                    "${getTotal(order.products).toStringAsFixed(2)}\$",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
