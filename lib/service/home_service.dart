import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_arkademi/model/course_model.dart';

class HomeService {
  Future<CourseModel> fetchCourse() async {
    final response = await rootBundle.loadString('assets/course.json');
    return CourseModel.fromJson(await json.decode(response));
  }
}
