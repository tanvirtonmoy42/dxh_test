import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepo {
  Future<User?> login({required String email, required String password});
  Future<User?> signUp({required String email, required String password});
  signOut();
}
