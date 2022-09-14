// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data_modal.dart';

class DbFunctions with ChangeNotifier {
  List<StudentModel> studentList = [];

  Future<void> createDatabase() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
      Hive.registerAdapter(
        StudentModelAdapter(),
      );
    }
    notifyListeners();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.add(value);
    studentList.add(value);
    log(' data added');
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();
    studentList.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> updateList(int id, StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.putAt(id, value);
    getAllStudents();
  }

  Future<void> deleteList(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    getAllStudents();
  }
}
