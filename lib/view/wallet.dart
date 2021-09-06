import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

class Wallet extends StatelessWidget {
  final UtilityService utilityService = UtilityService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, dynamic> credMapForPro =
        Provider.of<StudentProvider>(context).credentialMapInProvider;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Wallet', style: kHomePageHeadingTexts),
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
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/CommonLogIn',
                              (Route<dynamic> route) => false,
                            );
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
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: utilityService.getStudentWalletInfo(credMapForPro),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                children: [SizedBox(height: height / 3), AnimatingCircle()],
              );
            } else
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              colors: [Color(0XFF0BB27E), Color(0XFF0BB27E)])),
                      height: (200 / height) * height,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: (20 / width) * width,
                            top: (50 / height) * height),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Current Balance',
                                style: kCoursePageMoreOptionsSelectedText),
                            SizedBox(),
                            Text('\$${snapshot.data['balance']}',
                                style: kWalletBalanceTextStyle),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: (15 / height) * height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Details', style: kHomePageHeadingTexts),
                        Text('See All', style: kWalletPageSeeAllText),
                      ],
                    ),
                    SizedBox(height: (15 / height) * height),
                    PaymentDetailsListTileInsideWallet(
                        imageName: 'wallet money.png',
                        containerColor: Color(0XFFF79A28),
                        titleText: 'Course Fee',
                        subTitleText: 'Credit',
                        trailingText: snapshot.data['credit'],
                        width: width,
                        height: height),
                    Divider(),
                    PaymentDetailsListTileInsideWallet(
                        imageName: 'empty wallet.png',
                        containerColor: Color(0XFF5F59E1),
                        titleText: 'Course Fee Cancelled',
                        subTitleText: 'Debit',
                        trailingText: snapshot.data['credit'],
                        width: width,
                        height: height),
                    Divider(),
                    PaymentDetailsListTileInsideWallet(
                        imageName: 'money send.png',
                        containerColor: Color(0XFF24282C),
                        titleText: 'Registration Bonus',
                        subTitleText: 'Credit',
                        trailingText: snapshot.data['credit'],
                        width: width,
                        height: height)
                  ],
                ),
              );
          },
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
                child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
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
              onTap: () {},
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
                  // mainAxisSize: MainAxisSize.min,
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
    ));
  }
}

class PaymentDetailsListTileInsideWallet extends StatelessWidget {
  final String imageName;
  final String titleText;
  final String subTitleText;
  final String trailingText;
  final Color containerColor;
  final double width;
  final double height;
  PaymentDetailsListTileInsideWallet(
      {this.imageName,
      this.titleText,
      this.subTitleText,
      this.trailingText,
      this.containerColor,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
              child: Center(
                child: Image.asset('assets/images/$imageName'),
              ),
              height: (83 / height) * height,
              width: (60 / width) * width,
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: containerColor,
                  ))),
          title: Text(titleText, style: kHomePageProfileNamesStyle),
          subtitle: Text(subTitleText, style: kWalletPageSubTitleTextStyle),
          trailing:
              Text('\$$trailingText', style: kWalletPageTrailingAmountsStyle)),
    );
  }
}
