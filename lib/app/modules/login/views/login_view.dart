import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:task_app/app/modules/create_task/views/create_task_view.dart';
import 'package:task_app/app/widgets/login_button.dart';
import 'package:task_app/app/widgets/login_textfield.dart';
import 'package:task_app/const/app_const/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: SingleChildScrollView(
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
                      text: "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "\nEnter your details to login",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
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
                    title: "Email",
                    controller: controller.emailController,
                    onChanged: controller.validateEmail,
                    errorText: controller.email.value
                        ? null
                        : 'Please enter a valid email',
                  );
                }),
                Obx(() {
                  return LoginTextField(
                    title: "Password",
                    controller: controller.passwordController,
                    onChanged: controller.validatePassword,
                    errorText: controller.password.value
                        ? null
                        : 'Field cannot be empty',
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),

                // Login Button.

                LoginButton(
                  title: "Login",
                  onTap: () {
                    controller.onLogin();
                  },
                ),

                SizedBox(
                  height: 180.h,
                ),

                InkWell(
                  onTap: () {
                    controller.onCreateNewAccount();
                  },
                  child: Text(
                    "New User, Create Account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
