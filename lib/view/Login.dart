import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oowoo/Conrollers/Login_Provider.dart';
import 'package:oowoo/Conrollers/registration_Provider.dart';
import 'package:oowoo/Conrollers/studentProvider.dart';
import 'package:oowoo/Model/Login_Model.dart';
import 'package:oowoo/Services/Login_Service.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  LoginService loginService = LoginService();
  Login loginModel = Login();
  bool isLoading = false;
  String userName;
  String password;
  final storage = FlutterSecureStorage();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceToken;
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  bool isPressed = true;
  final _formKEy = GlobalKey<FormState>();
  @override
  void initState() {
    firebaseCloudMessaging_Listeners();
    initPlatformState();
    super.initState();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) {
      iOS_Permission();
    }

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token;
      });
    });

    // _firebaseMessaging.

    // configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //   },
    // );
  }

  void iOS_Permission() {
    FirebaseMessaging.instance.getNotificationSettings.call(

        // IosNotificationSettings(sound: true, badge: true, alert: true)
        );
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings)
    {
      // print("Settings registered: $settings");
    }
    // )
    // ;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: AnimatingCircle(),
        opacity: .5,
        color: Colors.grey,
        child: Form(
          key: _formKEy,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: (100 / height) * height),
                  SizedBox(
                      height: (50 / height) * height,
                      width: (200 / width) * width,
                      child: Image.asset(
                        'assets/images/Badge.png',
                        fit: BoxFit.fill,
                      )),
                  SizedBox(height: (100 / height) * height),
                  TextFormField(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        // fontFamilyFallback: ,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0XFF6D6D6D),
                        fontWeight: FontWeight.w400),
                    textAlignVertical: TextAlignVertical.center,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (val) {
                      loginModel.userName = val;
                    },
                    validator: (val) {
                      String errorText;
                      if (val.isEmpty) {
                        errorText = 'Email Cannot be Empty';
                      } else if (validEmail.hasMatch(val) == false) {
                        errorText = 'Invalid Email';
                      } else
                        errorText = null;
                      return errorText;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // errorText: 'Username Cannot be Empty',
                      hintText: 'Username',
                      // 'example@gmail.com',
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0XFF6D6D6D),
                          fontWeight: FontWeight.w400),
                      // isDense: true,
                      fillColor: Color(0XFFBBE8FF),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                          gapPadding: 8),
                      focusColor: Color(0XFFBBE8FF),

                      focusedBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                      enabledBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                      focusedErrorBorder:
                          kLoginPageTextFormFieldOutLineBorderStyle,
                      errorBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                    ),
                  ),
                  SizedBox(height: (20 / height) * height),
                  TextFormField(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0XFF6D6D6D),
                        fontWeight: FontWeight.w400),
                    textAlignVertical: TextAlignVertical.center,
                    onSaved: (val) {
                      loginModel.password = val;
                    },
                    validator: (val) {
                      String errorText;
                      if (val.isEmpty) {
                        errorText = 'Password Cannot be Empty';
                      } else
                        errorText = null;
                      return errorText;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    textCapitalization: TextCapitalization.none,
                    obscureText: isPressed,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(isPressed
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Color(0XFF6D6D6D),
                          fontWeight: FontWeight.w400),
                      isDense: true,
                      fillColor: Color(0XFFBBE8FF),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                          gapPadding: 8),
                      focusColor: Color(0XFFBBE8FF),
                      focusedBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                      enabledBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                      focusedErrorBorder:
                          kLoginPageTextFormFieldOutLineBorderStyle,
                      errorBorder: kLoginPageTextFormFieldOutLineBorderStyle,
                    ),
                  ),
                  SizedBox(height: (20 / height) * height),
                  Builder(
                    builder: (context) =>
                        // child:
                        Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                          text: TextSpan(
                              text: 'Forgot password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (userName == null ||
                                      validEmail.hasMatch(userName) == false) {
                                    String msg = userName == null
                                        ? 'Please Enter Your Username'
                                        : 'Invalid Username';
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        commonSnackBar(context, false, msg,
                                            height: (75 / height) * height));
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await loginService
                                        .forgotPassword(email: userName)
                                        .then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      bool isSuccess = true;
                                      String msg = value['msg'];
                                      if (value['success'] == '0' ||
                                          value['success'] == 0) {
                                        isSuccess = false;
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(commonSnackBar(
                                              context, isSuccess, msg,
                                              height: (75 / height) * height));
                                    });
                                  }
                                }
                              // launch(
                              //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              // },
                              )),
                    ),
                  ),
                  SizedBox(height: (15 / height) * height),
                  ElevatedButton(
                      onPressed: () async {
                        Provider.of<StudentProvider>(context, listen: false)
                            .getImageAsMapWhenSelected(
                                path: null,
                                imageAsBytes: null,
                                croppedImageAsBytes: null,
                                croppedImagePath: null);
                        Provider.of<StudentProvider>(context, listen: false)
                            .getSelectedImageAsBytesForAlertDialogOnPressed(
                                null);
                        if (_formKEy.currentState.validate()) {
                          _formKEy.currentState.save();
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            isLoading = true;
                          });

                          Provider.of<LoginProvider>(context, listen: false)
                              .getUserName(userName);
                          Provider.of<LoginProvider>(context, listen: false)
                              .getPassword(password);

                          loginModel.password = password;
                          loginModel.userName = userName;

                          loginModel.deviceId = _deviceData['id'];
                          loginModel.deviceName = _deviceData['model'];
                          loginModel.deviceToken = deviceToken;

                          await loginService
                              .attemptLogin(loginModel)
                              .then((value) async {
                            setState(() {
                              isLoading = false;
                            });

                            if (value != null && value['uid'] != '0') {
                              await storage.write(
                                  key: 'jwt', value: value['jwt_token']);
                              await storage.write(
                                  key: 'userId', value: value['uid']);
                              await storage.write(
                                  key: 'userType', value: value['usertype']);
                              Map<String, String> allValues =
                                  await storage.readAll();
                              Navigator.pushReplacementNamed(
                                  context, '/HomePage');
                            }
                            //
                            else
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(commonSnackBar(
                                context,
                                false,
                                'Invalid credentials',
                              ));
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(commonSnackBar(
                            context,
                            false,
                            'Please Fill Redmarked Fields',
                          ));
                        }
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kButtonPrimaryColor,
                          minimumSize: Size(
                              double.infinity,
                              // 50
                              0.07316053511705685924584176910773 * height))),
                  SizedBox(height: (10 / height) * height),
                  Row(
                    children: [
                      Text(
                        'Not registered yet?\t',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'Poppins'),
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<RegistrationProvider>(context,
                                    listen: false)
                                .getDob({});
                            Provider.of<StudentProvider>(context, listen: false)
                                .getProfileMap({});
                            Provider.of<StudentProvider>(context, listen: false)
                                .getSelectedImageAsBytesForAlertDialogOnPressed(
                                    null);
                            Navigator.pushNamed(context, '/Register2');
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                decorationThickness: 10,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    //'identifierForVendor': data.identifierForVendor, is device id for ios
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }
}
