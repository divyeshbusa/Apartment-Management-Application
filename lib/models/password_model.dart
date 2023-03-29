class PasswordModel {
  int? PassworID1;
  late int UserID1;
  late String Password1;

  PasswordModel({
    required this.Password1,
    required this.UserID1,
  });

  int get UserID => UserID1;

  set UserID(int value) {
    UserID1 = value;
  }



  int? get PassworID => PassworID1;

  set PassworID(int? value) {
    PassworID1 = value;
  }

  String get Password => Password1;

  set Password(String value) {
    Password1 = value;
  }
}
