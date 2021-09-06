import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  UtilityService utilityService = UtilityService();
  Map credentialMap = {};
  final storage = FlutterSecureStorage();
  Future getBasicCredentials() async {
    Map myMap = await storage.readAll();
    setState(() {
      credentialMap = myMap;
    });
  }

  @override
  void initState() {
    getBasicCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, dynamic> courseMap2 = Provider.of<StudentProvider>(context)
        .studentSelectedBatchIdAndNameForSelectedSubject;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title:
                  Text(courseMap2['courseName'], style: kHomePageHeadingTexts),
              automaticallyImplyLeading: false,
              leading: Card(
                color: Color(0XFFFAFAFA),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (8 / width) * width,
                      right: (8 / width) * width,
                      top: (8 / height) * height,
                      bottom: (8 / height) * height),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Log out'),
                            content: Text('Are you sure want to Logout ?'),
                            actions: [
                              ElevatedButton(
                                child: Text('Yes'),
                                onPressed: () async {
                                  await storage.deleteAll().whenComplete(() {
                                    Provider.of<StudentProvider>(context,
                                            listen: false)
                                        .getProfileMap({});
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/CommonLogIn',
                                      (Route<dynamic> route) => false,
                                    );
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    })
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  left: (15 / width) * width,
                  right: (15 / width) * width,
                  top: (15 / height) * height,
                  bottom: (15 / height) * height),
              child: credentialMap != {}
                  ? FutureBuilder(
                      future: utilityService.selectSubject(
                          credentialMap, courseMap2['id']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return AnimatingCircle();
                        } else if (snapshot.data == null) {
                          return Text('No data');
                        } else {
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: (126 / height) * height,
                                  width: double.infinity,
                                  child: Card(
                                    child: Image.asset(
                                        'assets/images/Slider1.png',
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(height: (20 / height) * height),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                          width: width / 2.2,
                                          child: Column(
                                            children: [
                                              Text('Home',
                                                  style:
                                                      kHomePageSelectedPageStyle),
                                              Divider(
                                                thickness: 1,
                                                color: Colors.blue,
                                              )
                                            ],
                                          )),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/Register2');
                                        },
                                        child: SizedBox(
                                            width: width / 2.2,
                                            child: Column(
                                              children: [
                                                Text('Profile',
                                                    style:
                                                        kHomePageLatestNewsTasksLargeText),
                                                Divider(
                                                  thickness: 1,
                                                  color: Color(0XFFEEEEEE),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: (20 / height) * height),
                                Text('Pick your favourite subject',
                                    style: kHomePageHeadingTexts),
                                SizedBox(height: (20 / height) * height),
                                SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 83,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Color(0XFFEEEEEE),
                                            )),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: (10 / height) * height,
                                            bottom: (10 / height) * height,
                                            left: (10 / width) * width,
                                            right: (10 / width) * width,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: (60 / height) * height,
                                                width: (60 / width) * width,
                                                decoration: BoxDecoration(
                                                    color: Color(0XFFDFF2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Image.asset(
                                                      'assets/images/Paper.png'
                                                      // imageAddress
                                                      ,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: (10 / width) * width),
                                              Text(
                                                  snapshot.data[index]
                                                      ['subject_name']
                                                  // courseTitle
                                                  ,
                                                  style:
                                                      kHomePageProfileNamesStyle),
                                              Expanded(child: SizedBox()),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Provider.of<StudentProvider>(
                                                          context,
                                                          listen: false)
                                                      .getSelectedBatchIdAndCourseNameForSelectedChapter(
                                                          snapshot.data[index]
                                                              ['subject_id'],
                                                          snapshot.data[index]
                                                              ['subject_name']);
                                                  Navigator.pushNamed(
                                                      context, '/Chapter');
                                                },
                                                child: Text(
                                                    snapshot.data[index]
                                                        ['total_count'],
                                                    style:
                                                        kHomePageCourseAndNewsButtonText),
                                                style:
                                                    getButtonStyleWithoutPadding(
                                                        buttonColor:
                                                            colorList[index],
                                                        width: width,
                                                        height: height),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: (20 / height) * height),
                                Text('More Options',
                                    style: kHomePageHeadingTexts),
                                SizedBox(height: (20 / height) * height),
                                Row(
                                  children: [
                                    getMorOptionContainerInsideCourse(
                                        imageAddress: 'assets/images/Paper.png',
                                        title: 'Exam',
                                        isSelected: true,
                                        width: width,
                                        height: height),
                                    SizedBox(width: (3 / width) * width),
                                    getMorOptionContainerInsideCourse(
                                        imageAddress:
                                            'assets/images/Progress.png',
                                        title: 'Progress',
                                        isSelected: false,
                                        width: width,
                                        height: height),
                                  ],
                                ),
                                SizedBox(height: (3 / height) * height),
                                Row(
                                  children: [
                                    getMorOptionContainerInsideCourse(
                                        imageAddress:
                                            'assets/images/Calendar.png',
                                        title: 'Time table',
                                        isSelected: false,
                                        width: width,
                                        height: height,
                                        credentialMap: credentialMap,
                                        batchIdAndName: courseMap2),
                                    SizedBox(width: (3 / width) * width),
                                    getMorOptionContainerInsideCourse(
                                        imageAddress:
                                            'assets/images/Message.png',
                                        title: 'Message',
                                        isSelected: false,
                                        width: width,
                                        height: height),
                                  ],
                                ),
                                SizedBox(height: (3 / height) * height),
                                Row(
                                  children: [
                                    getMorOptionContainerInsideCourse(
                                        imageAddress:
                                            'assets/images/Announcement.png',
                                        title: 'Announcement',
                                        isSelected: false,
                                        width: width,
                                        height: height,
                                        credentialMap: credentialMap,
                                        batchIdAndName: courseMap2),
                                  ],
                                ),
                                SizedBox(height: (30 / height) * height),
                              ],
                            ),
                          );
                        }
                      } // ,
                      )
                  : SizedBox(),
            ),
            bottomNavigationBar: CommonBottomNavigationBar(
                width: width, height: height, pageName: '')));
  }
}
