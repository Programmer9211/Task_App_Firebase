import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:task_app/app/widgets/login_button.dart';
import 'package:task_app/app/widgets/login_textfield.dart';
import 'package:task_app/const/app_const/app_colors.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              children: [
                // Task text Widget

                RichText(
                  text: TextSpan(
                    text: "task",
                    style: TextStyle(
                      fontSize: 80.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: ".",
                        style: TextStyle(
                          color: AppColors.orange,
                        ),
                      )
                    ],
                  ),
                ),

                // Divider

                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 50.h,
                ),

                // Login Text Widget

                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: "Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "\nEnter your details to create account",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),

                // TextFields Widget

                Obx(() {
                  return LoginTextField(
                    title: "Name",
                    controller: controller.nameController,
                    errorText:
                        controller.name.value ? null : 'Field cannot be empty',
                    onChanged: controller.validateName,
                  );
                }),
                Obx(() {
                  return LoginTextField(
                    title: "Email",
                    controller: controller.emailController,
                    errorText: controller.email.value
                        ? null
                        : 'Please Enter a valid email',
                    onChanged: controller.validateEmail,
                  );
                }),
                Obx(() {
                  return LoginTextField(
                    title: "Password",
                    controller: controller.passwordController,
                    errorText: controller.password.value
                        ? null
                        : 'Field cannot be empty',
                    onChanged: controller.validatePassword,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),

                // Login Button.

                LoginButton(
                  title: "Signup",
                  onTap: () {
                    controller.onSignup();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
