class apartmentModel {
  int? ApartmentID1;
  late String ApartmentName1;
  late int ApartmentCode1;
  late int wings1;

  apartmentModel({

    required this.ApartmentName1,
    required this.ApartmentCode1,
    required this.wings1,
  });

  int? get ApartmentID => ApartmentID1;

  set ApartmentID(int? ApartmentID) {
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
