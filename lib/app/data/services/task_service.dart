import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/models/result_model.dart' as response;
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/data/models/user_model.dart';
import 'package:task_app/const/app_const/app_collections.dart';
import 'package:task_app/const/app_const/app_keys.dart';

class TaskService {
  // Task Service is a Singleton class
  TaskService._();

  static final _instance = TaskService._();

  factory TaskService() => _instance;

  final _firestore = FirebaseFirestore.instance;

  UserModel userModel = Get.find<UserModel>();

  // This functions is used to fetch all the available task for the current logged in user.
  Future<List<TaskModel>?> getAllTasks() async {
    try {
      final result = await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .collection(AppCollections.taskCollection)
          // we have used descending true here so that we can fetch lastest document/task
          // createAt is a field in document, which is the time in milisecondepoch. when the document is created
          .orderBy(AppKeys.createdAt, descending: true)
          .get();

      return result.docs.map((e) => TaskModel.fromJson(e.data())).toList();
    } catch (e) {
      print(e);

      return null;
    }
  }

  // This function is used to Insert Task In Database according to the uid of curren user
  // and task id of the task. We have give task id in the doc() function so that we can
  // update or delete this document later.
  Future<response.Response> saveTask(TaskModel taskModel) async {
    try {
      await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .collection(AppCollections.taskCollection)
          .doc(taskModel.id)
          .set(taskModel.toJson());

      return response.Response(status: 0, message: "Task Saved Sucessfully");
    } catch (e) {
      print(e);
      return response.Response(status: 1, message: "Error Occured : $e");
    }
  }

  // This function is used to update task based on the uid of current user and taskid of current task.
  Future<response.Response> updateTask(String taskId,
      {String? title, String? description}) async {
    try {
      Map<String, dynamic> updateMap = {};

      // here we have checked if title is not equal to null. So that we only send the valid value.
      // and if it is null the title field will not be included in the updatation of the Document.
      // Same goes for the desciption.
      if (title != null) {
        updateMap[AppKeys.title] = title;
      }

      if (description != null) {
        updateMap[AppKeys.description] = description;
      }

      print(updateMap);

      await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .collection(AppCollections.taskCollection)
          .doc(taskId)
          .update(updateMap);

      return response.Response(status: 0, message: "Task Updated Sucessfully");
    } catch (e) {
      print(e);
      return response.Response(status: 1, message: "Error Occured : $e");
    }
  }

  // This function is used to mark task as done. SO here we are just updating the status of the task.
  Future<response.Response> completeTask(String taskId, bool status) async {
    try {
      await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .collection(AppCollections.taskCollection)
          .doc(taskId)
          .update({
        AppKeys.isCompleted: status,
      });

      return response.Response(status: 0, message: "Task Completed");
    } catch (e) {
      print(e);
      return response.Response(status: 1, message: "Error Occured : $e");
    }
  }

  // this function is used to delete task of current user by using task id
  Future<response.Response> deleteTask(String taskId) async {
    try {
      await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .collection(AppCollections.taskCollection)
          .doc(taskId)
          .delete();

      return response.Response(status: 0, message: "Task Deleted Sucessfully");
    } catch (e) {
      print(e);
      return response.Response(status: 1, message: "Error Occured : $e");
    }
  }

  // this function returns the taskCount of current user.
  Future<int?> getTotalTaskOfCurrentUser() async {
    try {
      final result = await _firestore
          .collection(AppCollections.usersCollection)
          .doc(userModel.uid)
          .get();

      if (result.exists) {
        if (result.data() != null) {
          return result.data()![AppKeys.taskCount];
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
