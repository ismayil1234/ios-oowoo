import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oowoo/Conrollers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

class Chapter extends StatefulWidget {
  @override
  _ChapterState createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
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
    String batchId = Provider.of<StudentProvider>(context)
        .studentSelectedBatchIdAndNameForSelectedSubject['id'];
    Map<String, dynamic> subjectMapWithNameAndId =
        Provider.of<StudentProvider>(context)
            .studentSelectedSubjectIdAndNameForSelectedChapterApi;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                  subjectMapWithNameAndId['subjectName']
                  // 'English'
                  ,
                  style: kHomePageHeadingTexts),
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
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: (20 / height) * height),
                    SizedBox(
                      child: TextField(
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0XFFF3FBFF),
                            hintText: 'Search Chapter',
                            hintStyle: kHomePageCourseAndNewsItemTexts,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            )),
                      ),
                    ),
                    credentialMap != {}
                        ? FutureBuilder(
                            future: utilityService.selectChaptersUnderSubject(
                                credentialMap,
                                batchId,
                                subjectMapWithNameAndId['id']),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return AnimatingCircle();
                              } else if (snapshot.data[0] == null ||
                                  snapshot.data[0]['id'] == '0') {
                                return Text('No Data');
                              } else {
                                List chapterList = snapshot.data;
                                return ListView.builder(
                                    itemCount: chapterList.length,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: getContainerForCourses(context,
                                              courseTitle: chapterList[index]
                                                  ['name'],
                                              chapterId: chapterList[index]
                                                  ['id'],
                                              imageAddress:
                                                  'assets/images/Paper.png',
                                              buttonText: (int.parse(
                                                          chapterList[index]
                                                              ['video_count']) +
                                                      int.parse(chapterList[index]
                                                          ['note_count']) +
                                                      int.parse(chapterList[index]
                                                          ['ref_count']))
                                                  .toString(),
                                              innerContainerColor:
                                                  Color(0XFFFAFAFA),
                                              borderColor: Color(0XFFEEEEEE),
                                              buttonColor: colorList[index],
                                              height: height + 20,
                                              width: width,
                                              pageName: 'Chapter',
                                              videoCount: chapterList[index]
                                                  ['video_count'],
                                              notesCount: chapterList[index]
                                                  ['note_count'],
                                              referenceCount: chapterList[index]['ref_count']),
                                        ));
                              }
                            })
                        : SizedBox(),
                    SizedBox(height: (20 / height) * height),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CommonBottomNavigationBar(
                width: width, height: height, pageName: '')));
  }
}
