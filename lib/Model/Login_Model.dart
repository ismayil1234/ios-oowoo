class Login {
  String userName;
  String password;
  String deviceName;
  String deviceId;
  String deviceToken;
  Login({
    this.userName,
    this.password,
    this.deviceId,
    this.deviceName,
    this.deviceToken,
  });
  Map<String, dynamic> toMap(Login loginModel, Map<String, dynamic> loginKeys) {
    // 'txtuname': loginModel.userName,
    // 'txtpass': loginModel.password,
    return {
      'secret_key': loginKeys['secret_key'],
      'key_secret': loginKeys['key_secret'],
      'key_role': loginKeys['key_role'],
      'username': loginModel.userName,
      'password': loginModel.password,
      'fcmtoken': loginModel.deviceToken,
      'deviceid': loginModel.deviceId,
      'devicename': loginModel.deviceName,
    };
  }
}
