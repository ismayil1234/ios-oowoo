import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oowoo/Controllers/Login_Provider.dart';
import 'package:oowoo/Controllers/pdf_or_document_Provider.dart';
import 'package:oowoo/Controllers/registration_Provider.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/constants.dart';
// import 'package:oowoo/view/StateLess/ResizeProfileImage.dart';
// import 'package:oowoo/view/StateLess/playVideo.dart';
// import 'package:oowoo/view/chapter.dart';
import 'package:oowoo/view/Login.dart';
// import 'package:oowoo/view/chapter_subcategory.dart';
// import 'package:oowoo/view/chapter_subcategory_notes.dart';
// import 'package:oowoo/view/chapter_subcategory_reference.dart';
// import 'package:oowoo/view/course.dart';
// import 'package:oowoo/view/home.dart';
// import 'package:oowoo/view/pdfviewer.dart';
// import 'package:oowoo/view/register.dart';
// import 'package:oowoo/view/register2.dart';
// import 'package:oowoo/view/wallet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // runApp(MyApp());
    // }
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<StudentProvider>(create: (_) => StudentProvider()),
      ChangeNotifierProvider<RegistrationProvider>(
          create: (_) => RegistrationProvider()),
      ChangeNotifierProvider<PdfOrDocumentProvider>(
          create: (_) => PdfOrDocumentProvider()),
    ], child: MyApp()));
  });
  // child: MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        Route myRoute;
        switch (settings.name) {
          case '/':
            myRoute = CupertinoPageRoute(
                builder: (_) => MyHomePage(), settings: settings);
            break;
          case '/CommonLogIn':
            myRoute =
                CupertinoPageRoute(builder: (_) => LogIn(), settings: settings);
            break;
          // case '/Register':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => Register(), settings: settings);
          //   break;
          // case '/Register2':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => Register2(), settings: settings);
          //   break;
          // case '/ResizeProfileImage':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => ResizeProfileImage(), settings: settings);
          //   break;
          // case '/Course':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => Course(), settings: settings);
          //   break;
          // case '/HomePage':
          //   myRoute =
          //       CupertinoPageRoute(builder: (_) => Home(), settings: settings);
          //   break;
          // case '/Wallet':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => Wallet(), settings: settings);
          //   break;
          // case '/Chapter':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => Chapter(), settings: settings);
          //   break;
          // case '/ChapterSubCategory':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => ChapterSubCategory(), settings: settings);
          //   break;
          // case '/ChapterSubCategoryNotes':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => ChapterSubCategoryNotes(), settings: settings);
          //   break;
          // case '/PdfViewer':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => MyPdfViewer(), settings: settings);
          //   break;
          // case '/ChapterSubCategoryReference':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => ChapterSubCategoryReference(),
          //       settings: settings);
          //   break;
          // case '/CustomVideo':
          //   myRoute = CupertinoPageRoute(
          //       builder: (_) => PlayVideo(), settings: settings);
          //   break;
        }
        return myRoute;
      },
      theme: ThemeData(
        backgroundColor: Color(0xFF00AEEF),
        scaffoldBackgroundColor: Color(0XFFFFFFFF),
        primarySwatch: colorCustom,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var secureStorage = FlutterSecureStorage();
  // Future<String>
  String token;
  Future getjwtToken() async {
    String jwt = await secureStorage.read(key: "jwt");
    setState(() {
      token = jwt;
    });
  }

  @override
  void initState() {
    String routeName;
    getjwtToken().whenComplete(() {
      token == null ? routeName = '/CommonLogIn' : routeName = '/HomePage';
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(
          context,
          routeName,
          (Route<dynamic> route) => false,
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
          height: height,
          width: width,
          child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.fill)),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many time:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), //
//     );
//   }
// }
