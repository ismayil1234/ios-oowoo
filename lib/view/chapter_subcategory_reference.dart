import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oowoo/Conrollers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

class ChapterSubCategoryReference extends StatefulWidget {
  @override
  _ChapterSubCategoryReferenceState createState() =>
      _ChapterSubCategoryReferenceState();
}

class _ChapterSubCategoryReferenceState
    extends State<ChapterSubCategoryReference> {
  final UtilityService utilityService = UtilityService();
  Map credentialMap = {};
  final storage = FlutterSecureStorage();
  Future getBasicCredentials() async {
    Map myMap = await storage.readAll();
    setState(() {
      credentialMap = myMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String,
        dynamic> chapterSubCategoryWithSubCategoryNameAndIdAndChapterId = Provider
            .of<StudentProvider>(context)
        .studentSelectedChapterIdAndCategoryIdAndCategoryNameForSelectedChapterSubCategory;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                  chapterSubCategoryWithSubCategoryNameAndIdAndChapterId[
                      'categoryName'],
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
                    child: Column(children: [
                      SizedBox(height: (20 / height) * height),
                      SizedBox(
                        child: TextField(
                          // focusNode: ,
                          readOnly: true,
                          onTap: () {},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Color(0XFFF3FBFF),
                              hintText:
                                  'Search ${chapterSubCategoryWithSubCategoryNameAndIdAndChapterId['categoryName']}',
                              hintStyle: kHomePageCourseAndNewsItemTexts,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              )),
                        ),
                      ),
                      SizedBox(height: (20 / height) * height),
                      credentialMap != {}
                          ? FutureBuilder(
                              future: utilityService.selectSubCategoryForChapters(
                                  credentialMap,
                                  chapterSubCategoryWithSubCategoryNameAndIdAndChapterId[
                                      'id'],
                                  chapterSubCategoryWithSubCategoryNameAndIdAndChapterId[
                                      'categoryId']),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return AnimatingCircle();
                                } else if (snapshot.data[0] == null ||
                                    snapshot.data[0]['id'] == '0') {
                                  return Text('No Data');
                                } else {
                                  List subCategoryListEgVideo = snapshot.data;
                                  return ListView.builder(
                                      itemCount: subCategoryListEgVideo.length,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        String uurL =
                                            subCategoryListEgVideo[index]
                                                ['upload_file_name'];
                                        if (!uurL.contains('you') &&
                                            !uurL.contains('be')) {
                                          uurL =
                                              'http://oowoo.in/admin/upload/' +
                                                  uurL;
                                        }
                                        return Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Container(
                                              height: 83,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Color(0XFFEEEEEE),
                                                    // borderColor,
                                                  )),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: (10 / height) * height,
                                                  bottom:
                                                      (10 / height) * height,
                                                  left: (10 / width) * width,
                                                  right: (10 / width) * width,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: (60 / height) *
                                                          height,
                                                      width:
                                                          (60 / width) * width,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0XFFFAFAFA),
                                                          // innerContainerColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                        child: Image.asset(
                                                            chapterSubCategoryWithSubCategoryNameAndIdAndChapterId[
                                                                        'categoryName'] ==
                                                                    'Reference'
                                                                ? 'assets/images/user.png'
                                                                : 'assets/images/video Play.png',
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: (10 / width) *
                                                            width),
                                                    Text(
                                                        subCategoryListEgVideo[
                                                            index]['title'],
                                                        // courseTitle,
                                                        style:
                                                            kHomePageProfileNamesStyle),
                                                    Expanded(child: SizedBox()),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Provider.of<StudentProvider>(
                                                                context,
                                                                listen: false)
                                                            .getUrlOfVideo(
                                                                uurL);
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/CustomVideo');
                                                      },
                                                      child: Text(
                                                          chapterSubCategoryWithSubCategoryNameAndIdAndChapterId[
                                                                      'categoryName'] ==
                                                                  'Reference'
                                                              ? 'View'
                                                              : 'Play',
                                                          // buttonText,
                                                          style:
                                                              kHomePageCourseAndNewsButtonText),
                                                      style:
                                                          getButtonStyleWithoutPadding(
                                                              buttonColor:
                                                                  colorList[
                                                                      index],
                                                              width: width,
                                                              height: height),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                      });
                                }
                              })
                          : SizedBox()
                    ]))),
            bottomNavigationBar: CommonBottomNavigationBar(
                width: width, height: height, pageName: '')));
  }
}
