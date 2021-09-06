import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  String name;
  String dob;
  String age;
  String gender;
  String guardianName;
  String fatherName;
  String motherName;
  String phoneNum;
  String whatsAppNum;
  String email;
  String address;
  String photo;
  Map<String, dynamic> ageAndDobMap = {};
  void getName(String nam) {
    name = nam;
  }

  void getDob(Map<String, dynamic> doBMap) {
    //String doBToDataBase,String dobToView,
    ageAndDobMap = doBMap;
    // dobMap['dobToView']=dobToView;
    // dobMap['dobToDataBase']=doBToDataBase;
    // dob = doB;
    notifyListeners();
  }

  void getAge(String agE) {
    age = agE;
  }

  void getGender(String gendr) {
    gender = gendr;
  }

  void getGuard(String guard) {
    guardianName = guard;
  }

  void getFatherName(String fatherNam) {
    fatherName = fatherNam;
  }

  void getMotherName(String mom) {
    motherName = mom;
  }

  void getPhone(String phone) {
    phoneNum = phone;
  }

  void getWatsAppNum(String whatsApNo) {
    whatsAppNum = whatsApNo;
  }

  void getEmail(String mail) {
    email = mail;
  }

  void getAddress(String addres) {
    address = addres;
  }

  void getPhoto(String phot) {
    photo = phot;
  }
}
