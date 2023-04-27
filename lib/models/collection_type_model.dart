class CollectionTypeModel{
  late int CollectionTypeID1;
  late String CollectionType1;

  int get CollectionTypeID => CollectionTypeID1;

  set CollectionTypeID(int value) {
    CollectionTypeID1 = value;
  }


  String get CollectionType => CollectionType1;

  set CollectionType(String value) {
    CollectionType1 = value;
  }

  CollectionTypeModel({required this.CollectionTypeID1 , required this.CollectionType1});


}