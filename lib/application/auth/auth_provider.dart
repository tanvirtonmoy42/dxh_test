import 'dart:async';
import 'package:dxh_test/application/core/dio_provider.dart';
import 'package:dxh_test/domain/auth/i_auth_repo.dart';
import 'package:dxh_test/infrastructure/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepoProvider = FutureProvider<IAuthRepo>((ref) async {
  final dio = ref.watch(dioProvider);
  return AuthRepo(dio: dio);
});

final authProvider =
    AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<User?> signup(
      {required String email, required String password}) async {
    final repo = await ref.read(authRepoProvider.future);
    final result = await AsyncValue.guard(
        () => repo.signUp(email: email, password: password));

    if (result.hasValue) {
      state = AsyncData(result.value);
    }
    return state.valueOrNull;
  }

  Future<User?> login({required String email, required String password}) async {
    final repo = await ref.read(authRepoProvider.future);
    final result = await AsyncValue.guard(
        () => repo.login(email: email, password: password));

    if (result.hasValue) {
      state = AsyncData(result.value);
    }
    return state.valueOrNull;
  }

  // Future<Object?> getRetailerProfile() async {
  //   final repo = await ref.read(authRepoProvider.future);
  //   final result = await AsyncValue.guard(() => repo.getRetailerProfile());

  //   if (result.hasValue) {
  //     state = AsyncData(result.value);
  //   }
  //   return result.error;
  // }

  // Future<Object?> executiveLogin({required AkijLoginBody body}) async {
  //   final repo = await ref.read(authRepoProvider.future);
  //   final result =
  //       await AsyncValue.guard(() => repo.executiveLogin(body: body));
  //   if (result.hasValue) {
  //     state = AsyncData(result.value);
  //   }
  //   return result.error;
  // }

  logout() async {
    final repo = await ref.read(authRepoProvider.future);
    repo.signOut();
    state = const AsyncData(null);
  }
}
