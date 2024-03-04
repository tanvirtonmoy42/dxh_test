import 'package:dxh_test/application/auth/auth_provider.dart';
import 'package:dxh_test/presentation/auth/signup_screen.dart';
import 'package:dxh_test/presentation/common_widgets/custom_button.dart';
import 'package:dxh_test/presentation/common_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please Login to your account',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'email@email.com',
                  validator: validator,
                ),
                SizedBox(height: 2.h),
                CustomTextField(
                  controller: passwordController,
                  obscureText: true,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: validator,
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final response = await ref
                          .read(authProvider.notifier)
                          .login(
                              email: emailController.text,
                              password: passwordController.text);
                      Logger().i(response);
                      if (context.mounted) {
                        if (response != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully Logged in!'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Wrong email or password!'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: const Text('Register Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validator(dynamic value) {
    if (value == null || value == '') {
      return 'This field is required';
    }
    return null;
  }

  static const path = '/login';
  static const name = 'login';
}
