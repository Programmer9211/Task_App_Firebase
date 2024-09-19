import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:task_app/const/app_const/app_colors.dart';

class TaskTileWidget extends GetView<HomeController> {
  final TaskModel taskModel;
  final int index;
  const TaskTileWidget(
      {super.key, required this.taskModel, required this.index});

  // to format date in day month(19 September) order.
  String formatEpochToDateString() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(taskModel.createdAt);

    String day = date.day.toString();
    String month = _getMonthName(date.month);

    return '$day $month';
  }

  String _getMonthName(int month) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  // For displaing a dialogbox on longpress on task tile.
  void showEditDeleteDialog() {
    Get.dialog(AlertDialog(
      backgroundColor: AppColors.black,
      title: Column(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              controller.onUpdateTask(taskModel, index);
            },
            title: Text(
              "Edit",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Get.back();
              controller.onDeleteTask(taskModel.id, index);
            },
            title: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = formatEpochToDateString();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: InkWell(
        onLongPress: () {
          showEditDeleteDialog();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskModel.isCompleted,
                onChanged: (onChanged) {
                  controller.onCompleteTask(
                    taskModel.id,
                    index,
                    onChanged ?? false,
                  );
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "$formattedTime\n",
                    style: TextStyle(color: AppColors.orange, fontSize: 14.sp),
                    children: [
                      WidgetSpan(child: SizedBox(height: 30.sp)),
                      TextSpan(
                        text: "${taskModel.title}\n",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(height: 20.sp)),
                      TextSpan(
                        text: taskModel.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
