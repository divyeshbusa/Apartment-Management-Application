class VerifyModel{
  int? ApartmentWiseUserID1;
  late int UserID1;
  late String UserName1;
  late dynamic Phone1;
  late String Email1;
  late String UserType1;
  late String UserImage1;
  late int ApartmentID1;
  late String ApartmentName1;
  late int ApartmentCode1;
  late int wings1;
  late int isAdmin1;

  int get isAdmin => isAdmin1;

  set isAdmin(int isAdmin) {
    isAdmin1 = isAdmin;
  }





  VerifyModel({
    required this.UserID1,
    required this.UserName1,
    required this.Phone1,
    required this.Email1,
    required this.UserType1,
    required this.UserImage1,
    required this.ApartmentID1,
    required this.ApartmentName1,
    required this.ApartmentCode1,
    required this.wings1,
    required this.isAdmin1,
  });


  int? get ApartmentWiseUserID => ApartmentWiseUserID1;

  set ApartmentWiseUserID(int? ApartmentWiseUserID) {
    ApartmentWiseUserID1 = ApartmentWiseUserID;
  }

  int get UserID => UserID1;

  set UserID(int UserID) {
    UserID1 = UserID;
  }


  String get UserName => UserName1;

  set UserName(String UserName) {
    UserName1 = UserName;
  }


  dynamic get Phone => Phone1;

  set Phone(dynamic Phone) {
    Phone1 = Phone;
  }


  String get Email => Email1;

  set Email(String Email) {
    Email1 = Email;
  }


  String get UserType => UserType1;

  set UserType(String UserType) {
    UserType1 = UserType;
  }


  String get UserImage => UserImage1;

  set UserImage(String UserImage) {
    UserImage1 = UserImage;
  }


  int get ApartmentID => ApartmentID1;

  set ApartmentID(int ApartmentID) {
    ApartmentID1 = ApartmentID;
  }


  String get ApartmentName => ApartmentName1;

  set ApartmentName(String ApartmentName) {
    ApartmentName1 = ApartmentName;
  }


  int get ApartmentCode => ApartmentCode1;

  set ApartmentCode(int ApartmentCode) {
    ApartmentCode1 = ApartmentCode;
  }


  int get wings => wings1;

  set wings(int wings) {
    wings1 = wings;
  }
}