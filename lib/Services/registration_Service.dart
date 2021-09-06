import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oowoo/Model/Register_Model.dart';
import 'package:oowoo/constants.dart';

class RegistrationService {
  RegisterModel registerModel = RegisterModel();
  Future register(RegisterModel regModel) async {
    String uRL = baseUrl + 'api/new_registration';

    Map<String, dynamic> dataAsMap = registerModel.toMap(regModel);
    if (dataAsMap['photo'] == null) {
      dataAsMap['photo'] = '';
    }
    dataAsMap.addAll(allOperationKeys);
    // print(dataAsMap);
    // dataAsMap['uid'] = credMap['userId'];
    // dataAsMap['token'] = credMap['jwt'];
    // print('getInstitutionalRequestForStudents dataAsMap is $dataAsMap');
    print('dataAsMap is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print(
      //     'getInstitutionalRequestForStudents statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        print('statusCode is ${response.statusCode}');
        print(response.data);
        print(response);
        // print(
        //     'getInstitutionalRequestForStudents response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        print(responseString);
        return responseString;
      }
      // else
      //   return '';
    } catch (ex) {
      print(ex.toString());
      // return null;
    }
  }

  Future updateProfile(
      RegisterModel regModel, Map<String, dynamic> credMap) async {
    String uRL = baseUrl + 'api/student_profile_update';

    Map<String, dynamic> dataAsMap = registerModel.toMap(regModel);
    dataAsMap.addAll(allOperationKeys);
    // print(dataAsMap);
    dataAsMap['uid'] = credMap['userId'];
    dataAsMap['token'] = credMap['jwt'];
    if (dataAsMap['photo'] == '') {
      dataAsMap['status'] = '1';
    } else {
      dataAsMap['status'] = '0';
    }
    // print('getInstitutionalRequestForStudents dataAsMap is $dataAsMap');
    print('dataAsMap in updateProfile is $dataAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      // print(
      //     'getInstitutionalRequestForStudents statusCode is: ${response.statusCode}');
      if (response.statusCode == 200) {
        // var payLoad = json.decode(ascii.decode(
        //     base64.decode(base64.normalize(response.data.split(".")[1]))));
        print('statusCode updateProfile is ${response.statusCode}');
        print(response.data);
        print(response);
        // print(
        //     'getInstitutionalRequestForStudents response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        print(responseString);
        return responseString;
      }
      // else
      //   return '';
    } catch (ex) {
      print(ex.toString());
      // return null;
    }
  }

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
        // print('payLoad is $payLoad');

        // print(
        //     'getStudentProfile response.data is: ${response.data.runtimeType}');
        var responseString = jsonDecode(response.data);
        // print(responseString);
        return responseString[0];
      } else
        return '';
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
