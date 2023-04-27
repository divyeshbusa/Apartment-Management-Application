class TransactionModel {
  int? TransactionID1;
  late int TansactionType1;
  late int ApartmentID1;
  late int UserID1;
  late String UserName1;
  late String Date1;
  late String Remark1;

  TransactionModel({
    required this.TansactionType1,
    required this.ApartmentID1,
    required this.UserID1,
    required this.UserName1,
    required this.Date1,
    required this.Amount1,
    required this.Remark1,
  });

  int? get TransactionID => TransactionID1;

  set TransactionID(int? value) {
    TransactionID1 = value;
  }


  int get TansactionType => TansactionType1;

  set TansactionType(int value) {
    TansactionType1 = value;
  }


  String get Remark => Remark1;

  set Remark(String value) {
    Remark1 = value;
  }
  late int Amount1;

  int get Amount => Amount1;

  set Amount(int value) {
    Amount1 = value;
  }


  int get ApartmentID => ApartmentID1;

  set ApartmentID(int value) {
    ApartmentID1 = value;
  }

  int get UserID => UserID1;

  set UserID(int value) {
    UserID1 = value;
  }

  String get UserName => UserName1;

  set UserName(String value) {
    UserName1 = value;
  }

  String get Date => Date1;

  set Date(String value) {
    Date1 = value;
  }


}
