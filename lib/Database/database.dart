import 'dart:io';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/city_model.dart';
import 'package:apartment_management/models/collection_model.dart';
import 'package:apartment_management/models/collection_type_model.dart';
import 'package:apartment_management/models/country_model.dart';
import 'package:apartment_management/models/state_model.dart';
import 'package:apartment_management/models/transaction_model.dart';
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

  Future<List<apartmentModel>> getApartmentListUserWise(int userid) async {
    print(":::::::::::::USERID:::$userid::::::::");
    List<apartmentModel> apartmentList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser AU inner join MST_Apartment A Where A.ApartmentID == AU.ApartmentID and AU.UserID == $userid and AU.isVerified == 1');
    print(":::::::::::::DATA:::$data::::::::");
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
    UserModel model = UserModel(
        UserID1: -1,
        UserName1: 'Select User',
        Phone1: 'Enter Number',
        Email1: 'Enter mail',
        UserType1: "Enter Type ",
        UserImage1: 'Enter image');
    userList.add(model);
    for (int i = 0; i < data.length; i++) {
      model = UserModel(
        UserID1: data[i]['UserID'] as int,
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

  Future<List<MemberModel>> getNotVerifirdUsrListFromTbl(
      int apartmentid) async {
    List<MemberModel> verifyList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser AU inner join LST_Userlist U on AU.UserID = U.UserID inner join MST_Apartment A on AU.ApartmentID = A.ApartmentID where isVerified == 0 and AU.ApartmentID == $apartmentid');
    for (int i = 0; i < data.length; i++) {
      MemberModel model = MemberModel(
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

  Future<List<MemberModel>> getMemberData(int apartmentid) async {
    print(':::::::CALLED MEMBERLIST DATABASE QUERY::::::::::');
    List<MemberModel> verifyList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser AU inner join LST_Userlist U on AU.UserID = U.UserID inner join MST_Apartment A on AU.ApartmentID = A.ApartmentID where AU.ApartmentID == $apartmentid');
    print(':::::DATA:::::${data}');
    for (int i = 0; i < data.length; i++) {
      MemberModel model = MemberModel(
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
      print(':::::LENGTH:::::${verifyList.length}');
      verifyList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return verifyList;
  }

  Future<List<CollectionTypeModel>> getCollectionType() async {
    print(':::::::CALLED COLEECTION DATABASE QUERY::::::::::');
    List<CollectionTypeModel> TypeList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data =
        await db.rawQuery('select * from LST_Collection_type');
    CollectionTypeModel model = CollectionTypeModel(
        CollectionTypeID1: -1, CollectionType1: "Select type");
    TypeList.add(model);
    print(':::::DATA:::::${data}');
    for (int i = 0; i < data.length; i++) {
      model = CollectionTypeModel(
        CollectionTypeID1: data[i]['CollectionTypeID'] as int,
        CollectionType1: data[i]['CollectionType'].toString(),
      );
      print(':::::LENGTH:::::${TypeList.length}');
      TypeList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return TypeList;
  }

  Future<List<CollectionModel>> getCollectionData(int apartmentid) async {
    print(':::::::CALLED COLEECTION DATABASE QUERY::::::::::');
    List<CollectionModel> collectionList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from LST_Collection C inner join LST_Collection_type CT ON C.CollectionTypeID == CT.CollectionTypeID Inner Join LST_Userlist U ON C.UserID == U.UserID where ApartmentID = $apartmentid');
    print(':::::DATA:::::${data}');
    for (int i = 0; i < data.length; i++) {
      CollectionModel model = CollectionModel(
        CollectionID1: data[i]['CollectionID'] as int,
        CollectionTypeID1: data[i]['CollectionTypeID'] as int,
        CollectionType1: data[i]['CollectionType'].toString(),
        ApartmentID1: data[i]['ApartmentID'] as int,
        UserID1: data[i]['UserID'] as int,
        Amount1: data[i]['Amount'] as int,
        UserName1: data[i]['UserName'].toString(),
        Date1: data[i]['Date'].toString(),
      );

      model.CollectionID = data[i]['CollectionID'] as int;
      print(':::::LENGTH:::::${collectionList.length}');
      collectionList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return collectionList;
  }

  Future<List<TransactionModel>> getTransactionData(int apartmentid) async {
    print(':::::::CALLED TRANSACTION DATABASE QUERY::::::::::');
    List<TransactionModel> TransactionList = [];
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select T.*,U.UserName from LST_Transaction T Inner Join LST_Userlist U ON T.UserID == U.UserID where ApartmentID = $apartmentid');
    print(':::::DATA:::::${data}');
    for (int i = 0; i < data.length; i++) {
      TransactionModel model = TransactionModel(
        TansactionType1: data[i]['TypeOfTransaction'] as int,
        ApartmentID1: data[i]['ApartmentID'] as int,
        UserID1: data[i]['UserID'] as int,
        Amount1: data[i]['ExpanceAmount'] as int,
        UserName1: data[i]['UserName'].toString(),
        Date1: data[i]['Date'].toString(),
        Remark1: data[i]['Remark'].toString(),
      );

      model.TransactionID = data[i]['TransactionID'] as int;
      print(':::::LENGTH:::::${TransactionList.length}');
      TransactionList.add(model);
    }
    // print('USERLIST::::::::${userList}');
    return TransactionList;
  }

  Future<int> getTotalCollection(int apartmentid) async {
    Database db = await initDatabase();
    int sum = 0;
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from LST_Collection where ApartmentID=$apartmentid');
    print('data::::::::::::::::$data');

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        sum += data[i]['Amount'] as int;
      }
    } else {
      return 0;
    }

    return sum;
  }

  Future<int> getTotalTransaction(int apartmentid) async {
    Database db = await initDatabase();
    int sum = 0;
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from LST_Transaction where ApartmentID=$apartmentid');
    print('data::::::::::::::::$data');

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        sum += data[i]['ExpanceAmount'] as int;
      }
    } else {
      return 0;
    }

    return sum;
  }

  Future<int> getAdminOrNotFromTbl(int userid, int apartmentid) async {
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from Tbl_ApartmentWiseUser where UserID = "$userid"');

    if (data.isNotEmpty) {
      print("AparmentID::::${data[0]['ApartmentID']}");
      print("isVerified::::${data[0]['isVerified']}");
      if (data[0]['isAdmin'] == 1 && data[0]['ApartmentID'] == apartmentid) {
        return 1;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  }

  Future<UserModel?> getLoginDetail(String email, String password) async {
    print(':::::::::::::::Email:$email:::::pass');
    Database db = await initDatabase();
    List<Map<String, Object?>> data = await db.rawQuery(
        'select * from LST_Password P inner join LST_Userlist U on P.UserID = U.UserID where U.Email = "$email" and P.Password = "$password"');

    if (data.isNotEmpty) {
      print("Username::::${data[0]['Email']}");

      UserModel modelU = UserModel(
        UserID1: data[0]['UserID'] as int,
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

  Future<void> upsertIntoCollectionTable(
      {CollectionID, type, Amount, date, ApartmentID, UserID}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['CollectionTypeID'] = type;
    map['UserID'] = UserID;
    map['ApartmentID'] = ApartmentID;
    map['Amount'] = Amount;
    map['date'] = date;

    if (CollectionID != -1) {
      print('CALLING:::::UPDATE::::::');
      await db.update('LST_Collection', map,
          where: 'CollectionID = ?', whereArgs: [CollectionID]);
    } else {
      print('CALLING:::::INSERT::::::');
      await db.insert('LST_Collection', map);
    }
  }

  Future<void> upsertIntoTransactionTable(
      {TransactionID,
      TransactionType,
      Amount,
      date,
      remark,
      ApartmentID,
      UserID}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();
    print('TransactionID:::::::::$TransactionID');
    print('UserID:::::::::$UserID');
    print('type:::::::::$TransactionType');
    print('ApartmentID:::::::::$ApartmentID');
    print('Amount:::::::::$Amount');
    print('date:::::::::$date');
    print('remark:::::::::$remark');

    map['TypeOfTransaction'] = TransactionType;
    map['UserID'] = UserID;
    map['ApartmentID'] = ApartmentID;
    map['Remark'] = remark;
    map['ExpanceAmount'] = Amount;
    map['date'] = date;

    if (TransactionID != -1) {
      print('CALLING:::::UPDATE::::::');
      await db.update('LST_Transaction', map,
          where: 'TransactionID = ?', whereArgs: [TransactionID]);
    } else {
      print('CALLING:::::INSERT::::::');
      await db.insert('LST_Transaction', map);
    }
  }

  Future<int> upsertIntoApartmentTable(
      {ApartmentID, ApartmentName, Code, Wings, City}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = Map();

    map['ApartmentID'] = ApartmentID;
    map['ApartmentName'] = ApartmentName;
    map['ApartmentCode'] = Code;
    map['Wings'] = Wings;
    map['CityID'] = City;

    if (ApartmentID != null) {
      print('CALLING:::::UPDATE::::::');
      return await db.update('MST_Apartment', map,
          where: 'ApartmentID = ?', whereArgs: [ApartmentID]);
    } else {
      print('CALLING:::::INSERT::::::');
      return await db.insert('MST_Apartment', map);
    }
  }

  Future<void> upsertIntoPasswordTable({PasswordID, UserID, Password}) async {
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
      if (code == data[i]['ApartmentCode'].toString()) {
        print("COMPARISION::::${code == data[i]['ApartmentCode'].toString()}");
        print("isVerified::::${data[i]['isVerified']}");
        isMatch = data[i]['isVerified'] as int;
      }
    }

    if (data.isNotEmpty) {
      print("isMatch::::${isMatch}");
      if (isMatch == 1) {
        return 1;
      } else if (isMatch == 0) {
        return 2;
      } else {
        return 0;
      }
    } else {
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

  Future<int> deleteUserFromUserTable(userID) async {
    Database db = await initDatabase();
    int deletedid = await db.delete(
      'Tbl_ApartmentWiseUser',
      where: 'UserID = ?',
      whereArgs: [userID],
    );
    print('DELETEID:::::::::${deletedid}');
    return userID;
  }

  Future<int> deleteCollectionData(CollectionID) async {
    Database db = await initDatabase();
    int deletedid = await db.delete(
      'LST_Collection',
      where: 'CollectionID= ?',
      whereArgs: [CollectionID],
    );
    print('DELETEID:::::::::${deletedid}');
    return CollectionID;
  }

  Future<int> deleteTransactionData(TransactionID) async {
    Database db = await initDatabase();
    int deletedid = await db.delete(
      'LST_Transaction',
      where: 'TransactionID= ?',
      whereArgs: [TransactionID],
    );
    print('DELETEID:::::::::${deletedid}');
    return TransactionID;
  }

}
