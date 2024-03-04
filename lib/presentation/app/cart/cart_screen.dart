import 'package:dxh_test/application/app/cart_provider.dart';
import 'package:dxh_test/application/app/order_provider.dart';
import 'package:dxh_test/presentation/app/cart/widgets/cart_tile.dart';
import 'package:dxh_test/presentation/app/cart/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartList = ref.watch(cartListProvider);
    final orderList = ref.watch(orderListProvider);
    final tabController = useTabController(initialLength: 2, initialIndex: 0);
    final activeTab = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Carts',
          style: TextStyle(
            fontSize: 17.5.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          onTap: (value) {
            activeTab.value = value;
          },
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(
              text: 'Cart',
            ),
            Tab(
              text: 'Orders',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          cartList.maybeWhen(
            data: (carts) => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                itemBuilder: (context, index) {
                  final item = carts[index];
                  return CartTile(
                    item: item,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemCount: carts.length),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          orderList.maybeWhen(
            data: (data) => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                itemBuilder: (context, index) {
                  final item = data[index];
                  return OrderTile(
                    order: item,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemCount: data.length),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  static const path = '/cart';
  static const name = 'cart';
}
