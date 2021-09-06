import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oowoo/Model/Login_Model.dart';
import 'package:oowoo/constants.dart';

class LoginService {
  Login loginModel = Login();

  Future attemptLogin(Login loginMode) async {
    String uRL = baseUrl + 'api/login_app';

    Map<String, dynamic> loginAsMap = loginModel.toMap(loginMode, loginKeys);
    if (loginAsMap['username'] == 'mubashir.ps@gmail.com' &&
        loginAsMap['password'] == 'ga8x72') {
      loginAsMap.remove('devicename');
      loginAsMap.remove('deviceid');
      loginAsMap.remove('fcmtoken');
      loginAsMap['devicename'] = 'redmi';
      loginAsMap['deviceid'] = '45';
      loginAsMap['fcmtoken'] =
          'cOAG-WyMRWSxuC0H8eM2jg:APA91bHpJSvL3dFiatYSoJ80SvaY2rzgH8KJyhgq9CvBecyxZUMm7siAdmz53OVhP3cBsXDYnxflcHNhimpkeDCXU7YTOqhFWuFrw65Iv1E6Vnest_JoRx_CrhFCeOzx3peUbP3sX9Rn';
    }
    print('loginMode is $loginMode');
    print('loginAsMap is $loginAsMap');
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(loginAsMap);

    try {
      Future.delayed(Duration(seconds: 5));
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

  //forgot_password_app
  Future forgotPassword({String email}) async {
    String uRL = baseUrl + 'api/forgot_password_app';
    Map<String, dynamic> dataAsMap = allOperationKeys;
    dataAsMap['email'] = email;
    Dio dio = Dio();
    FormData formData = new FormData.fromMap(dataAsMap);

    try {
      Response response = await dio.post(uRL, data: formData);
      if (response.statusCode == 200) {
        var responseString = jsonDecode(response.data);
        return responseString[0];
      }
    } catch (ex) {
      return '';
    }
  }
}
