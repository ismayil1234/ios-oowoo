// import 'dart:html';

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oowoo/Controllers/registration_Provider.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/Utilities/methods.dart';
import 'package:oowoo/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UtilityService utilityService = UtilityService();
  Map<String, dynamic> credentialMap = {};
  Map profileMap = {};
  List departmentList = [];
  List<String> carousalList = [
    'assets/images/Slider1.png',
    'assets/images/logo.jpeg'
  ];
  Map<String, dynamic> carousalMapFromNetwork = {};
  int selectedCarousalIndex;
  final storage = FlutterSecureStorage();
  Future getBasicCredentials() async {
    credentialMap = await storage.readAll();
  }

  Future getProfileAsMap() async {
    await utilityService.getStudentProfile(credentialMap).then((value) async {
      profileMap = value;
      String address = profileMap['photo'];
      await getImage(address).then((val) {
        if (val != '') profileMap['imageAsBytes'] = val;
        Provider.of<StudentProvider>(context, listen: false)
            .getProfileMap(profileMap);
      });
    });
  }

  Future getDepartments() async {
    List departmenList = await utilityService.getDepartments(credentialMap);
    setState(() {
      departmentList = departmenList;
    });
  }

  List<String> fullAddressList = [];
  Future getCarousalList() async {
    List<String> fulAddressList = [];
    Map<String, dynamic> m =
        await utilityService.getSelectBannerForHome(credentialMap);
    if (m != null && m['images'] != null)
      for (int i = 0; i < m['images'].length; i++) {
        String a = m['images'][i]['banner_img'].toString();
        String b = m['path'].toString();
        fullAddressList.add(b + a);
        fulAddressList.add(b + a);
        m['fullImageAddressList'] = fullAddressList;
      }
    setState(() {
      fullAddressList = fulAddressList;
      carousalMapFromNetwork = m;
    });
  }

  @override
  void initState() {
    super.initState();
    getBasicCredentials().whenComplete(() {
      getCarousalList();
      getProfileAsMap();
      getDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            SizedBox(
              height: (130 / height) * height,
              width: (300 / width) * width,
              child: DrawerHeader(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: (8 / width) * width,
                      top: (16 / height) * height,
                      bottom: (16 / height) * height),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            minRadius: 30,
                            child: SizedBox(
                              height: (58 / height) * height,
                              width: (58 / width) * width,
                              child: Center(
                                  child: ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                    'assets/images/ProfileAvatar.png',
                                    fit: BoxFit.fill),
                              )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: (10 / width) * width),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profileMap['student_id'] != null
                              ? 'ID : ${profileMap['student_id']}'
                              : ''),
                          Text(profileMap['name'] != null
                              ? profileMap['name']
                              : ''),
                          Text(profileMap['phone_number'] != null
                              ? profileMap['phone_number']
                              : ''),
                          Text(profileMap['email'] != null
                              ? profileMap['email']
                              : ''),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
            )
          ],
        )),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: [
            ClipRRect(
              child: InkWell(
                onTap: () {
                  Provider.of<StudentProvider>(context, listen: false)
                      .getCredentialMapInProvider(credentialMap);
                  Provider.of<StudentProvider>(context, listen: false)
                      .getProfileMap(profileMap);
                  Navigator.pushNamed(context, '/Wallet');
                },
                focusColor: Color(0XFFc8e8f7),
                hoverColor: Color(0XFFc8e8f7),
                highlightColor: Color(0XFFc8e8f7),
                splashColor: Color(0XFFc8e8f7),
                child: CircleAvatar(
                    // radius: 20,
                    child: Center(
                      child: Image.asset('assets/images/Wallet.png'),
                    ),
                    backgroundColor: Colors.transparent),
              ),
            ),
            SizedBox(width: (15 / width) * width
                // wdt10 * width,
                ),
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
              left: (20 / width) * width,
              right: (20 / width) * width,
              top: (20 / height) * height,
              bottom: (20 / height) * height),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: (10 / height) * height),
              carousalMapFromNetwork['fullImageAddressList'] != null
                  ? SizedBox(
                      child: Column(
                        children: [
                          SizedBox(width: (2 / width) * width),
                          CarouselSlider.builder(
                            itemCount:
                                carousalMapFromNetwork['fullImageAddressList']
                                    .length,
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                autoPlay: true,
                                autoPlayCurve: Curves.easeIn,
                                //height:150
                                height: (160 / height) * height,
                                viewportFraction: 1.1,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 1000),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    selectedCarousalIndex = index;
                                  });
                                }),
                            itemBuilder: (context, index, ind) {
                              return Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: (2 / height) * height),
                                width: width - 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${carousalMapFromNetwork['fullImageAddressList'][index]}',
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Image.asset(
                                          'assets/images/Slider1.png',
                                          fit: BoxFit.fill);
                                    },
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                          fullAddressList != []
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: fullAddressList.map((url) {
                                    int index = fullAddressList.indexOf(url);
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: (4 / width) * width,
                                          right: (4 / height) * height),
                                      child: Container(
                                        width: selectedCarousalIndex == index
                                            ? (11 / width) * width
                                            : (7 / width) * width,
                                        height: selectedCarousalIndex == index
                                            ? (11.0 / height) * height
                                            : (7.0 / height) * height,
                                        margin: EdgeInsets.symmetric(
                                            vertical: (10.0 / height) * height,
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: selectedCarousalIndex ==
                                                    index
                                                ? Color(0XFF00AEEF)
                                                // Color.fromRGBO(0, 0, 0, 0.9)
                                                : Color(0XFF00AEEF)
                                            // Color.fromRGBO(0, 0, 0, 0.4),
                                            ),
                                      ),
                                    );
                                  }).toList()
                                  //     // : [SizedBox()],
                                  )
                              : SizedBox()
                        ],
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: (20 / height) * height),
              SizedBox(
                child: TextField(
                  // focusNode: ,
                  readOnly: true,
                  onTap: () async {
                    await utilityService.getLiveLinks(credentialMap);
                    Provider.of<StudentProvider>(context, listen: false)
                        .getProfileMap(profileMap);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0XFFF3FBFF),
                      hintText: 'Search your best course',
                      hintStyle: kHomePageCourseAndNewsItemTexts,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      )),
                ),
              ),
              SizedBox(height: (20 / height) * height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    highlightColor: Colors.white,
                    // (0XFF07e080),
                    onTap: () async {
                      // print('credentialMap is $credentialMap');
                      Provider.of<StudentProvider>(context, listen: false)
                          .getProfileMap(profileMap);
                      await utilityService
                          .getInstitutionalRequestForStudents(credentialMap)
                          .then((value) => print(value));
                    },
                    focusColor: Colors.white,
                    child: getHomePageColumnInsideRow(
                        'assets/images/Document.png',
                        Color(0xFF29DD8D),
                        'Institutional\n\t\t Request'),
                  ),
                  InkWell(
                      highlightColor: Colors.white,
                      onTap: () {},
                      focusColor: Colors.white,
                      child: getHomePageColumnInsideRow(
                          'assets/images/Ticket Star.png',
                          Color(0xFF8FB6FF),
                          'Quiz\n')),
                  InkWell(
                    highlightColor: Colors.white,
                    onTap: () {},
                    focusColor: Colors.white,
                    child: getHomePageColumnInsideRow('assets/images/Chat.png',
                        Color(0xFFFF9B7D), '\t\t\t\t\t\tMeet\nPsychologist'),
                  )
                ],
              ),
              SizedBox(height: (20 / height) * height),
              Text('What would you learn today ?',
                  style: kHomePageHeadingTexts),
              SizedBox(height: (30 / height) * height),
              SizedBox(
                child: Card(
                  color: Color(0XFFFAFAFA),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: (10 / width) * width,
                        right: (10 / width) * width,
                        top: (10 / height) * height,
                        bottom: (10 / height) * height),
                    child: FutureBuilder(
                      future: utilityService.selectCourse(credentialMap),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return AnimatingCircle();
                        } else {
                          List selectedList = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: selectedList.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: (10 / width) * width,
                                        right: (10 / width) * width,
                                        top: (10 / height) * height,
                                        bottom: (10 / height) * height),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: (60 / height) * height,
                                          width: (60 / width) * width,
                                          decoration: BoxDecoration(
                                              color: index.isEven
                                                  ? Color(0XFFF6BB00)
                                                  : Color(0XFFFFBAC0),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Image.asset(
                                                  index.isEven
                                                      ? 'assets/images/ProfileImage2.png'
                                                      : 'assets/images/ProfileImage1.png',
                                                  fit: BoxFit.fill)),
                                        ),
                                        SizedBox(width: (10 / width) * width),
                                        MyCustomColumn(
                                            courseText: selectedList[index]
                                                ['name'],
                                            institute: selectedList[index]
                                                ['institute_name'],
                                            iStyle: kHomePageInstituteStyle,
                                            cStyle:
                                                kHomePageCourseHeaderItemTexts),
                                        Expanded(child: SizedBox()),
                                        ElevatedButton(
                                          onPressed: () {
                                            Provider.of<StudentProvider>(
                                                    context,
                                                    listen: false)
                                                .getProfileMap(profileMap);
                                            Provider.of<StudentProvider>(
                                                    context,
                                                    listen: false)
                                                .getSelectedBatchIdAndCourseNameForSelectedSubject(
                                                    selectedList[index]
                                                        ['batch_id'],
                                                    selectedList[index]
                                                        ['name']);
                                            Navigator.pushNamed(
                                                context, '/Course');
                                          },
                                          child: Text('Click',
                                              style:
                                                  kHomePageCourseAndNewsButtonText),
                                          style: getButtonStyle(
                                              buttonColor: colorList[index],
                                              width: width,
                                              height: height),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: (30 / height) * height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Course', style: kHomePageHeadingTexts),
                  Text('View all', style: kHomePageViewAllTextStyle)
                ],
              ),
              SizedBox(height: (20 / height) * height),
              SizedBox(
                child: FutureBuilder(
                    future: utilityService.getTrendingCourses(credentialMap),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: 100,
                          width: width - 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatingCircle(),
                            ],
                          ),
                        );
                      } else {
                        List courseList = snapshot.data;
                        // print(courseList);
                        return courseList != [] && courseList != null
                            ? SizedBox(
                                height: (230 / height) * height,
                                width: (160 / width) * width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: courseList.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: (230 / height) * height,
                                      width: (160 / width) * width,
                                      child: Card(
                                        color: Color(0XFFFFF1F0),
                                        child: InkWell(
                                          highlightColor: Color(0XFFebada9),
                                          onTap: () async {
                                            Provider.of<StudentProvider>(
                                                    context,
                                                    listen: false)
                                                .getProfileMap(profileMap);
                                          },
                                          hoverColor: Color(0XFFebada9),
                                          splashColor: Color(0XFFebada9),
                                          focusColor: Color(0XFFebada9),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Center(
                                                  child: Image.asset(
                                                      'assets/images/Course1.png')),
                                              Text(courseList[index]['name'],
                                                  // courseList[0]['name'],
                                                  // 'Course 1',
                                                  style:
                                                      kHomePageTrendingCourseNumberStyle)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox();
                      }
                    }),
              ),
              SizedBox(height: (30 / height) * height),
              Text('Department', style: kHomePageHeadingTexts),
              SizedBox(height: (20 / height) * height),
              departmentList != []
                  ? Container(
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: departmentList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 3 : 5),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: (100 / height) * height,
                            width: (106.6 / width) * width,
                            child: InkWell(
                              highlightColor: Color(0XFFb1f0f0),
                              onTap: () {
                                Provider.of<StudentProvider>(context,
                                        listen: false)
                                    .getProfileMap(profileMap);
                              },
                              hoverColor: Color(0XFFb1f0f0),
                              splashColor: Color(0XFFb1f0f0),
                              focusColor: Color(0XFFb1f0f0),
                              child: Card(
                                color: Color(0XFFF4F5F5),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            departmentList[index]
                                                ['deapartments'],
                                            style:
                                                kHomePageCourseCategoryTextStyle,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: (30 / height) * height),
              Text('Latest News', style: kHomePageHeadingTexts),
              SizedBox(height: (20 / height) * height),
              InkWell(
                highlightColor: Color(0XFFf7d9c1),
                onTap: () {},
                hoverColor: Color(0XFFf7d9c1),
                splashColor: Color(0XFFf7d9c1),
                focusColor: Color(0XFFf7d9c1),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: (60 / height) * height,
                    width: (60 / width) * width,
                    decoration: BoxDecoration(
                        color: Color(0XFFFFEFE2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Image.asset('assets/images/Paper.png',
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                        text: '8 Tasks today\n',
                        style: kHomePageLatestNewsTasksLargeText,
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'Meet them & Share '
                                  // 'your'
                                  ' experience',
                              style: kHomePageCourseAndNewsItemTexts)
                        ]),
                  ),
                ),
              ),
              SizedBox(height: (10 / height) * height),
              InkWell(
                highlightColor: Color(0XFFb1eafa),
                onTap: () {},
                hoverColor: Color(0XFFb1eafa),
                splashColor: Color(0XFFb1eafa),
                focusColor: Color(0XFFb1eafa),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: (60 / height) * height,
                    width: (60 / width) * width,
                    decoration: BoxDecoration(
                        color: Color(0XFFCCF4FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Image.asset('assets/images/Calendar.png',
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                        text: 'Events\n',
                        style: kHomePageLatestNewsTasksLargeText,
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'Create & Share events',
                              style: kHomePageCourseAndNewsItemTexts)
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: (80 / width) * width,
                  height: (60 / height) * height,
                  child: Column(children: [
                    SizedBox(
                      width: (25 / width) * width,
                      child: Divider(
                        thickness: 2,
                        color: Color(0XFF00AEEF),
                      ),
                    ),
                    Icon(
                      Icons.home,
                      color: Color(0XFF00AEEF),
                    ),
                    Text('Home', style: kHomePageBottomNavBarSelectedText),
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
                      child: Divider(thickness: 2, color: Colors.white),
                    ),
                    Icon(Icons.perm_identity, color: Color(0XFFBABABA)),
                    Text('Profile', style: kHomePageBottomNavBarText)
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
                          child: Divider(thickness: 2, color: Colors.white),
                        ),
                        Icon(Icons.notifications_none_rounded,
                            color: Color(0XFFBABABA)),
                        Text('Notification', style: kHomePageBottomNavBarText)
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
                        child: Divider(thickness: 2, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: (4.0 / height) * height),
                        child: Image(
                            image: AssetImage('assets/images/More Circle.png')),
                      ),
                      Text('About', style: kHomePageBottomNavBarText)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox getHomePageCourseCategoryCard(String title,
      {double height, double width}) {
    return SizedBox(
      height: (100 / height) * height,
      width: (106.6 / width) * width,
      child: InkWell(
        highlightColor: Color(0XFFb1f0f0),
        onTap: () {},
        hoverColor: Color(0XFFb1f0f0),
        splashColor: Color(0XFFb1f0f0),
        focusColor: Color(0XFFb1f0f0),
        child: Card(
          color: Color(0XFFF4F5F5),
          child: Center(
            child: Text(title,
                style: kHomePageCourseCategoryTextStyle,
                overflow: TextOverflow.visible),
          ),
        ),
      ),
    );
  }

  Column getHomePageColumnInsideRow(
      String imageAddress, Color backGroundColor, String text) {
    return Column(
      children: [
        CircleAvatar(
          child: Center(child: Image.asset(imageAddress)),
          backgroundColor: backGroundColor,
        ),
        Text(text, style: kHomePageCourseAndNewsItemTexts)
      ],
    );
  }

  bool isColumnLoaded = false;
  List<Text> myColumn;
  List<Text> getColumn(
      {String course,
      String institute,
      TextStyle courseStyle,
      TextStyle instiStyle}) {
    String nextText2 = institute;
    List<Text> widgetList = [];
    String balance;
    String a;
    for (int i = 0; i < institute.length; i + 10) {
      if (i == 0) {
        a = getTextFromLongString(nextText2)['text'];
        balance = getTextFromLongString(nextText2)['remaining'];
        widgetList.add(Text(a, style: instiStyle));
      } else {
        if (balance != '') {
          nextText2 = balance;
          a = getTextFromLongString(nextText2)['text'];
          balance = getTextFromLongString(nextText2)['remaining'];
          widgetList.add(Text(a, style: instiStyle));
        }
      }
    }
    setState(() {
      isColumnLoaded = true;
      myColumn = widgetList;
    });
    return widgetList;
  }

  Map<String, String> getTextFromLongString(String text) {
    Map<String, String> resultAsMap = {};
    if (text.length > 10) {
      String result;
      String remaining;
      if (text.contains('')) {
        result = text.substring(0, text.indexOf('') + 1);
        remaining = text.substring(text.indexOf(''), text.length);
        resultAsMap['text'] = result;
        resultAsMap['remaining'] = remaining;
      } else {
        result = text.substring(0, 11);
        remaining = text.substring(11, text.length);
        resultAsMap['text'] = result;
        resultAsMap['remaining'] = remaining;
      }
      return resultAsMap;
    } else {
      resultAsMap['text'] = text;
      resultAsMap['remaining'] = '';
      return resultAsMap;
    }
  }
}

class MyCustomColumn extends StatelessWidget {
  final String courseText;
  final String institute;
  final TextStyle iStyle;
  final TextStyle cStyle;
  MyCustomColumn({this.courseText, this.institute, this.iStyle, this.cStyle});
  List<Text> getColumnList(String c, String i) {
    List<Text> textList = [];
    //course
    if (courseText.length < 14) {
      textList.add(Text(courseText, style: cStyle));
    } else if (courseText.length > 13) {
      List courseList = courseText.split(' ');
      List result1 = getResultUsingRecursion(courseList);
      for (int i = 0; i < result1.length; i++) {
        //kHomePageCourseHeaderItemTexts

        if (result1[i].toString().length <= 15) {
          textList.add(Text(result1[i], style: cStyle));
        }
        // else if (result1[i].toString().length == 15) {
        //   textList.add(Text(result1[i], style: cStyle));
        //   //  kHomePageCourseHeaderItemTexts13
        // }
        else {
          double fontSize = 16.0;
          double length = 14.0;
          double difference = result1[i].toString().length - length;
          TextStyle kHomePageCourseHeaderItemTextsHere = TextStyle(
            fontSize: fontSize - difference,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
            color: Color(0XFF130F26),
          );
          textList
              .add(Text(result1[i], style: kHomePageCourseHeaderItemTextsHere));
        }
        // textList.add(Text(result1[i], style: cStyle));
      }
    }
    //Institute

    if (institute.length < 14) {
      textList.add(Text(institute, style: iStyle));
    } else if (institute.length > 13) {
      List instituteList = institute.split(' ');
      List result2 = getResultUsingRecursion(instituteList);
      for (int k = 0; k < result2.length; k++) {
        if (result2[k].toString().length <= 14) {
          textList.add(Text(result2[k], style: iStyle));
        } else {
          double fontSize = 16.0;
          double length = 14.0;
          double difference = result2[k].toString().length - length;
          TextStyle kHomePageInstituteStyleHere = TextStyle(
            fontSize: fontSize - difference,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0XFF130F26),
          );
          textList.add(Text(result2[k], style: kHomePageInstituteStyleHere));
        }
      }
    }
    return textList;
  }

  List result = [];

  List getResultUsingRecursion(List allList) {
    List subList1 = [];
    int i = 0;
    if (allList[0] != 'empty' && allList != []) {
      if (i + 1 < allList.length) {
        if ((allList[i] + allList[i + 1]).toString().length < 13) {
          if (i + 2 < allList.length) {
            subList1 = allList.sublist(i + 2);
            subList1.insert(0, allList[i] + ' ' + allList[i + 1]);
            allList = subList1;
            getResultUsingRecursion(allList);
          } else {
            if ((allList[i] + allList[i + 1]).toString().length < 13) {
              String txt = allList[i] + ' ' + allList[i + 1];
              result.add(txt);
            } else {
              result.add(allList[i]);
              result.add(allList[i + 1]);
            }
            allList[0] = 'empty';
            getResultUsingRecursion(allList);
          }
        } else {
          result.add(allList[i]);
          if (allList.length > 2) {
            List a = allList.sublist(i + 1);
            getResultUsingRecursion(a);
          } else {
            result.add(allList[i + 1]);
            allList[0] = 'empty';
            getResultUsingRecursion(allList);
          }
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: getColumnList(this.courseText, this.courseText),
    );
  }
}
