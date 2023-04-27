class CollectionModel {
  late int CollectionID1;
  late int CollectionTypeID1;
  late String CollectionType1;
  late int ApartmentID1;
  late int UserID1;
  late String UserName1;
  late String Date1;
  late int Amount1;

  CollectionModel({
    required this.CollectionID1,
    required this.CollectionTypeID1,
    required this.CollectionType1,
    required this.ApartmentID1,
    required this.UserID1,
    required this.UserName1,
    required this.Date1,
    required this.Amount1,
  });

  int get CollectionID => CollectionID1;

  set CollectionID(int value) {
    CollectionID1 = value;
  }


  int get Amount => Amount1;

  set Amount(int value) {
    Amount1 = value;
  }



  int get CollectionTypeID => CollectionTypeID1;

  set CollectionTypeID(int value) {
    CollectionTypeID1 = value;
  }

  String get CollectionType => CollectionType1;

  set CollectionType(String value) {
    CollectionType1 = value;
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
