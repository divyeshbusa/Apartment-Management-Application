class UserModel{
  int? UserID1;
  late String UserName1;
  late dynamic Phone1;
  late String Email1;
  late String UserType1;
  late String UserImage1;





  UserModel({
    required this.UserID1,
    required this.UserName1,
    required this.Phone1,
    required this.Email1,
    required this.UserType1,
    required this.UserImage1,

  });

  int? get UserID => UserID1;

  set UserID(int? UserID) {
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


}