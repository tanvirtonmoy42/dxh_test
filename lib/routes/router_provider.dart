import 'package:dxh_test/application/auth/auth_provider.dart';
import 'package:dxh_test/loading_page.dart';
import 'package:dxh_test/presentation/app/home_page.dart';
import 'package:dxh_test/presentation/auth/login_screen.dart';
import 'package:dxh_test/presentation/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final userState = ref.watch(authProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: LoadingPage.path,
    redirect: (context, state) {
      final user = userState.valueOrNull;
      final isLoggedIn = user != null;
      final currentPath = state.uri.toString();

      final isAuthPath = state.uri.toString() == LoginScreen.path ||
          state.uri.toString() == SignupScreen.path;

      if (isLoggedIn && isAuthPath) {
        Logger().i('going to home page');
        return Homepage.path;
      }

      if (!userState.isLoading && currentPath == LoadingPage.path) {
        if (user == null) {
          return LoginScreen.path;
        } else {
          Logger().i('going to home page');
          return Homepage.path;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignupScreen.path,
        name: SignupScreen.name,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: Homepage.path,
        name: Homepage.name,
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: LoadingPage.path,
        name: LoadingPage.name,
        builder: (context, state) => const LoadingPage(),
      ),
    ],
  );
});
