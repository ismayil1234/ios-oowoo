class RegisterModel {
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

  RegisterModel(
      {this.name,
      this.dob,
      this.age,
      this.gender,
      this.guardianName,
      this.fatherName,
      this.motherName,
      this.phoneNum,
      this.whatsAppNum,
      this.email,
      this.address,
      this.photo});

  Map<String, dynamic> toMap(RegisterModel regModel) {
    return {
      'name': regModel.name,
      'dob': regModel.dob,
      'age': regModel.age,
      'gender': regModel.gender,
      'g_name': regModel.guardianName,
      'f_name': regModel.fatherName,
      'm_name': regModel.motherName,
      'p_number': regModel.phoneNum,
      'w_number': regModel.whatsAppNum,
      'email': regModel.email,
      'address': regModel.address,
      'photo': regModel.photo
    };
  }
}
