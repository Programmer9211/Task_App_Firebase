import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/get_storage/get_storage.dart';
import 'package:task_app/app/data/models/user_model.dart';
import 'package:task_app/const/app_const/app_collections.dart';
import 'package:task_app/const/app_const/app_keys.dart';

import '../models/result_model.dart' as response;

class AuthService {
  // AuthService is a Singletone Class...
  AuthService._();

  static final _instance = AuthService._();

  factory AuthService() => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Login Function with Firebase Authentication and error handling
  Future<response.Response> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // called this function for fetching current user details from firebase
        await getUserDetails(userCredential.user!.uid);
      }

      return response.Response(status: 0, message: "Login Sucessfull");
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase Authentication errors
      return response.Response(status: 1, message: _handleFirebaseAuthError(e));
    } catch (e) {
      return response.Response(
        status: 1,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // Signup Function with Firebase auth and error handling
  Future<response.Response> signup(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
        );

        // Saving user details in Database.
        await insertUserDetails(userModel);

        return response.Response(status: 0, message: "Signup Sucessfully");
      } else {
        return response.Response(status: 1, message: "Something went wrong");
      }
    } on FirebaseAuthException catch (e) {
      return response.Response(status: 1, message: _handleFirebaseAuthError(e));
    } catch (e) {
      return response.Response(
        status: 1,
        message: "An unexpected error occurred: ${e.toString()}",
      );
    }
  }

  // This function is storing users details in the "user_collection" collection
  Future<void> insertUserDetails(UserModel user) async {
    try {
      await _firebaseFirestore
          .collection(AppCollections.usersCollection)
          .doc(user.uid)
          .set(user.toJson());

      // Here i am saving the userdetails in GetStorage(Which is a local storage).
      // So that it can be fetch when user reopens the app
      await Storage.saveValue(AppKeys.users, json.encode(user));

      // Here i am injecting UserModel in Get Dependency so it can be used throughout the app.
      Get.put(user, permanent: true);
    } catch (e) {
      print(e);
    }
  }

  // This function is fetching current cuser details here.
  Future<response.Response> getUserDetails(String uid) async {
    try {
      final result = await _firebaseFirestore
          .collection(AppCollections.usersCollection)
          .doc(uid)
          .get();

      if (result.exists) {
        UserModel userModel = UserModel.fromJson(result.data()!);

        // Here i am saving the userdetails in GetStorage(Which is a local storage).
        // So that it can be fetch when user reopens the app
        await Storage.saveValue(AppKeys.users, json.encode(userModel));

        // Here i am injecting UserModel in Get Dependency so it can be used throughout the app.
        Get.put(userModel, permanent: true);

        return response.Response(
            status: 0, message: "User Details Saved Sucessfully");
      } else {
        return response.Response(status: 1, message: "User Not Found");
      }
    } catch (e) {
      return response.Response(status: 1, message: "Error Occured : $e");
    }
  }

  // This function is used to logout user
  Future<void> logout() async {
    // this method is responsible for signing out user.
    await _firebaseAuth.signOut();
    // this function is used to clear all the available data in Get Storage
    await Storage.clearStorage();
  }

  // Helper function to handle FirebaseAuthException error codes
  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return "The email address is badly formatted.";
      case "user-disabled":
        return "This user has been disabled. Please contact support.";
      case "user-not-found":
        return "No account found for that email. Please sign up.";
      case "wrong-password":
        return "Incorrect password. Please try again.";
      case "email-already-in-use":
        return "An account already exists with that email address.";
      case "network-request-failed":
        return "Network error. Please check your connection.";
      case "too-many-requests":
        return "Too many requests. Please try again later.";
      default:
        return "Login failed. Please try again.";
    }
  }

  // This is used to Verify if email is valid or not.
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }
}
