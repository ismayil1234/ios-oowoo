import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oowoo/Conrollers/registration_Provider.dart';
import 'package:oowoo/Conrollers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

ButtonStyle getButtonStyle({Color buttonColor, double width, double height}) {
  return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(color: buttonColor))),
      backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
          left: (20 / width) * width,
          right: (20 / width) * width,
          top: (5 / height) * height,
          bottom: (5 / height) * height)));
}

ButtonStyle getButtonStyleWithoutPadding(
    {Color buttonColor, double width, double height}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(color: buttonColor))),
    backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
    minimumSize: MaterialStateProperty.all<Size>(Size.zero),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
        right: (15 / width) * width,
        left: (15 / width) * width,
        top: (5 / height) * height,
        bottom: (5 / height) * height)),
  );
}

SnackBar commonSnackBar(BuildContext context, bool isSuccess, String text,
    {double height}) {
  return SnackBar(
    content: Text(text,
        style: isSuccess ? kSnackBarSuccessTextStyle : kSnackBarErrorTextStyle),
    padding: EdgeInsets.all(8),
    backgroundColor: isSuccess ? Colors.green : Colors.black45,
  );
}

Container getContainerForCourses(BuildContext context,
    {double height,
    double width,
    String imageAddress,
    String courseTitle,
    String chapterId,
    String buttonText,
    Color buttonColor,
    Color innerContainerColor,
    Color borderColor,
    String pageName,
    String videoCount,
    String notesCount,
    String referenceCount}) {
  return Container(
    height: height == null ? 83 : 83,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        )),
    child: Padding(
      padding: EdgeInsets.only(
        top: (10 / height) * height,
        bottom: (10 / height) * height,
        left: (10 / width) * width,
        right: (10 / width) * width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: (60 / height) * height,
            width: (60 / width) * width,
            decoration: BoxDecoration(
                color: innerContainerColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Image.asset(imageAddress, fit: BoxFit.fill),
            ),
          ),
          SizedBox(width: (10 / width) * width),
          Text(courseTitle, style: kHomePageProfileNamesStyle),
          Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              //for chapter page a named parameter pageName='Chapter',for courses pageName=null,for videos pageName='Videos'
              if (pageName == null)
                courseTitle == 'English'
                    ? Navigator.pushNamed(context, '/Chapter')
                    : print('please define Inside Widgets of utilities');
              else if (pageName == 'VideosSubCategory') {
                // utilityService.getWatchedVideoForStudent(credMap, chapterId, categoryId);
              } else if (pageName == 'Chapter') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      // child: SingleChildScrollView(
                      child: AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        // EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                        contentPadding: EdgeInsets.zero,
                        // EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                        backgroundColor: Colors.transparent,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        content: SizedBox(
                          width: width - 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              getContainerForPopUpInChapter(
                                context,
                                height: height - 40,
                                width: width,
                                imageAddress: 'assets/images/Paper.png',
                                borderColor: borderColor,
                                buttonText: notesCount,
                                // '21',
                                buttonColor: colorList[0],
                                courseTitle: 'Notes',
                                chapterId: chapterId,
                                innerContainerColor: Color(0XFFF1F1F1),
                              ),
                              SizedBox(height: 10),
                              getContainerForPopUpInChapter(context,
                                  height: height - 20,
                                  width: width,
                                  imageAddress: 'assets/images/video Play.png',
                                  borderColor: borderColor,
                                  buttonText: videoCount,
                                  // '21',
                                  buttonColor: colorList[1],
                                  courseTitle: 'Videos',
                                  chapterId: chapterId,
                                  innerContainerColor: Color(0XFFC6DBFF)),
                              SizedBox(height: 10),
                              getContainerForPopUpInChapter(context,
                                  height: height - 20,
                                  width: width,
                                  imageAddress: 'assets/images/user.png',
                                  borderColor: borderColor,
                                  buttonText: referenceCount,
                                  // '21',
                                  buttonColor: colorList[3],
                                  courseTitle: 'Reference',
                                  chapterId: chapterId,
                                  innerContainerColor: Color(0XFFEFE3DF)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: Text(buttonText, style: kHomePageCourseAndNewsButtonText),
            style: getButtonStyleWithoutPadding(
                buttonColor: buttonColor, width: width, height: height),
          )
        ],
      ),
    ),
  );
}

Container getContainerForPopUpInChapter(BuildContext context,
    {double height,
    double width,
    String imageAddress,
    String courseTitle,
    String chapterId,
    String buttonText,
    Color buttonColor,
    Color innerContainerColor,
    Color borderColor,
    String videoCount,
    String notesCount,
    String referenceCount}) {
  return Container(
    height: 83,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        )),
    child: Padding(
      padding: EdgeInsets.only(
        top: (10 / height) * height,
        bottom: (10 / height) * height,
        left: (10 / width) * width,
        right: (10 / width) * width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: (60 / height) * height,
            width: (60 / width) * width,
            decoration: BoxDecoration(
                color: innerContainerColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Image.asset(imageAddress, fit: BoxFit.fill),
            ),
          ),
          SizedBox(width: (10 / width) * width),
          Text(courseTitle, style: kHomePageProfileNamesStyle),
          Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              // //for chapter page a named parameter pageName='Chapter',for courses pageName=null,for videos pageName='Videos'
              if (courseTitle == 'Videos') {
                Provider.of<StudentProvider>(context, listen: false)
                    .getSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedSubCategoryOfChapter(
                        chapterId, '1', courseTitle);
                Navigator.popAndPushNamed(
                    context, '/ChapterSubCategoryReference');
              } else if (courseTitle == 'Reference') {
                Provider.of<StudentProvider>(context, listen: false)
                    .getSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedSubCategoryOfChapter(
                        chapterId, '3', courseTitle);
                Navigator.popAndPushNamed(
                    context, '/ChapterSubCategoryReference');
              } else if (courseTitle == 'Notes') {
                Provider.of<StudentProvider>(context, listen: false)
                    .getSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedSubCategoryOfChapter(
                        chapterId, '2', courseTitle);
                Navigator.popAndPushNamed(context, '/ChapterSubCategoryNotes');
              }
            },
            child: Text(buttonText, style: kHomePageCourseAndNewsButtonText),
            style: getButtonStyleWithoutPadding(
                buttonColor: buttonColor, width: width, height: height),
          )
        ],
      ),
    ),
  );
}

UtilityService utilityService = UtilityService();
SizedBox getMorOptionContainerInsideCourse(
    {double height,
    double width,
    String imageAddress,
    String title,
    bool isSelected,
    Map credentialMap,
    Map batchIdAndName}) {
  return SizedBox(
    height: (60 / height) * height,
    width: (163.5 / width) * width,
    child: Card(
        color: isSelected ? Color(0XFFA6B2FF) : Color(0XFFF5F6FC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () async {
            if (title == 'Announcement') {
              await utilityService.getStudentAnnouncements(
                  credentialMap, batchIdAndName['id']);
            } else if (title == 'Time table') {
              await utilityService.getStudentTimeTable(
                  credentialMap, batchIdAndName['id']);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: (10 / width) * width,
                right: (10 / width) * width,
                top: (10 / height) * height,
                bottom: (10 / height) * height),
            child: Row(
              children: [
                Image.asset(imageAddress,
                    color: isSelected ? Colors.white : Colors.black),
                SizedBox(width: (10 / width) * width),
                Text(title,
                    style: isSelected
                        ? title.length > 10
                            ? kCoursePageMoreOptionsSelectedTextSizeGrtThn10
                            : kCoursePageMoreOptionsSelectedText
                        : title.length > 10
                            ? kCoursePageMoreOptionsUnSelectedTextSizeGrtThn10
                            : kCoursePageMoreOptionsUnSelectedText)
              ],
            ),
          ),
        )),
  );
}

class CommonBottomNavigationBar extends StatelessWidget {
  final double width;
  final double height;
  final String pageName;
  CommonBottomNavigationBar({this.width, this.height, this.pageName});
  final Color activeColor = Color(0XFF00AEEF);
  final Color inactiveIconColor = Color(0XFFBABABA);
  final Color inactiveDividerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Map profileMap = Provider.of<StudentProvider>(context).profileMap;
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (pageName != 'Home')
                Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
            },
            child: Container(
              width: (80 / width) * width,
              height: (60 / height) * height,
              child: Column(children: [
                SizedBox(
                  width: (25 / width) * width,
                  child: Divider(
                    thickness: 2,
                    color:
                        pageName == 'Home' ? activeColor : inactiveDividerColor,
                  ),
                ),
                Icon(
                  Icons.home,
                  color: pageName == 'Home' ? activeColor : inactiveIconColor,
                ),
                Text('Home',
                    style: pageName == 'Home'
                        ? kHomePageBottomNavBarSelectedText
                        : kHomePageBottomNavBarText),
              ]),
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<StudentProvider>(context, listen: false)
                  .getProfileMap(profileMap);
              Provider.of<RegistrationProvider>(context, listen: false)
                  .getDob({});
              Navigator.pushNamed(context, '/Register2');
            },
            child: SizedBox(
              height: (60 / height) * height,
              width: (80 / width) * width,
              child: Column(children: [
                SizedBox(
                  width: (25 / width) * width,
                  child: Divider(
                    thickness: 2,
                    color: pageName == 'Profile'
                        ? activeColor
                        : inactiveDividerColor,
                  ),
                ),
                Icon(
                  Icons.perm_identity,
                  color:
                      pageName == 'Profile' ? activeColor : inactiveIconColor,
                ),
                Text('Profile',
                    style: pageName == 'Profile'
                        ? kHomePageBottomNavBarSelectedText
                        : kHomePageBottomNavBarText)
              ]),
            ),
          ),
          SizedBox(
            width: (80 / width) * width,
            height: (60 / height) * height,
            child: InkWell(
              onTap: () {},
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: (25 / width) * width,
                      child: Divider(
                        thickness: 2,
                        color: pageName == 'Notification'
                            ? activeColor
                            : inactiveDividerColor,
                      ),
                    ),
                    Icon(Icons.notifications_none_rounded,
                        color: pageName == 'Notification'
                            ? activeColor
                            : inactiveIconColor),
                    Text('Notification',
                        style: pageName == 'Notification'
                            ? kHomePageBottomNavBarSelectedText
                            : kHomePageBottomNavBarText)
                  ]),
            ),
          ),
          SizedBox(
            width: (80 / width) * width,
            height: (60 / height) * height,
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: (25 / width) * width,
                    child: Divider(
                        thickness: 2,
                        color: pageName == 'About'
                            ? activeColor
                            : inactiveDividerColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: (4.0 / height) * height),
                    child: Image(
                        image: AssetImage('assets/images/More Circle.png'),
                        color: pageName == 'About'
                            ? activeColor
                            : inactiveIconColor),
                  ),
                  Text('About',
                      style: pageName == 'About'
                          ? kHomePageBottomNavBarSelectedText
                          : kHomePageBottomNavBarText)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
