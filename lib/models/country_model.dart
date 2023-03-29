class CountryModel {
  late int CountryID1;
  late String CountryName1;

  int get CountryID => CountryID1;

  set CountryID(int CountryID) {
    CountryID1 = CountryID;
  }


  String get CountryName => CountryName1;

  set CountryName(String CountryName) {
    CountryName1 = CountryName;
  }

  CountryModel({
    required this.CountryID1,
    required this.CountryName1,
  });
}
