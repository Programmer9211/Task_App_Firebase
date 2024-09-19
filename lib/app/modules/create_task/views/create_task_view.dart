import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:task_app/app/widgets/task_button.dart';
import 'package:task_app/const/app_const/app_colors.dart';

import '../controllers/create_task_controller.dart';

class CreateTaskView extends GetView<CreateTaskController> {
  const CreateTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            children: [
              const HeaderWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              Obx(() {
                return TextField(
                  controller: controller.titleController,
                  onChanged: controller.validateTitle,
                  decoration: InputDecoration(
                    fillColor: AppColors.grey,
                    filled: true,
                    hintText: "Enter Title Here..",
                    border: OutlineInputBorder(),
                    errorText:
                        controller.title.value ? null : 'Field cannot be empty',
                  ),
                  style: TextStyle(color: Colors.white),
                );
              }),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Obx(() {
                  return TextField(
                    controller: controller.descriptionController,
                    onChanged: controller.validateDescription,
                    decoration: InputDecoration(
                      fillColor: AppColors.grey,
                      filled: true,
                      hintText: "Enter Description Here..",
                      border: OutlineInputBorder(),
                      errorText: controller.description.value
                          ? null
                          : 'Field cannot be empty',
                    ),
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    style: TextStyle(color: Colors.white),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends GetView<CreateTaskController> {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Create Post",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        TaskButton(
          title: controller.taskModel == null ? "Save" : "Update",
          onTap: () {
            controller.onCreateTask();
          },
        ),
      ],
    );
  }
}
