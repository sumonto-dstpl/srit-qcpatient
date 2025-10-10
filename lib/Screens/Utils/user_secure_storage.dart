import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUserType = 'Official';
  static const _keyUsernameid = 'usernameid';
  static const _keyUsernameval = 'usernameval';
  static const _keyLogUsernameval = 'usernamevallog';
  static const _keyUseraddressval = 'useraddressval';
  static const _keyofficialpkval = 'userofficialpk';
  static const _keyofficepkval = 'userofficepk';
  static const _keyUserprofilepval = 'userprofilephotoval';
  static const _keyUserPhotoFlagval = 'userphotoflagval';
  static const _keyUserPhotoval = 'userphotoval';
  static const _keyAppVersionval = 'appversionnum';
  static const _keyNRStatuscodeval = 'NRStatuscode';
  static const _keyTokenvalue = 'Token';
  static const _keyTokenresetpasswordvalue = 'Token';
  static const _keyTokenrefreshvalue = 'RefreshToken';
  static const _keyChecklogin = 'IfLoggedin';
  static const _keyChecklogout = 'IfLoggedout';
  static const _keyCheckGuestlogin = 'IfGuestLoggedin';
  static const _keydashid = 'dashboardid';
  static const _keyIsFirstLaunchDone = 'isFirstLaunchDone';
  static const _keyAllUsers = 'all_users';


  static Future<void> setIsFirstLaunchDone(String value) async =>
      await _storage.write(key: _keyIsFirstLaunchDone, value: value);

  static Future<String?> getIsFirstLaunchDone() async =>
      await _storage.read(key: _keyIsFirstLaunchDone);

  static const _keydid = 'did';

  static Future setdid(String? didval) async =>
      await _storage.write(key: _keydid, value: didval);

  static Future<String?> getdid() async => await _storage.read(key: _keydid);

  static Future setUserType(String? usertypeval) async =>
      await _storage.write(key: _keyUserType, value: usertypeval);

  static Future<String?> getUserType() async =>
      await _storage.read(key: _keyUserType);

  static Future setUsernameid(String? username) async =>
      await _storage.write(key: _keyUsernameid, value: username);

  static Future<String?> getUsernameid() async =>
      await _storage.read(key: _keyUsernameid);

  static Future setUsernameval(String? usernameval) async =>
      await _storage.write(key: _keyUsernameval, value: usernameval);

  static Future<String?> getUsernameval() async =>
      await _storage.read(key: _keyUsernameval);

  static Future setLogUsernameval(String? usernamevallog) async =>
      await _storage.write(key: _keyLogUsernameval, value: usernamevallog);

  static Future<String?> getLogUsernameval() async =>
      await _storage.read(key: _keyLogUsernameval);

  static Future setUseraddressval(String? usernamevaladd) async =>
      await _storage.write(key: _keyUseraddressval, value: usernamevaladd);

  static Future<String?> getUseraddressval() async =>
      await _storage.read(key: _keyUseraddressval);

  static Future setofficialpkval(String? officialpkvaladd) async =>
      await _storage.write(key: _keyofficialpkval, value: officialpkvaladd);

  static Future<String?> getofficialpkval() async =>
      await _storage.read(key: _keyofficialpkval);

  static Future setofficepkval(String? officepkvaladd) async =>
      await _storage.write(key: _keyofficepkval, value: officepkvaladd);

  static Future<String?> getofficepkval() async =>
      await _storage.read(key: _keyofficepkval);

  static Future setUserProfilePval(String? Userprofilepval) async =>
      await _storage.write(key: _keyUserprofilepval, value: Userprofilepval);

  static Future<String?> getUserProfilePval() async =>
      await _storage.read(key: _keyUserprofilepval);

  static Future setUserPhotoFlagval(String userphotoflagval) async =>
      await _storage.write(key: _keyUserPhotoFlagval, value: userphotoflagval);

  static Future<String?> getUserPhotoFlagval() async =>
      await _storage.read(key: _keyUserPhotoFlagval);

  static Future setUserPhotoval(String userphotoval) async =>
      await _storage.write(key: _keyUserPhotoval, value: userphotoval);

  static Future<String?> getUserPhotoval() async =>
      await _storage.read(key: _keyUserPhotoval);

  static Future setAppVersionval(String userversionval) async =>
      await _storage.write(key: _keyAppVersionval, value: userversionval);

  static Future<String?> getAppVersionval() async =>
      await _storage.read(key: _keyAppVersionval);

  static Future setNRStatuscodeval(String NRStatuscodeval) async =>
      await _storage.write(key: _keyNRStatuscodeval, value: NRStatuscodeval);

  static Future<String?> getNRStatuscodeval() async =>
      await _storage.read(key: _keyNRStatuscodeval);

  static Future setTokenvalue(String Token) async =>
      await _storage.write(key: _keyTokenvalue, value: Token);

  static Future<String?> getTokenvalue() async =>
      await _storage.read(key: _keyTokenvalue);

  static Future setTokenResetPassvalue(String Token) async =>
      await _storage.write(key: _keyTokenresetpasswordvalue, value: Token);

  static Future<String?> getTokenResetPassvalue() async =>
      await _storage.read(key: _keyTokenresetpasswordvalue);

  static Future setRefreshTokenvalue(String RefreshToken) async =>
      await _storage.write(key: _keyTokenrefreshvalue, value: RefreshToken);

  static Future<String?> getRefreshTokenvalue() async =>
      await _storage.read(key: _keyTokenrefreshvalue);

  static Future setIfLogged(String IfLoggedin) async =>
      await _storage.write(key: _keyChecklogin, value: IfLoggedin);

  static Future<String?> getIfLogged() async =>
      await _storage.read(key: _keyChecklogin);

  // static Future setIfLoggedOut(String IfLoggedin) async =>
  //     await _storage.write(key: _keyChecklogout, value: IfLoggedin);
  //
  // static Future<String?> getIfLoggedOut() async =>
  //     await _storage.read(key: _keyChecklogout);

  static Future setIfGuestLogged(String IfGuestLoggedin) async =>
      await _storage.write(key: _keyCheckGuestlogin, value: IfGuestLoggedin);

  static Future<String?> getIfGuestLogged() async =>
      await _storage.read(key: _keyCheckGuestlogin);

  static Future setdashboardid(String dashboardidval) async =>
      await _storage.write(key: _keydashid, value: dashboardidval);

  static Future<String?> getdashboardid() async =>
      await _storage.read(key: _keydashid);

  static Future<void> saveUser({
    required String userId,
    required String mpin,
    required Map<String, String> userData,
  }) async {
    // Read existing users
    String? jsonString = await _storage.read(key: _keyAllUsers);
    Map<String, dynamic> allUsers = jsonString != null ? jsonDecode(jsonString) : {};

    // Add/update this user
    allUsers[userId] = {
      "mpin": mpin,
      "data": userData,
    };

    // Save back to storage
    await _storage.write(key: _keyAllUsers, value: jsonEncode(allUsers));
  }

  static Future<Map<String, dynamic>?> getUser(String userId) async {
    String? jsonString = await _storage.read(key: _keyAllUsers);
    print("jsonString: $jsonString");
    if (jsonString == null) return null;



    Map<String, dynamic> allUsers = jsonDecode(jsonString);
    print(allUsers[userId.trim()]);
    if (!allUsers.containsKey(userId.trim())) return null;

    return allUsers[userId.trim()]; // Returns {"mpin": "...", "data": {...}
  }

  static Future<bool> verifyUserMpin(String userId, String enteredMpin) async {
    final user = await getUser(userId);
    print("user: $user");
    if (user == null) return false;
    print("mpin: ${user['mpin']}");
    return user['mpin'] == enteredMpin;
  }

  // Update MPIN for an existing user
  static Future<void> updateUserMpin(String userId, String newMpin) async {
    // Get existing user
    Map<String, dynamic>? user = await getUser(userId);
    if (user == null) {
      print("User not found");
      return;
    }

    // Update the mpin
    user['mpin'] = newMpin;

    // Save back to storage
    String? allUsersJson = await _storage.read(key: _keyAllUsers);
    Map<String, dynamic> allUsers = allUsersJson != null ? jsonDecode(allUsersJson) : {};
    allUsers[userId] = user;

    await _storage.write(key: _keyAllUsers, value: jsonEncode(allUsers));
  }

  static Future<void> clearAllExceptUsers() async {
    final allKeys = await _storage.readAll();

    for (final key in allKeys.keys) {
      if (key != _keyAllUsers) {
        await _storage.delete(key: key);
      }
    }
  }




}
