class LocationModel {
  late int CityID1;
  late String CityName1;
  late int StateID1;
  late String StateName1;
  late int CountryID1;
  late String CountryName1;

  int get CityID => CityID1;

  set CityID(int CityID) {
    CityID1 = CityID;
  }


  String get CityName => CityName1;

  set CityName(String CityName) {
    CityName1 = CityName;
  }


  int get StateID => StateID1;

  set StateID(int StateID) {
    StateID1 = StateID;
  }


  String get StateName => StateName1;

  set StateName(String StateName) {
    StateName1 = StateName;
  }


  int get CountryID => CountryID1;

  set CountryID(int CountryID) {
    CountryID1 = CountryID;
  }


  String get CountryName => CountryName1;

  set CountryName(String CountryName) {
    CountryName1 = CountryName;
  }

  LocationModel(
      {
        required this.CityID1,
      required this.CityName1,
      required this.StateID1,
      required this.StateName1,
      required this.CountryID1,
      required this.CountryName1});
}
