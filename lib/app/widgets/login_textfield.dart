import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? errorText;
  final onChanged;

  const LoginTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.errorText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          border: OutlineInputBorder(),
          errorText: errorText,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
