import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oowoo/Controllers/registration_Provider.dart';
import 'package:oowoo/Controllers/studentProvider.dart';
import 'package:oowoo/Model/Register_Model.dart';
import 'package:oowoo/Services/UtilityService.dart';
import 'package:oowoo/Services/registration_Service.dart';
import 'package:oowoo/Utilities/Widgets.dart';
import 'package:oowoo/Utilities/animatingCircle.dart';
import 'package:oowoo/Utilities/methods.dart';
import 'package:oowoo/constants.dart';
import 'package:provider/provider.dart';

class Register2 extends StatefulWidget {
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  RegisterModel registerModel = RegisterModel();
  RegistrationService registerService = RegistrationService();
  UtilityService utilityService = UtilityService();
  final formKey = GlobalKey<FormState>();
  genderEnum genderSelected;
  final ImagePicker picker = ImagePicker();
  XFile selectedImage;
  Uint8List selectedImageAsBytes;
  bool isLoading = false;
  Jiffy jiffy = Jiffy();
  String dobAsString;
  final storage = FlutterSecureStorage();
  Map<String, dynamic> credentialMap = {};
  Map profileMap1 = {};
  Future getBasicCredentials() async {
    credentialMap = await storage.readAll();
    setState(() {});
  }

  Future getProfileAsMap() async {
    if (credentialMap.isNotEmpty) {
      Map profilMap = await utilityService.getStudentProfile(credentialMap);
      Provider.of<StudentProvider>(context, listen: false)
          .getProfileMap(profilMap);
      Uint8List a = await getImage(profileMap1['photo']);
      profilMap['imageAsBytes'] = a;
      profilMap['ageAsString'] = (DateTime.now().year -
              int.parse(profilMap['dob'].toString().substring(0, 4)))
          .toString();
      profileMap1 = profilMap;
      Provider.of<StudentProvider>(context, listen: false)
          .getProfileMap(profilMap);
      setState(() {});
      return profilMap;
    } else
      return {};
  }

  @override
  void initState() {
    getBasicCredentials();
    super.initState();
  }

  // StudentProvider studentProvider = StudentProvider();
  Future getImage(String address) async {
    if (address != null && address != '') {
      File file = File(address);
      selectedImageAsBytes = await file.readAsBytes();
      setState(() {});
      return selectedImageAsBytes;
    }
  }

  void update(BuildContext context) {
    Provider.of<StudentProvider>(context, listen: false)
        .getProfileMap(profileMap1);
  }

  @override
  Widget build(BuildContext context) {
    Map profileMap = Provider.of<StudentProvider>(context).profileMap;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
              // Provider.of<StudentProvider>(context).
              profileMap.isEmpty ? 'Create Account' : 'Profile',
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
        ),
        body: LoadingOverlay(
          isLoading: isLoading,
          progressIndicator: AnimatingCircle(),
          opacity: .5,
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: 112,
                        width: 112,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Choose'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 142,
                                          width: 112,
                                          child: Card(
                                            color: Color(0XFF00AEEF),
                                            shadowColor: Color(0XFFabe1f5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            borderOnForeground: true,
                                            child: Center(
                                                child: loadImage(
                                                    selectedImage:
                                                        selectedImage,
                                                    selectedImageAsBytes: Provider
                                                            .of<StudentProvider>(
                                                                context)
                                                        .selectedImageAsBytesForAlertDialogue,
                                                    fromProfileMap: profileMap[
                                                        'imageAsBytes'])),
                                          ),
                                        ), //
                                        ListTile(
                                          leading:
                                              Icon(Icons.camera_alt_outlined),
                                          title: Text('Camera'),
                                          onTap: () async {
                                            selectedImage =
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                          },
                                          tileColor: Color(0XFFE5E5E5),
                                        ),
                                        SizedBox(height: 5),
                                        ListTile(
                                          leading: Icon(Icons.photo),
                                          title: Text('Gallery'),
                                          onTap: () async {
                                            selectedImage =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (selectedImage != null) {
                                              selectedImageAsBytes =
                                                  await selectedImage
                                                      .readAsBytes();

                                              setState(() {});
                                            }
                                            if (selectedImageAsBytes != null) {
                                              Provider.of<StudentProvider>(
                                                      context,
                                                      listen: false)
                                                  .getSelectedImageAsBytesForAlertDialogOnPressed(
                                                      selectedImageAsBytes);
                                              Provider.of<StudentProvider>(
                                                      context,
                                                      listen: false)
                                                  .getImageAsMapWhenSelected(
                                                      path: selectedImage.path,
                                                      imageAsBytes:
                                                          selectedImageAsBytes);
                                            }
                                          },
                                          tileColor: Color(0XFFE5E5E5),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      profileMap.isEmpty
                                          ? Provider.of<StudentProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedImageAsBytesForAlertDialogue !=
                                                  null
                                              ? TextButton(
                                                  onPressed: () {
                                                    if (selectedImageAsBytes !=
                                                        null) {
                                                      Provider.of<StudentProvider>(
                                                              context,
                                                              listen: false)
                                                          .imageMap
                                                          .remove(
                                                              'croppedImageAsBytes');
                                                      Navigator.popAndPushNamed(
                                                          context,
                                                          '/ResizeProfileImage');
                                                    }
                                                  },
                                                  child: Text('Resize',
                                                      style:
                                                          kTextButtonTextStyleForAlertDialog))
                                              : SizedBox()
                                          : TextButton(
                                              onPressed: () {
                                                if (profileMap.containsKey(
                                                    'imageAsBytes')) {
                                                  Provider.of<StudentProvider>(
                                                          context,
                                                          listen: false)
                                                      .getImageAsMapWhenSelected(
                                                          path: profileMap[
                                                              'photo'],
                                                          imageAsBytes: profileMap[
                                                              'imageAsBytes']);
                                                  Provider.of<StudentProvider>(
                                                          context,
                                                          listen: false)
                                                      .getSelectedImageAsBytesForAlertDialogOnPressed(
                                                          profileMap[
                                                              'imageAsBytes']);
                                                  Provider.of<StudentProvider>(
                                                          context,
                                                          listen: false)
                                                      .imageMap
                                                      .remove(
                                                          'croppedImageAsBytes');

                                                  Navigator.popAndPushNamed(
                                                      context,
                                                      '/ResizeProfileImage');
                                                }
                                              },
                                              child: Text('Resize',
                                                  style:
                                                      kTextButtonTextStyleForAlertDialog)),
                                      TextButton(
                                          onPressed: () async {
                                            selectedImageAsBytes =
                                                await selectedImage
                                                    .readAsBytes();
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Text('Submit',
                                              style:
                                                  kTextButtonTextStyleForAlertDialog)),
                                      TextButton(
                                          onPressed: () {
                                            Provider.of<StudentProvider>(
                                                    context,
                                                    listen: false)
                                                .getSelectedImageAsBytesForAlertDialogOnPressed(
                                                    null);
                                            setState(() {
                                              selectedImage = null;
                                              selectedImageAsBytes = null;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel',
                                              style:
                                                  kTextButtonTextStyleForAlertDialog)),
                                    ],
                                  );
                                });
                          },
                          child: Card(
                            color: Colors.transparent,
                            shadowColor: Color(0XFFabe1f5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            borderOnForeground: true,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                    height: 140,
                                    width: 112,
                                    child: loadImage(
                                        selectedImage: selectedImage,
                                        fromProfileMap:
                                            profileMap['imageAsBytes'],
                                        selectedImageAsBytes: Provider.of<
                                                StudentProvider>(context)
                                            .selectedImageAsBytesForAlertDialogue)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Name', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Name',
                        initial:
                            getInitialText(proMap: profileMap, key: 'name')),
                    SizedBox(height: 15),
                    Text('Date of Birth', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Date of Birth',
                        initial: profileMap.isNotEmpty
                            ? profileMap['dob'] != null
                                ? getFormattedDate(profileMap['dob'],
                                    format: 'MMMM do yyyy')
                                : null
                            : null),
                    SizedBox(height: 15),
                    Text('Age', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Age',
                        initial: profileMap.isNotEmpty
                            ? profileMap['dob'] != null
                                ? (DateTime.now().year -
                                            int.parse(profileMap['dob']
                                                .toString()
                                                .substring(0, 4)))
                                        .toString() +
                                    ' Years'
                                : null
                            : null),
                    SizedBox(height: 15),
                    Text('Gender', style: kRegistrationHeadersTextStyle),
                    SizedBox(
                      child: Row(
                        children: [
                          Row(
                            children: <Widget>[
                              addRadioButton(0, 'Male'),
                              addRadioButton(1, 'Female'),
                              addRadioButton(2, 'Others'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('Email', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Email',
                        initial:
                            profileMap.isNotEmpty ? profileMap['email'] : null),
                    // SizedBox(height: 20),
                    SizedBox(height: 15),
                    Text('Phone Number', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Phone Number',
                        initial: profileMap.isNotEmpty
                            ? profileMap['phone_number']
                            : null),
                    // SizedBox(height: 20),
                    SizedBox(height: 15),
                    Text('WhatsApp Number',
                        style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'WhatsApp Number',
                        initial: profileMap.isNotEmpty
                            ? profileMap['whatsapp_number']
                            : null),
                    SizedBox(height: 15),
                    Text('Guardian Name', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Guardian Name',
                        initial: profileMap.isNotEmpty
                            ? profileMap['guardian_name']
                            : null),
                    SizedBox(height: 15),
                    Text('Father Name', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Father Name',
                        initial: profileMap.isNotEmpty
                            ? profileMap['father_name']
                            : null),
                    SizedBox(height: 15),
                    Text('Mother Name', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Mother Name',
                        initial: profileMap.isNotEmpty
                            ? profileMap['mother_name']
                            : null),
                    SizedBox(height: 15),
                    Text('Address', style: kRegistrationHeadersTextStyle),
                    SizedBox(height: 10),
                    kTextFormField(
                        hint: 'Address',
                        initial: profileMap.isNotEmpty
                            ? profileMap['address']
                            : null),

                    SizedBox(height: 30),
                    Builder(
                      builder: (innerContext) {
                        return ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                RegistrationProvider regProvider =
                                    Provider.of<RegistrationProvider>(context,
                                        listen: false);
                                formKey.currentState.save();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  isLoading = true;
                                });
                                registerModel.name = regProvider.name;
                                registerModel.email = regProvider.email;
                                registerModel.phoneNum = regProvider.phoneNum;
                                registerModel.whatsAppNum =
                                    regProvider.whatsAppNum;
                                registerModel.guardianName =
                                    regProvider.guardianName;
                                registerModel.fatherName =
                                    regProvider.fatherName;
                                registerModel.motherName =
                                    regProvider.motherName;
                                registerModel.address = regProvider.address;
                                registerModel.age =
                                    regProvider.ageAndDobMap['age'];
                                registerModel.dob =
                                    regProvider.ageAndDobMap['dobToDataBase'];

                                if (credentialMap.isNotEmpty) {
                                  registerModel.gender = profileMap['gender'];
                                  if ((selectedImage == null &&
                                          Provider.of<StudentProvider>(context,
                                                  listen: false)
                                              .imageMap
                                              .isEmpty) ||
                                      Provider.of<StudentProvider>(context,
                                                  listen: false)
                                              .imageMap['croppedImagePath'] ==
                                          null) {
                                    registerModel.photo = profileMap['photo'];
                                  } else {
                                    if (Provider.of<StudentProvider>(context,
                                                listen: false)
                                            .imageMap
                                            .containsKey('croppedImagePath') &&
                                        Provider.of<StudentProvider>(context,
                                                    listen: false)
                                                .imageMap['croppedImagePath'] !=
                                            null) {
                                      registerModel.photo =
                                          Provider.of<StudentProvider>(context,
                                                  listen: false)
                                              .imageMap['croppedImagePath'];
                                    } else {
                                      registerModel.photo = selectedImage.path;
                                    }
                                  }
                                } else {
                                  if (selectedImage == null) {
                                    registerModel.photo = '';
                                  } else {
                                    if (Provider.of<StudentProvider>(context,
                                                listen: false)
                                            .imageMap
                                            .containsKey('croppedImagePath') &&
                                        Provider.of<StudentProvider>(context,
                                                    listen: false)
                                                .imageMap['croppedImagePath'] !=
                                            null) {
                                      registerModel.photo =
                                          Provider.of<StudentProvider>(context,
                                                  listen: false)
                                              .imageMap['croppedImagePath'];
                                    } else {
                                      registerModel.photo = selectedImage.path;
                                    }
                                  }

                                  registerModel.gender = selectedGender;
                                }
                                if (credentialMap.isEmpty) {
                                  await registerService
                                      .register(registerModel)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (value == null ||
                                        value[0]['id'] == '0') {
                                      ScaffoldMessenger.of(innerContext)
                                          .showSnackBar(commonSnackBar(
                                              innerContext,
                                              false,
                                              value[0]['msg']));
                                    } else {
                                      showCupertinoDialog(
                                        barrierDismissible: false,
                                        context: innerContext,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(
                                                'Registered Successfully',
                                                style:
                                                    kRegisterSuccessHeadingStyle),
                                            content: Text(
                                                'Check your email for credentials',
                                                style:
                                                    kRegisterSuccessContentStyle),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            '/CommonLogIn');
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          );
                                        },
                                      );

                                      // ScaffoldMessenger.of(innerContext)
                                      //     .showSnackBar(commonSnackBar(
                                      //         innerContext,
                                      //         true,
                                      //         'You have registered successfully'));
                                      // //'You have registered successfully'
                                      // print('registration success');
                                      // Duration fiveSeconds =
                                      //     Duration(seconds: 5);
                                      // Future.delayed(fiveSeconds, () {
                                      //   Navigator.pushReplacementNamed(
                                      //       context, '/CommonLogIn');
                                      // });
                                    }
                                  });
                                } else {
                                  if (registerModel.dob == null) {
                                    registerModel.dob = profileMap['dob'];

                                    registerModel.age = profileMap['age'];
                                  }
                                  await registerService
                                      .updateProfile(
                                          registerModel, credentialMap)
                                      .then((value) async {
                                    if (value == null ||
                                        value[0]['id'] == '0') {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(innerContext)
                                          .showSnackBar(commonSnackBar(
                                              innerContext,
                                              false,
                                              value[0]['msg'],
                                              height: 150));
                                    } else {
                                      await registerService
                                          .getStudentProfile(credentialMap)
                                          .then((value) async {
                                        await getImage(value['photo'])
                                            .then((val) {
                                          value['imageAsBytes'] = val;
                                          Provider.of<StudentProvider>(context,
                                                  listen: false)
                                              .getProfileMap(value);
                                        });
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }).whenComplete(() {
                                        ScaffoldMessenger.of(innerContext)
                                            .showSnackBar(commonSnackBar(
                                                innerContext,
                                                true,
                                                'Updated successfully',
                                                height: 150));
                                        Duration fiveSeconds =
                                            Duration(seconds: 5);
                                        Future.delayed(fiveSeconds, () {
                                          Navigator.popAndPushNamed(
                                              context, '/Register2');
                                        });
                                      });
                                      // ScaffoldMessenger.of(innerContext)
                                      //     .showSnackBar(commonSnackBar(
                                      //         innerContext,
                                      //         true,
                                      //         'Updated successfully'));
                                      // //'You have registered successfully'
                                      // print('Updated success');
                                      // Duration fiveSeconds =
                                      //     Duration(seconds: 5);
                                      // Future.delayed(fiveSeconds, () {
                                      //   Navigator.popAndPushNamed(
                                      //       context, '/Register');
                                      // });
                                    }
                                  });
                                }
                                // } else {
                                //   setState(() {
                                //     isLoading = false;
                                //   });
                                //   ScaffoldMessenger.of(innerContext)
                                //       .showSnackBar(commonSnackBar(innerContext,
                                //           false, 'Please Choose Profile Image',
                                //           height: 150));
                                //   //'You have registered successfully'
                                //   // print('registration success');
                                //   // Duration fiveSeconds = Duration(seconds: 5);
                                //   // Future.delayed(fiveSeconds, () {
                                //   //   Navigator.pushReplacementNamed(
                                //   //       context, '/CommonLogIn');
                                //   // });
                                // }
                              } else {
                                ScaffoldMessenger.of(innerContext).showSnackBar(
                                    commonSnackBar(innerContext, false,
                                        'Please Fill red Marked Fields'));
                                //'You have registered successfully'
                                // print('registration success');
                                // Duration fiveSeconds = Duration(seconds: 5);
                                // Future.delayed(fiveSeconds, () {
                                //   Navigator.pushReplacementNamed(
                                //       context, '/CommonLogIn');
                                // });
                              }
                            },
                            child: Text(
                                credentialMap.isEmpty ? 'Register' : 'Update',
                                style: kRegisterButtonTextStyle),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    (Size(double.infinity, 63))),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ))));
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              // }),
            ),
          ),
        ),
        //Profile
        // bottomNavigationBar: credentialMap.isNotEmpty
        //     ? CommonBottomNavigationBar(
        //         height: height,
        //         width: width,
        //         pageName: 'Profile',
        //         // profileMap: profileMap,
        //       )
        //     : SizedBox(),
      ),
    );
  }

  TextFormField kTextFormField({String hint, String initial}) {
    bool getReadOnly() {
      bool readOnlyResult = false;
      if (hint == 'Age' || hint == 'Date of Birth')
        readOnlyResult = true;
      else if (initial != null && hint == 'Email')
        readOnlyResult = true;
      else
        readOnlyResult = false;
      return readOnlyResult;
    }

    TextInputType getKeyBoardType() {
      TextInputType textInputType;
      switch (hint) {
        case 'Name':
          textInputType = TextInputType.name;
          break;
        case 'Email':
          textInputType = TextInputType.emailAddress;
          break;
        case 'Guardian Name':
          textInputType = TextInputType.name;
          break;
        case 'Father Name':
          textInputType = TextInputType.name;
          break;
        case 'Mother Name':
          textInputType = TextInputType.name;
          break;
        case 'Phone Number':
          textInputType = TextInputType.phone;
          break;
        case 'WhatsApp Number':
          textInputType = TextInputType.phone;
          break;
        case 'Address':
          textInputType = TextInputType.streetAddress;
          break;
      }
      return textInputType;
    }

    return TextFormField(
      style: kTextFormFieldTextStyle,
      validator: (val) {
        String error;
        if (val.isEmpty || val.trim() == null || val.trim().isEmpty) {
          switch (hint) {
            case 'Company Website':
              error = null;
              break;
            case 'Mail ID':
              error = null;
              break;
            case 'Official mail':
              // if (editingTextOnProfileViewing != null) error = null;
              break;
            case 'Order Amount':
              error = null;
              break;
            case 'Description':
              error = null;
              break;
            case 'Date of Birth':
              Provider.of<RegistrationProvider>(context, listen: false)
                          .ageAndDobMap ==
                      null
                  ? error = error = hint + ' Cannot Be empty'
                  : error = null;
              break;
            case 'Age':
              Provider.of<RegistrationProvider>(context, listen: false)
                          .ageAndDobMap ==
                      null
                  ? error = error = hint + ' Cannot Be empty'
                  : error = null;
              break;
            default:
              error = hint + ' Cannot Be empty';
              break;
          }
        } else {
          error = null;
        }
        return error;
      },
      onSaved: (value) {
        switch (hint) {
          case 'Name':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getName(value);
            break;
          case 'Email':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getEmail(value);
            break;
          case 'Guardian Name':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getGuard(value);
            break;
          case 'Father Name':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getFatherName(value);
            break;
          case 'Mother Name':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getMotherName(value);
            break;
          case 'Phone Number':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getPhone(value);
            break;
          case 'WhatsApp Number':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getWatsAppNum(value);
            break;
          case 'Address':
            Provider.of<RegistrationProvider>(context, listen: false)
                .getAddress(value);
            break;
        }
      },
      readOnly: getReadOnly(),
      keyboardType: getKeyBoardType(),
      onTap: () async {
        Map<String, dynamic> ageAnddobAsMap = {};
        if (hint == 'Date of Birth') {
          DateTime firstDate = DateTime(DateTime.now().year - 1990);
          var a = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate,
              lastDate: DateTime.now());
          if (a != null) {
            var age = DateTime.now().year - a.year;
            dobAsString =
                getFormattedDate(a.toString(), format: 'MMMM do yyyy');
            String dobIntoDb =
                getFormattedDate(a.toString(), format: 'yyyy/MM/dd');
            ageAnddobAsMap['dobToView'] = dobAsString;
            ageAnddobAsMap['dobToDataBase'] = dobIntoDb;
            ageAnddobAsMap['age'] = age.toString();
            Provider.of<RegistrationProvider>(context, listen: false)
                .getDob(ageAnddobAsMap);
          }
        }
      },
      initialValue: hint == 'Date of Birth'
          ? null
          : hint == 'Age'
              ? null
              : initial,
      maxLines: hint == 'Address' ? null : 1,
      minLines: hint == 'Address' ? 2 : 1,
      cursorHeight: 30,
      decoration: InputDecoration(
        hintText: hint == 'Date of Birth'
            ? Provider.of<RegistrationProvider>(context).ageAndDobMap.isEmpty
                ? initial == null
                    ? hint
                    : initial
                : Provider.of<RegistrationProvider>(context)
                    .ageAndDobMap['dobToView']
            : hint == 'Age'
                ? Provider.of<RegistrationProvider>(context)
                        .ageAndDobMap
                        .isEmpty
                    ? initial == null
                        ? hint
                        : initial
                    : Provider.of<RegistrationProvider>(context)
                            .ageAndDobMap['age'] +
                        ' years'
                : hint,
        hintStyle: kTextFormFieldTextStyle,
        errorStyle: kTextFormFieldErrorTextStyle,
        isDense: true,
        fillColor: Color(0XFFE5E5E5),
        filled: true,
        border: kCommonBorderForTextFields,
        enabledBorder: kCommonEnabledBorderForTextFields,
        focusedErrorBorder: kCommonFocusedBorderForTextFields,
        errorBorder: kCommonErrorBorderForTextFields,
      ),
    );
  }

  List gender = ["Male", "Female", "Other"];

  String selectedGender = 'Male';

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.black,
          value: gender[btnValue],
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
        Text(title, style: kGenderTextStyle)
      ],
    );
  }

  Image loadImage(
      {XFile selectedImage,
      Uint8List selectedImageAsBytes,
      Uint8List fromProfileMap}) {
    Image image;
    if (selectedImage == null) {
      if (selectedImageAsBytes == null && fromProfileMap == null) {
        image =
            Image.asset('assets/images/ProfileAvatar.png', fit: BoxFit.fill);
      } else if (fromProfileMap != null && selectedImageAsBytes == null) {
        image = Image.memory(fromProfileMap, fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/ProfileAvatar.png',
              fit: BoxFit.fill);
        });
      } else if (selectedImageAsBytes != null) {
        image = Image.memory(selectedImageAsBytes, fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/ProfileAvatar.png',
              fit: BoxFit.fill);
        });
      }
    } else {
      if (selectedImageAsBytes == null) {
        image =
            Image.asset('assets/images/ProfileAvatar.png', fit: BoxFit.fill);
      } else {
        image = Image.memory(
          selectedImageAsBytes,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/images/ProfileAvatar.png',
                fit: BoxFit.fill);
          },
        );
      }
    }
    return image;
  }

  String getInitialText({Map proMap, String key}) {
    String txt;
    if (proMap.isNotEmpty) {
      setState(() {});
      txt = proMap[key];
    }
    return txt;
  }
}
