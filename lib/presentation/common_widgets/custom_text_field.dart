import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final bool isDense;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final List<TextInputFormatter>? formetter;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isDense = false,
    this.prefixIcon,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.labelText,
    this.validator,
    this.readOnly = false,
    this.enabled,
    this.formetter,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Colors.grey.withOpacity(.3),
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Colors.grey.withOpacity(.3),
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Colors.grey.withOpacity(.3),
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        isDense: maxLines == 1 || isDense ? true : false,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
        fillColor: Colors.grey.withOpacity(.3),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.5.w),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      readOnly: readOnly,
      inputFormatters: formetter,
      keyboardType: maxLines != 1 ? TextInputType.multiline : keyboardType,
    );
  }
}
