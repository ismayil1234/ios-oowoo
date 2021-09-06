import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
// import 'package:oowoo/view/StateLess/playVideo.dart';
// import 'file:///E:/LeapProjects/oowoo/lib/view/playVideo.dart';
// import 'package:oowoo/view/playYoutubeVideo.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChapterSubCategory extends StatefulWidget {
  @override
  _ChapterSubCategoryState createState() => _ChapterSubCategoryState();
}

class _ChapterSubCategoryState extends State<ChapterSubCategory> {
  VideoPlayerController playerController;
  VoidCallback listener;
  UtilityService utilityService = UtilityService();
  Map credentialMap = {};
  final storage = FlutterSecureStorage();
  Future getBasicCredentials() async {
    Map myMap = await storage.readAll();
    setState(() {
      credentialMap = myMap;
    });
  }

  bool isPressed = false;
  void playVideo(String urL) async {
    if (urL.contains('youtube')) {
      await utilityService.convertYoutubeLinkToUrlForPlayer(urL);
    }

    playerController = VideoPlayerController.network(urL)
      ..addListener(listener)
      ..initialize();
    // ..initialize().then((value) {
    setState(() {
      playerController.value.isPlaying
          ? playerController.pause()
          : playerController.play();
    });
    // });
  }

  secureScreen() async {
    // var a =
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    getBasicCredentials();

    listener = () {
      setState(() {});
    };
    secureScreen();
    super.initState();
  }

  clearFlags() async {
    // var a =
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void dispose() {
    clearFlags();
    super.dispose();
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
              child:
                  // Stack(
                  //   children: [
                  SingleChildScrollView(
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
                            hintText: 'Search Video',
                            hintStyle: kHomePageCourseAndNewsItemTexts,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => AnimatingCircle()));
                              },
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
                                        uurL = 'http://oowoo.in/admin/upload/' +
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height:
                                                        (60 / height) * height,
                                                    width: (60 / width) * width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFFFAFAFA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Image.asset(
                                                          'assets/images/video Play.png',
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          (10 / width) * width),
                                                  Text(
                                                      subCategoryListEgVideo[
                                                          index]['title'],
                                                      // courseTitle,
                                                      style:
                                                          kHomePageProfileNamesStyle),
                                                  Expanded(child: SizedBox()),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      String videoType =
                                                          subCategoryListEgVideo[
                                                              index]['type'];

                                                      Provider.of<StudentProvider>(
                                                              context,
                                                              listen: false)
                                                          .getUrlOfVideo(uurL);
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/CustomVideo');
                                                    },
                                                    child: Text('Play',
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
                        : SizedBox(),
                    // isPressed ? PlayYoutubeVideo(url: videoURL) : SizedBox(),
                    SizedBox(height: (20 / height) * height),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CommonBottomNavigationBar(
                width: width, height: height, pageName: '')));
  }

  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;

  void playYoutube(String uurL) {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(uurL),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listenerYouTube);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listenerYouTube() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  String videoURL;
}
