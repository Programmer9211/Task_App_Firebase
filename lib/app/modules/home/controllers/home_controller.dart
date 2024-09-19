import 'package:get/get.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/data/services/auth_service.dart';
import 'package:task_app/app/data/services/task_service.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:task_app/app/utility/indicator/indicator.dart';

class HomeController extends GetxController {
  int totalTaskCount = 0;

  TaskService taskService = TaskService();
  List<TaskModel> taskList = [];

  // Funtion For fetching all available tasks.
  void getAllTasks() async {
    Indicator.showIndicator();

    final result = await taskService.getAllTasks();

    await getTotalTaskCount();

    Indicator.closeIndicator();

    if (result != null) {
      taskList = result;
    } else {
      Indicator.showSnackBar("Failed To fetch data.");
    }

    // Notifying GetBuilder to rebuild the child widget.
    update(['list_view']);
  }

  // Function for creating a new task locally in the task list
  void onCreateTask() async {
    final result = await Get.toNamed(Routes.CREATE_TASK);

    if (result != null) {
      taskList.insert(0, result);
      totalTaskCount++;

      update(['list_view', 'total_task']);
    }
  }

  // Function for updating task locally in the task list
  void onUpdateTask(TaskModel model, int index) async {
    final result = await Get.toNamed(Routes.CREATE_TASK, arguments: model);

    if (result != null) {
      taskList[index] = result;
      update(['list_view']);
    }
  }

  // Function for fetching total task count of current user
  Future<void> getTotalTaskCount() async {
    totalTaskCount = await taskService.getTotalTaskOfCurrentUser() ?? 0;
    update(['total_task']);
  }

  // Function for updating task status locally and also in database
  void onCompleteTask(String id, int index, bool status) async {
    Indicator.showIndicator();
    final result = await taskService.completeTask(id, status);

    Indicator.closeIndicator();

    if (result.status == 0) {
      taskList[index].isCompleted = status;

      update(['list_view']);
    } else {
      Indicator.showSnackBar(result.message);
    }
  }

  // Function for deleting task locally and also in database.
  void onDeleteTask(String taskId, int index) async {
    Indicator.showIndicator();

    final result = await taskService.deleteTask(taskId);

    Indicator.closeIndicator();

    if (result.status == 0) {
      taskList.removeAt(index);
      totalTaskCount--;

      update(['list_view', 'total_task']);

      Indicator.showSnackBar(result.message);
    } else {
      Indicator.showSnackBar(result.message);
    }
  }

  void onLogout() async {
    final authService = AuthService();

    Indicator.showIndicator();

    await authService.logout();

    Indicator.closeIndicator();

    Get.offAllNamed(Routes.AUTHENTICATION);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAllTasks();
  }
}
