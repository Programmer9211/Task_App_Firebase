import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/data/services/task_service.dart';
import 'package:task_app/app/utility/indicator/indicator.dart';
import 'package:uuid/uuid.dart';

class CreateTaskController extends GetxController {
  //TODO: Implement CreateTaskController

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TaskService _taskService = TaskService();
  TaskModel? taskModel;

  var title = true.obs;
  var description = true.obs;

  // Function For validating Title input fields
  void validateTitle(String value) {
    title.value = value.isNotEmpty;
  }

  // Function For validating Description Input Field
  void validateDescription(String value) {
    description.value = value.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();

    checkIfIsEditTask();
  }

  // Function For creating task.
  void onCreateTask() async {
    // this case is for handling initial button tap. If the user hasn't interacted with the text field yet.
    if (title.value) {
      validateTitle(titleController.text);
    }
    if (description.value) {
      validateDescription(descriptionController.text);
    }

    if (title.value && description.value) {
      // Initialising model if it is null.
      // It can be Null in the case of New task creation.
      if (taskModel == null) {
        TaskModel taskModel = TaskModel(
          id: Uuid().v1(),
          title: titleController.text,
          description: descriptionController.text,
          isCompleted: false,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

        Indicator.showIndicator();

        // saving the task details in the database.
        final result = await _taskService.saveTask(taskModel);

        Indicator.closeIndicator();

        if (result.status == 0) {
          // passing taskmodel back to home screen for updating the state.
          Get.back(result: taskModel);
          Indicator.showSnackBar(result.message);
        } else {
          Indicator.showSnackBar(result.message);
        }
      } else {
        // Booleans for checking if the title and description has been changed.
        bool isTitleUpdated = false, isDescriptionUpdated = false;

        if (taskModel!.title != titleController.text) {
          isTitleUpdated = true;
          taskModel!.title = titleController.text;
        }

        if (taskModel!.description != descriptionController.text) {
          isDescriptionUpdated = true;
          taskModel!.description = descriptionController.text;
        }

        // Checking if the user has updated any title or description of the task.
        // Only then proceed to hit update request to database
        if (isTitleUpdated || isDescriptionUpdated) {
          Indicator.showIndicator();

          // Updating task details in the database.
          final result = await _taskService.updateTask(
            taskModel!.id,
            title: isTitleUpdated ? titleController.text : null,
            description:
                isDescriptionUpdated ? descriptionController.text : null,
          );

          Indicator.closeIndicator();

          if (result.status == 0) {
            // passing taskmodel back to home screen for updating the state.
            Get.back(result: taskModel);
            Indicator.showSnackBar(result.message);
          } else {
            Indicator.showSnackBar(result.message);
          }
        } else {
          // passing null in result. Because nothing has changed.
          Get.back();
        }
      }
    }
  }

  // Checking if user is editing any task
  void checkIfIsEditTask() {
    taskModel = Get.arguments;

    if (taskModel != null) {
      titleController.text = taskModel!.title;
      descriptionController.text = taskModel!.description;
    }
  }
}
