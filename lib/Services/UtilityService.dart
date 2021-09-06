import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oowoo/constants.dart';

class UtilityService {
  Future getInstitutionalRequestForStudents(Map credMap) async {
    String uRL = baseUrl + 'api/institute_requests_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    // print('getInstitutionalRequestForStudents dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print(
      //     'getInstitutionalRequestForStudents statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');

        // print(
        //     'getInstitutionalRequestForStudents response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//

  Future getStudentWalletInfo(Map credMap) async {
    String uRL = baseUrl + 'api/student_wallet_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    // print('getStudentWalletInfo dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print('getStudentWalletInfo statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');

        // print(
        //     'getStudentWalletInfo response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print(responseString);
        return responseString[0];
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//
  Future getStudentProfile(Map credMap) async {
    String uRL = baseUrl + 'api/get_student_profile_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    // print('getStudentProfile dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print('getStudentProfile statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('getStudentProfile is ${response.data}');

        // print(
        //     'getStudentProfile response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        return responseString[0];
      } else
        return '';
    } catch (ex) {
      return null;
    }
  }

//
  Future getSelectBannerForHome(Map credMap) async {
    String uRL = baseUrl + 'api/select_banner_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        var responseString = jsonDecode(response.data);
        return responseString[0];
      }
    } catch (ex) {
      return null;
    }
  }

  //
  Future getTrendingCourses(Map credMap) async {
    String uRL = baseUrl + 'api/get_trending_courses_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        var responseString = jsonDecode(response.data);
        return responseString;
      } else
        return '';
    } catch (ex) {
      return null;
    }
  }

  //  api/get_course_details
  Future getCourseDetails(Map credMap, String courseId) async {
    String uRL = baseUrl + 'api/get_course_details';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['course_id'] = courseId;
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        var responseString = jsonDecode(response.data);
        return responseString;
      } else
        return '';
    } catch (ex) {
      return null;
    }
  }

//  api/get_departments_app
  Future getDepartments(Map credMap) async {
    String uRL = baseUrl + 'api/get_departments_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    // dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    // print('getDepartments dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');
        var responseString = jsonDecode(response.data);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//
  Future getCoursesUnderDepartments(Map credMap, String departmentId) async {
    String uRL = baseUrl + 'api/get_departments_courses_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    // dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['department_id'] = departmentId;
    // print('getCoursesUnderDepartments dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print('getCoursesUnderDepartments statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');

        // print(
        //     'getCoursesUnderDepartments response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');

        return responseString[0]['id'];
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//
  Future selectCourse(Map credMap) async {
    String uRL = baseUrl + 'api/sel_course_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    // dataAsMap['department_id'] = departmentId;
    // print('selectCourse dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print('selectCourse statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');

        // print('selectCourse response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//
  Future selectSubject(Map credMap, String batchId) async {
    String uRL = baseUrl + 'api/sel_subject_app';
    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['usertype'] = credMap['userType'];
    dataAsMap['batch_id'] = batchId;
    // dataAsMap['department_id'] = departmentId;
    // print('selectSubject dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print('selectSubject statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        // print('payLoad is $payLoad');

        // print('selectSubject response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      return null;
    }
  }
//  api/view_chapters_app

  Future selectChaptersUnderSubject(
      Map credMap, String batchId, String subjectId) async {
    String uRL = baseUrl + 'api/view_chapters_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['batch_id'] = batchId;
    dataAsMap['subject_id'] = subjectId;
    // print('selectChaptersUnderSubject dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print(
        //     'selectChaptersUnderSubject response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

//
  Future selectSubCategoryForChapters(
      Map credMap, String chapterId, String categoryId) async {
    String uRL = baseUrl + 'api/video_list_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['chapter_id'] = chapterId;
    dataAsMap['categ_id'] = categoryId;
    // print('video_list_app and notes and reference dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print(
        //     'selectSubCategoryForChapters response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//api/watched_video_app
  Future getWatchedVideoForStudent(
      Map credMap, String chapterId, String categoryId) async {
    String uRL = baseUrl + 'api/watched_video_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['video_id'] = categoryId;
    // print('getWatchedVideoForStudent dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print(
        //     'getWatchedVideoForStudent response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

  Future convertYoutubeLinkToUrlForPlayer(String url) async {
    // String uRL = baseUrl + 'api/watched_video_app';
    String urL = 'https://you-link.herokuapp.com/?url=' + url;
    // Map<String, dynamic> dataAsMap = allOperationKeys;
    // dataAsMap['token'] = credMap['jwt'];
    // dataAsMap['chapter_id'] = chapterId;
    // dataAsMap['categ_id'] = categoryId;
    // print('getWatchedVideoForStudent dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    // FormData formData = new FormData.fromMap(dataAsMap);
    print(urL);
    try {
      Response response = await dio.get(urL);
      if (response.statusCode == 200) {
        // print(
        //     'convertYoutubeLinkToUrlForPlayer response.data is: ${response.data}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(responseString);
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }
//  api/get_image_app

  Future getImages(Map credMap, String imageFolderName, String fileName) async {
    String uRL = baseUrl + 'api/get_image_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['img_folder_name'] = imageFolderName;
    dataAsMap['file_name'] = fileName;
    // print('getImages dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print('getLiveLinks response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print('getLiveLinks response.statusCode is${response.statusCode}');
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//  api/get_live_links_app
  Future getLiveLinks(Map credMap) async {
    String uRL = baseUrl + 'api/get_live_links_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    dataAsMap['uid'] = credMap['userId'];
    // dataAsMap['subject_id'] = subjectId;
    // print('getLiveLinks dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print('getLiveLinks response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print('getLiveLinks response.statusCode is${response.statusCode}');
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }
//  api/student_time_table

  Future getStudentTimeTable(Map credMap, String batchId) async {
    String uRL = baseUrl + 'api/student_time_table';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    // dataAsMap['uid'] = credMap['userId'];
    dataAsMap['batch_id'] = batchId;
    // print('getStudentTimeTable dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print(
        //     'getStudentTimeTable response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(
        //     'getStudentTimeTable response.statusCode is${response.statusCode}');
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }

//  api/sannouncements_app
  Future getStudentAnnouncements(Map credMap, String batchId) async {
    String uRL = baseUrl + 'api/announcements_app';

    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['token'] = credMap['jwt'];
    // dataAsMap['uid'] = credMap['userId'];
    dataAsMap['batch_id'] = batchId;
    // print('getStudentAnnouncements dataAsMap is $dataAsMap');
    // print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        // print(
        //     'getStudentAnnouncements response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print('responseString[0] is ${responseString[0]}');
        // print(responseString);
        // print(
        //     'getStudentAnnouncements response.statusCode is${response.statusCode}');
        return responseString;
      } else
        return '';
    } catch (ex) {
      // print(ex.toString());
      return null;
    }
  }
}
