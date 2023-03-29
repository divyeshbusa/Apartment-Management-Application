import 'dart:ffi';
import 'dart:io';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/city_model.dart';
import 'package:apartment_management/models/country_model.dart';
import 'package:apartment_management/models/location_model.dart';
import 'package:apartment_management/models/password_model.dart';
import 'package:apartment_management/models/state_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/models/verify_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'Apartment_Management.db');
    return await openDatabase(
      databasePath,
      version: 2,
    );
  }

  Future<void> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Apartment_Management.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle
          .load(join('assets/database', 'Apartment_Management.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);
    }
  }

  Future<List<LocationModel>> getLocationListFromTbl() async {
    List<LocationModel> locationList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select C.CityID,C.CityName,S.StateID,S.StateName,N.CountryID,N.CountryName from MST_city C inner join MST_State S ON C.StateID == S.StateID inner join MST_Country N ON N.CountryID == S.CountryID');
    LocationModel model = LocationModel(
        CityID1: -1,
        CityName1: 'Select City',
        StateID1: -1,
        StateName1: 'Select State',
        CountryID1: -1,
        CountryName1: 'Select Country');

    locationList.add(model);
    for (int i = 0; i < data.length; i++) {
      model = LocationModel(
        CityID1: data[i]['CityID'] as int,
        CityName1: data[i]['CityName'].toString(),
        StateID1: data[i]['StateID'] as int,
        StateName1: data[i]['StateName'].toString(),
        CountryID1: data[i]['CountryID'] as int,
        CountryName1: data[i]['CountryName'].toString(),
      );

      locationList.add(model);
    }
    // print("USER LIST ::: ${locationList.length}");
    return locationList;
  }

  Future<List<CountryModel>> getCountryListFromTbl() async {
    List<CountryModel> countryList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery('select * from MST_Country');
    CountryModel model = CountryModel(
      CountryID1: -1,
      CountryName1: 'Select Country',
    );

    countryList.add(model);
    for (int i = 0; i < data.length; i++) {
      // print("COUNTY ID ::: ${model.CountryID}");
      model = CountryModel(
        CountryID1: data[i]['CountryID'] as int,
        CountryName1: data[i]['CountryName'].toString(),
      );

      countryList.add(model);
    }
    // print("COUNTRY LIST ::: ${countryList.length}");
    return countryList;
  }

  Future<List<StateModel>> getStateListFromTbl(int countryID) async {
    List<StateModel> stateList = [];
    Database db = await initDatabase();
    if (countryID == -1) {
      List<Map<String, Object?>> data =
          await db.rawQuery('select * from MST_State');
      StateModel model = StateModel(
        StateID1: -1,
        StateName1: 'Select State',
      );

      stateList.add(model);
      for (int i = 0; i < data.length; i++) {
        // print("StateID ::: ${model.StateID}");
        model = StateModel(
          StateID1: data[i]['StateID'] as int,
          StateName1: data[i]['StateName'].toString(),
        );

        stateList.add(model);
      }
    } else {
      List<Map<String, Object?>> data = await db
          .rawQuery('select * from MST_State where CountryID == $countryID');
      StateModel model = StateModel(
        StateID1: -1,
        StateName1: 'Select State',
      );

      stateList.add(model);
      for (int i = 0; i < data.length; i++) {
        // print("StateID ::: ${model.StateID}");
        model = StateModel(
          StateID1: data[i]['StateID'] as int,
          StateName1: data[i]['StateName'].toString(),
        );

        stateList.add(model);
      }
    }

    // print("STATE LIST ::: ${stateList.length}");
    return stateList;
  }

  Future<List<CityModel>> getCityListFromTbl(int stateID) async {
    List<CityModel> cityList = [];
    Database db = await initDatabase();
    if (stateID == -1) {
      List<Map<String, Object?>> data =
          await db.rawQuery('select * from MST_City');
      CityModel model = CityModel(
        CityID1: -1,
        CityName1: 'Select City',
      );

      cityList.add(model);
      for (int i = 0; i < data.length; i++) {
        // print("cityid ::: ${model.CityID}");
        model = CityModel(
          CityID1: data[i]['CityID'] as int,
          CityName1: data[i]['CityName'].toString(),
        );

        cityList.add(model);
      }
    } else {
      List<Map<String, Object?>> data =
          await db.rawQuery('select * from MST_City where StateID == $stateID');
      CityModel model = CityModel(
        CityID1: -1,
        CityName1: 'Select City',
      );

      cityList.add(model);
      for (int i = 0; i < data.length; i++) {
        // print("cityid ::: ${model.CityID}");
        model = CityModel(
          CityID1: data[i]['CityID'] as int,
          CityName1: data[i]['CityName'].toString(),
        );

        cityList.add(model);
      }
    }

    // print("CITY LIST ::: ${cityList.length}");
    return cityList;
  }

  Future<List<apartmentModel>> getApartmentListFromTbl(int cityID) async {
    List<apartmentModel> apartmentList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db
        .rawQuery('select * from MST_Apartment where CityID == $cityID');

    for (int i = 0; i < data.length; i++) {
      apartmentModel model = apartmentModel(
          ApartmentName1: data[i]['ApartmentName'].toString(),
          ApartmentCode1: data[i]['ApartmentCode'] as int,
          wings1: data[i]['Wings'] as int);
      model.ApartmentID = data[i]['ApartmentID'] as int;

      apartmentList.add(model);
    }

    print("APARTMENT LIST ::: ${apartmentList.length}");
    return apartmentList;
  }

  Future<List<UserModel>> getDataFromUserTable(int ApartmentID) async {
    List<UserModel> userList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select U.*,AU.ApartmentID from Lst_Userlist U inner join Tbl_ApartmentWiseUser AU Where AU.UserID == U.UserID and ApartmentId = $ApartmentID');
    for (int i = 0; i < data.length; i++) {
      UserModel model = UserModel(
        UserName1: data[i]['UserName'].toString(),
        Phone1: data[i]['Phone'],
        UserImage1: data[i]['UserImage'].toString(),
        Email1: data[i]['Email'].toString(),
        UserType1: data[i]['UserType'].toString(),
      );

      model.UserID = data[i]['UserID'] as int;

      userList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return userList;
  }

  Future<List<VerifyModel>> getNotVerifirdUsrListFromTbl() async {
    List<VerifyModel> verifyList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser AU inner join LST_Userlist U on AU.UserID = U.UserID inner join MST_Apartment A on AU.ApartmentID = A.ApartmentID where isVerified == 0');
    for (int i = 0; i < data.length; i++) {
      VerifyModel model = VerifyModel(
        ApartmentID1: data[i]['ApartmentID'] as int,
        ApartmentName1: data[i]['ApartmentName'].toString(),
        ApartmentCode1: data[i]['ApartmentCode'] as int,
        wings1: data[i]['Wings'] as int,
        UserID1: data[i]['UserID'] as int,
        UserName1: data[i]['UserName'].toString(),
        Phone1: data[i]['Phone'],
        UserImage1: data[i]['UserImage'].toString(),
        Email1: data[i]['Email'].toString(),
        UserType1: data[i]['UserType'].toString(),
        isAdmin1: data[i]['isAdmin'] as int,
      );

      model.ApartmentWiseUserID = data[i]['ApartmentWiseUserID'] as int;

      verifyList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return verifyList;
  }

  Future<int> getAdminOrNotFromTbl(int userid) async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser where UserID = "$userid"');

    if (data.isNotEmpty) {
      print("isVerified::::${data[0]['isVerified']}");
      if (data[0]['isAdmin'] == 1) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return -1;
    }

  }

  Future<UserModel?> getLoginDetail(String email, String password) async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from LST_Password P inner join LST_Userlist U on P.UserID = U.UserID where U.Email = "$email" and P.Password = "$password"');

    if (data.isNotEmpty) {
      print("Username::::${data[0]['Email']}");

      UserModel modelU = UserModel(
        UserName1: data[0]['UserName'].toString(),
        Phone1: data[0]['Phone'],
        UserImage1: data[0]['UserImage'].toString(),
        Email1: data[0]['Email'].toString(),
        UserType1: data[0]['UserType'].toString(),
      );
      modelU.UserID = data[0]['UserID'] as int;

      return modelU;
    } else {
      return null;
    }
  }

  Future<void> upsertIntoApartmentTable(
      {ApartmentID, ApartmentName, Code, Wings, City}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['ApartmentID'] = ApartmentID;
    map['ApartmentName'] = ApartmentName;
    map['ApartmentCode'] = Code;
    map['Wings'] = Wings;
    map['CityID'] = City;

    if (ApartmentID != -1) {
      print('CALLING:::::UPDATE::::::');
      await db.update('MST_Apartment', map,
          where: 'ApartmentID = ?', whereArgs: [ApartmentID]);
    } else {
      print('CALLING:::::INSERT::::::');
      await db.insert('MST_Apartment', map);
    }
  }

  Future<void> upsertIntoPasswordTable(
      {PasswordID, UserID, Password}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['UserID'] = UserID;
    map['Password'] = Password;


    if (PasswordID != null) {
      print('CALLING:::::UPDATE::::::');
      await db.update('LST_Password', map,
          where: 'PasswordID = ?', whereArgs: [PasswordID]);
      print(':::::::PASSWORD UPDATE SUCCESSFULLY:::::::');
    } else {
      print('CALLING:::::INSERT::::::');
      await db.insert('LST_Password', map);
      print(':::::::PASSWORD INSERT SUCCESSFULLY:::::::');
    }
  }

  Future<int> upsertIntoUserTable(
      {UserID, UserName, Phone, Email, UserType, UserImage}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['UserID'] = UserID;
    map['UserName'] = UserName;
    map['Phone'] = Phone;
    map['Email'] = Email;
    map['UserType'] = UserType;
    map['UserImage'] = UserImage;

    if (UserID != null) {
      print('CALLING:::::UPDATE::::::');
      return await db.update('LST_Userlist', map,
          where: 'UserID = ?', whereArgs: [UserID]);
    } else {
      print('CALLING:::::INSERT::::::');
      return await db.insert('LST_Userlist', map);
    }
  }

  Future<void> upsertIntoApartmentWiseUser(
      {ApartmentWiseUserID, ApartmentID, UserID, isVerified, isAdmin}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();
    print("isVerified:::::${isVerified}");

    map['ApartmentWiseUserID'] = ApartmentWiseUserID;
    map['UserID'] = UserID;
    map['ApartmentID'] = ApartmentID;
    map['isVerified'] = isVerified;
    map['isAdmin'] = isAdmin;

    if (ApartmentWiseUserID != null) {
      print('CALLING:::::UPDATE::::::');
      await db.update('Tbl_ApartmentWiseUser', map,
          where: 'ApartmentWiseUserID = ?', whereArgs: [ApartmentWiseUserID]);
    } else {
      print('CALLING:::::INSERT::::::');
      await db.insert('Tbl_ApartmentWiseUser', map);
    }
  }

  Future<int> VerifiedOrNot({required int UserID, required String code}) async {
    print('CODE::::::::${code}');
    int isMatch = -1;
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select A.ApartmentCode,AU.isVerified from Tbl_ApartmentWiseUser AU Inner Join MST_Apartment A on AU.ApartmentID == A.ApartmentID Inner Join LST_Userlist U on AU.UserID == U.UserID where U.UserID = $UserID');
    print('DATA::::::::${data}');
    print('DATA LENGTH::::::::${data.length}');

    for (int i = 0; i < data.length; i++) {

      if(code == data[i]['ApartmentCode'].toString()){
        print("COMPARISION::::${code == data[i]['ApartmentCode'].toString()}");
        print("isVerified::::${data[i]['isVerified']}");
        isMatch = data[i]['isVerified'] as int;
      }
    }


    if (data.isNotEmpty) {
      print("isMatch::::${isMatch}");
      if (isMatch == 1) {
        return 1;
      } else if(isMatch == 0){
        return 2;
      }
      else {
        return 0;
      }
    }
    else {
      return 0;
    }
  }

  Future<void> updateToVerify({UserID}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['isVerified'] = 1;

    print('CALLING:::::UPDATE::::::');
    await db.update('Tbl_ApartmentWiseUser', map,
        where: 'UserID = ?', whereArgs: [UserID]);
  }
}
