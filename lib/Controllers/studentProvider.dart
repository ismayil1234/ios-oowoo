// import 'package:flutter/foundation.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  // String departmentId;
  Map<String, dynamic> studentSelectedCourseMapInDepartment = {};
  Map<String, dynamic> studentSelectedBatchIdAndNameForSelectedSubject = {};
  Map<String, dynamic> studentSelectedSubjectIdAndNameForSelectedChapterApi =
      {};

  Map<String, dynamic>
      studentSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedChapterSubCategory =
      {};
  Map<String, dynamic> credentialMapInProvider = {};
  String videoUrl;
  //
  Map profileMap = {};
  Uint8List selectedImageAsBytesForAlertDialogue;
  Map imageMap = {};
  void getDepartmentIdAndName(String departId, String departmentName) {
    // departmentId=departId;
    studentSelectedCourseMapInDepartment['id'] = departId;
    studentSelectedCourseMapInDepartment['departmentName'] = departmentName;
    notifyListeners();
  }

  void getSelectedBatchIdAndCourseNameForSelectedSubject(
      String batchId, String courseName) {
    studentSelectedBatchIdAndNameForSelectedSubject['id'] = batchId;
    studentSelectedBatchIdAndNameForSelectedSubject['courseName'] = courseName;
    notifyListeners();
  }

  void getSelectedBatchIdAndCourseNameForSelectedChapter(
      String subjectId, String subjectName) {
    studentSelectedSubjectIdAndNameForSelectedChapterApi['id'] = subjectId;
    studentSelectedSubjectIdAndNameForSelectedChapterApi['subjectName'] =
        subjectName;
    notifyListeners();
  }

  void
      getSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedSubCategoryOfChapter(
          String chapterId, String categoryId, String categoryName) {
    studentSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedChapterSubCategory[
        'id'] = chapterId;
    studentSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedChapterSubCategory[
        'categoryId'] = categoryId;
    studentSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedChapterSubCategory[
        'categoryName'] = categoryName;
    notifyListeners();
  }

  void getUrlOfVideo(String url) {
    videoUrl = url;
    notifyListeners();
  }

  void getCredentialMapInProvider(Map<String, dynamic> mp) {
    credentialMapInProvider = mp;
    notifyListeners();
  }

  void getProfileMap(Map mp) {
    //<String, dynamic>
    profileMap = mp;
    notifyListeners();
  }

  void getSelectedImageAsBytesForAlertDialogOnPressed(
      Uint8List selectedImageAsBytes) {
    selectedImageAsBytesForAlertDialogue = selectedImageAsBytes;
    notifyListeners();
  }

  void getImageAsMapWhenSelected(
      {String path,
      Uint8List imageAsBytes,
      String croppedImagePath,
      Uint8List croppedImageAsBytes}) {
    // departmentId=departId;
    imageMap['path'] = path;
    imageMap['imageAsBytes'] = imageAsBytes;
    imageMap['croppedImagePath'] = croppedImagePath;
    imageMap['croppedImageAsBytes'] = croppedImageAsBytes;
    notifyListeners();
  }
}
