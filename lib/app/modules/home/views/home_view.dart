import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/models/user_model.dart';
import 'package:task_app/app/widgets/task_button.dart';
import 'package:task_app/app/widgets/task_tile.dart';
import 'package:task_app/const/app_const/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            children: [
              const WelcomeTextWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              const TotalPostCounterWidget(),
              TaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: TaskButton(
          title: "Create Post",
          onTap: () {
            controller.onCreateTask();
          },
        ),
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<HomeController>(
        id: 'list_view',
        builder: (controller) {
          if (controller.taskList.isNotEmpty) {
            return ListView.builder(
              itemCount: controller.taskList.length,
              itemBuilder: (context, index) {
                final taskModel = controller.taskList[index];

                return TaskTileWidget(
                  key: ValueKey(taskModel.id),
                  taskModel: taskModel,
                  index: index,
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "No Tasks Available...",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class WelcomeTextWidget extends GetView<HomeController> {
  const WelcomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Get.find<UserModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: "Welcome\n",
              style: TextStyle(
                color: AppColors.orange,
                fontSize: 16.sp,
              ),
              children: [
                TextSpan(
                  text: userModel.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.onLogout();
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class TotalPostCounterWidget extends GetView<HomeController> {
  const TotalPostCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 6.sp, horizontal: 12.sp),
        decoration: BoxDecoration(
            color: AppColors.grey, borderRadius: BorderRadius.circular(20.sp)),
        child: GetBuilder<HomeController>(
          id: 'total_task',
          builder: (controller) {
            return Text(
              "Total Post : ${controller.totalTaskCount}",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.orange,
              ),
            );
          },
        ),
      ),
    );
  }
}
