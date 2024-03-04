import 'package:dio/dio.dart';
import 'package:dxh_test/domain/auth/i_auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthRepo extends IAuthRepo {
  final Dio dio;
  AuthRepo({required this.dio});
  final auth = FirebaseAuth.instance;

  @override
  Future<User?> login({required String email, required String password}) async {
    try {
      Logger().i(email);
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Logger().i(credential);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      return null;
    }
  }

  @override
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Logger().i('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  signOut() async {
    await auth.signOut();
  }
}
