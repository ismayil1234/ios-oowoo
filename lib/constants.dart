import 'dart:typed_data';

import 'package:flutter/material.dart';

Map<String, dynamic> loginKeys = {
  'secret_key': 'O@9#tgh17)LIY}w',
  'key_secret': 'p/ElI0sdWM34fc2Ppx5jFOA2W0ql94CI+TdPN52LIi7TnXKIcJLlLWs=',
  'key_role': 'login'
};

Map<String, dynamic> allOperationKeys = {
  'secret_key': 'yt&^@we!@14gt}',
  'key_secret':
      'jeNKrKzYuo7e/MNckQ6L1iIWN41N/KPcol0L2I5tJSHfBuYZWgsb0yHbeGJ/zq4t6tV7YxBqSly8/oSoxKGOlg==',
  'key_role': 'all_operations'
};
//Text Styles

// Color kSnackBarSuccessBackgrndColor=Colors.green;
// Color kSnackBarFailureBackgrndColor= Colors.black26;
Color kButtonPrimaryColor = Color(0XFF00AEEF);
enum genderEnum { Male, Female }
TextStyle kWalletBalanceTextStyle = TextStyle(
  fontSize: 35,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFFFFFFFF),
);
TextStyle kWalletPageTrailingAmountsStyle = TextStyle(
  fontSize: 25,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFF130F26),
);
TextStyle kRegisterButtonTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0XFFFFFFFF),
);
TextStyle kTextFormFieldTextStyle = TextStyle(
  fontSize: 19,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Color(0XFF6D6D6D),
);
TextStyle kTextFormFieldErrorTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Colors.red,
);

TextStyle kHomePageHeadingTexts = TextStyle(
  fontSize: 19,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseAndNewsItemTexts = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseHeaderItemTexts = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseHeaderItemTexts13 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseHeaderItemTexts13plus = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0XFF130F26),
);

TextStyle kRegisterSuccessHeadingStyle = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.normal,
  fontFamily: 'Poppins',
  color: Color(0xFF00AEEF),
);
TextStyle kRegisterSuccessContentStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: Colors.black
    // (0xFF00AEEF),
    );
TextStyle kHomePageProfileNamesStyle = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFF130F26),
);
TextStyle kHomePageInstituteStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFF130F26),
);
TextStyle kHomePageInstituteStyle13 = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Color(0XFF130F26),
);
TextStyle kHomePageInstituteStyle13plus = TextStyle(
  fontSize: 14,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w200,
  color: Color(0XFF130F26),
);
TextStyle kHomePageTrendingCourseNumberStyle = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kHomePageSelectedPageStyle = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF00AEEF),
//  blue color
);
TextStyle kHomePageLatestNewsTasksLargeText = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kCoursePageMoreOptionsSelectedText = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFFFFFFFF),
);
TextStyle kCoursePageMoreOptionsUnSelectedText = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kTextButtonTextStyleForAlertDialog = TextStyle(
  fontSize: 17,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF00AEEF),
);
//
TextStyle kHomePageViewAllTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseCategoryTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kWalletPageSubTitleTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: Color(0XFFB0B0B1),
);
//979797
TextStyle kRegistrationHeadersTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  color: Color(0XFF979797),
);
TextStyle kGenderTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  color: Color(0XFF6D6D6D),
);

TextStyle kWalletPageSeeAllText = TextStyle(
  fontSize: 14,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF0BB27E),
);
TextStyle kCoursePageMoreOptionsSelectedTextSizeGrtThn10 = TextStyle(
  fontSize: 13,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFFFFFFFF),
);

TextStyle kCoursePageMoreOptionsUnSelectedTextSizeGrtThn10 = TextStyle(
  fontSize: 13,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kHomePageCourseAndNewsButtonText = TextStyle(
  fontSize: 13,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: Color(0XFF130F26),
);

TextStyle kHomePageBottomNavBarText = TextStyle(
  fontSize: 12,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF130F26),
);
TextStyle kHomePageBottomNavBarSelectedText = TextStyle(
  fontSize: 12,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Color(0XFF00AEEF),
  // (0XFF00AEEF),
);

TextStyle kSnackBarErrorTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: Colors.yellow
    // (0XFF00AEEF),
    );
TextStyle kSnackBarSuccessTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
//TExtFormField styles
OutlineInputBorder kLoginPageTextFormFieldOutLineBorderStyle =
    OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.zero),
  borderSide: BorderSide(color: Color(0XFFBBE8FF)),
);

OutlineInputBorder kCommonBorderForTextFields = OutlineInputBorder(
    borderSide: BorderSide(
        color: Color(0XFFEEEEEE), style: BorderStyle.solid, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    gapPadding: 8);

OutlineInputBorder kCommonEnabledBorderForTextFields = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: Colors.white),
);

OutlineInputBorder kCommonFocusedBorderForTextFields = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white),
);

OutlineInputBorder kCommonErrorBorderForTextFields = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white),
);
String assetPath = 'assets/images/';
String baseUrl = 'https://oowoo.in/student/';
const serverIp = '';
Map<int, Color> color = {
  50: Color.fromRGBO(0, 174, 239, .1),
  100: Color.fromRGBO(0, 174, 239, .2),
  200: Color.fromRGBO(0, 174, 239, .3),
  300: Color.fromRGBO(0, 174, 239, .4),
  400: Color.fromRGBO(0, 174, 239, .5),
  500: Color.fromRGBO(0, 174, 239, .6),
  600: Color.fromRGBO(0, 174, 239, .7),
  700: Color.fromRGBO(0, 174, 239, .8),
  800: Color.fromRGBO(0, 174, 239, .9),
  900: Color.fromRGBO(0, 174, 239, 1),
};
// colorList repeating after 6th item
List<Color> colorList = [
  Color(0XFFFFF5D7),
  Color(0XFFE2F2F0),
  Color(0XFFEEEEEE),
  Color(0XFFF6D5C6),
  Color(0XFFFFCA90),
  Color(0XFFCCF4FF),
  Color(0XFFFFF5D7),
  Color(0XFFE2F2F0),
  Color(0XFFEEEEEE),
  Color(0XFFF6D5C6),
  Color(0XFFFFCA90),
  Color(0XFFCCF4FF)
];

MaterialColor colorCustom = MaterialColor(0xFF00AEEF, color);

//REG EXP
final RegExp validMyNamePlace =
    RegExp(r'^[a-zA-Z\-,\.:]+(?:\s[a-zA-Z\-,\.:]+)*$');
final RegExp validMobileNo = RegExp(r'^[0-9]+(?:\+[0-9]+)?$');
final RegExp validAddress =
    RegExp(r'^[a-zA-Z0-9\-,@\.:]+(?:\s[a-zA-Z\-,\.:]+)*$');
final RegExp validEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
    r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp validWebsiteTest = RegExp(
    r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\."
    r"[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
final RegExp validDob = RegExp(
  r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
  caseSensitive: true,
  multiLine: false,
);
Uint8List croppedProfileImage;
