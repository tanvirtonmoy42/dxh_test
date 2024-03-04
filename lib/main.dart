import 'package:dxh_test/domain/app/order/order_model.dart';
import 'package:dxh_test/domain/app/order/order_product_model.dart';
import 'package:dxh_test/domain/app/product_model.dart';
import 'package:dxh_test/firebase_options.dart';
import 'package:dxh_test/routes/router_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(OrderProductModelAdapter());
  await Hive.openBox('box');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Test',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFe6501a),
              primary: const Color(0xFFe6501a),
            ),
            useMaterial3: true,
            primaryColor: const Color(0xFFe6501a),
            scaffoldBackgroundColor: Colors.white,
            hintColor: Colors.grey,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
