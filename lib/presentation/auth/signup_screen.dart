import 'package:dxh_test/application/auth/auth_provider.dart';
import 'package:dxh_test/presentation/common_widgets/custom_button.dart';
import 'package:dxh_test/presentation/common_widgets/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

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
                  'Don\'t have an Account!',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Register Here',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 5.h),
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'email@email.com',
                  validator: (String? value) {
                    if (value == null || value == '') {
                      return 'Please enter email';
                    } else if (!EmailValidator.validate(value) ||
                        !value.contains('.com')) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
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
                          .signup(
                              email: emailController.text,
                              password: passwordController.text);
                      if (context.mounted) {
                        if (response != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully registered'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Already have an account!'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Login'),
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

  static const path = '/signup';
  static const name = 'signup';
}
