import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: Center(
      child: InkWell(
          onTap: () {
            // Logger.i(
            //     "Loading page: ${ref.watch(authenticationProvider).isLoading})}");
          },
          child: const CircularProgressIndicator()),
    ));
  }

  static const path = '/loading';
  static const name = 'loading';
}
